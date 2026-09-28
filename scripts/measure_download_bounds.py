#!/usr/bin/env python3
"""Confere dimensões das malhas de terceiros na orientação salva no 3MF/STL.

Mede cada objeto imprimível após aplicar as transformações dos componentes e
da montagem 3MF. A checagem de cama é individual; não avalia o arranjo de
objetos nas plates do fatiador.
"""

import argparse
import json
import struct
import zipfile
from collections import defaultdict
from pathlib import Path
from xml.parsers import expat

ROOT = Path(__file__).resolve().parent.parent
UNITS = {"millimeter": 1, "micron": 0.001, "centimeter": 10,
         "meter": 1000, "inch": 25.4, "foot": 304.8}


def bounds_add(bounds, x, y, z):
    if bounds is None:
        return [x, y, z, x, y, z]
    bounds[0] = min(bounds[0], x)
    bounds[1] = min(bounds[1], y)
    bounds[2] = min(bounds[2], z)
    bounds[3] = max(bounds[3], x)
    bounds[4] = max(bounds[4], y)
    bounds[5] = max(bounds[5], z)
    return bounds


def parse_transform(source):
    if not source:
        return (1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0)
    values = tuple(float(value) for value in source.split())
    if len(values) != 12:
        raise ValueError(f"Transformação 3MF inválida: {source}")
    return values


def bounds_stl(path):
    data = path.read_bytes()
    bounds = None
    if len(data) >= 84 and len(data) == 84 + 50 * struct.unpack("<I", data[80:84])[0]:
        count = struct.unpack("<I", data[80:84])[0]
        for index in range(count):
            chunk = data[84 + index * 50:84 + (index + 1) * 50]
            values = struct.unpack("<12fH", chunk)
            for offset in (3, 6, 9):
                bounds = bounds_add(bounds, *values[offset:offset + 3])
    else:
        for line in data.decode("utf-8", errors="replace").splitlines():
            parts = line.split()
            if len(parts) == 4 and parts[0].lower() == "vertex":
                bounds = bounds_add(bounds, *(float(value) for value in parts[1:]))
    return [bounds] if bounds else []


def local(name):
    return name.split(":")[-1]


def read_xml(stream, parser):
    while block := stream.read(1 << 20):
        parser.Parse(block, False)
    parser.Parse(b"", True)


def graph_model(stream):
    unit = 1.0
    objects = {}
    build = []
    current = None
    parser = expat.ParserCreate()

    def start(name, attrs):
        nonlocal unit, current
        name = local(name)
        if name == "model":
            unit = UNITS[attrs.get("unit", "millimeter")]
        elif name == "object":
            current = {"components": [], "mesh": False}
            objects[attrs["id"]] = current
        elif name == "mesh" and current is not None:
            current["mesh"] = True
        elif name == "component" and current is not None:
            path = next((value for key, value in attrs.items() if local(key) == "path"), None)
            current["components"].append((path, attrs["objectid"], parse_transform(attrs.get("transform"))))
        elif name == "item":
            build.append((attrs["objectid"], parse_transform(attrs.get("transform")), attrs.get("printable") != "0"))

    def end(name):
        nonlocal current
        if local(name) == "object":
            current = None

    parser.StartElementHandler = start
    parser.EndElementHandler = end
    read_xml(stream, parser)
    return unit, objects, build


def transform_point(point, transform):
    x, y, z = point
    t = transform
    return (x*t[0]+y*t[3]+z*t[6]+t[9],
            x*t[1]+y*t[4]+z*t[7]+t[10],
            x*t[2]+y*t[5]+z*t[8]+t[11])


def mesh_boxes(path):
    with zipfile.ZipFile(path) as archive:
        model_names = [name for name in archive.namelist() if name.lower().endswith(".model")]
        graph = {}
        for name in model_names:
            with archive.open(name) as stream:
                graph["/"+name] = graph_model(stream)
        root = graph.get("/3D/3dmodel.model")
        if root is None:
            raise ValueError("Missing /3D/3dmodel.model")
        build = root[2]
        references = defaultdict(lambda: defaultdict(list))

        def visit(modelpath, object_id, part_idx, chain, visited):
            key = (modelpath, object_id)
            if key in visited:
                raise ValueError(f"Recursive 3MF component {key}")
            if modelpath not in graph:
                raise KeyError(modelpath)
            obj = graph[modelpath][1].get(object_id)
            if obj is None:
                raise KeyError(key)
            if obj["mesh"]:
                references[modelpath][object_id].append((part_idx, chain))
            for child_path, child_id, t in obj["components"]:
                child_path = child_path or modelpath
                if not child_path.startswith("/"):
                    child_path = "/" + child_path
                visit(child_path, child_id, part_idx, [t]+chain, visited | {key})

        for i, (object_id, t, printable) in enumerate(build):
            if printable:
                visit("/3D/3dmodel.model", object_id, i, [t], frozenset())

        boxes = [None] * len(build)
        for modelpath, by_object in references.items():
            unit = graph[modelpath][0]
            current = None
            parser = expat.ParserCreate()

            def start(name, attrs):
                nonlocal current
                name = local(name)
                if name == "object":
                    current = attrs["id"]
                elif name == "vertex" and current in by_object:
                    point = (float(attrs["x"])*unit, float(attrs["y"])*unit, float(attrs["z"])*unit)
                    for part_idx, chain in by_object[current]:
                        transformed = point
                        for t in chain:
                            transformed = transform_point(transformed, t)
                        boxes[part_idx] = bounds_add(boxes[part_idx], *transformed)

            def end(name):
                nonlocal current
                if local(name) == "object":
                    current = None

            parser.StartElementHandler = start
            parser.EndElementHandler = end
            with archive.open(modelpath.lstrip("/")) as stream:
                read_xml(stream, parser)
        return [b for b in boxes if b is not None]


def result(item):
    path = ROOT/item["file"]
    boxes = mesh_boxes(path) if path.suffix.lower() == ".3mf" else bounds_stl(path)
    if not boxes:
        raise ValueError(f"No printable geometry: {path}")
    sizes = [[round(b[3]-b[0], 2), round(b[4]-b[1], 2), round(b[5]-b[2], 2)] for b in boxes]
    largest = max(sizes, key=lambda s: s[0]*s[1]*s[2])
    fits = all(all(v <= 220.01 for v in size) for size in sizes)
    return {"file": item["file"], "original_file": item["original_file"],
            "parts": len(sizes), "largest_part_mm": largest,
            "fits_ad5x": fits, "max_dimensions_mm": [max(s[i] for s in sizes) for i in range(3)],
            "known": item.get("largest_part_mm")}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--sample", action="store_true", help="mede só alguns arquivos conhecidos")
    parser.add_argument("--check", action="store_true", help="falha se index.json divergir das malhas")
    args = parser.parse_args()
    catalog = json.loads((ROOT/"index.json").read_text())
    items = catalog["third_party"]
    if args.sample:
        names = {"diversos/controller_stand_x4.3mf", "organizadores/organizador_vinis.3mf",
                 "diversos/Jabonera.3mf", "diversos/2x3.3mf"}
        items = [item for item in items if item["original_file"] in names]
    failures = []
    for i, item in enumerate(items, 1):
        try:
            measured = result(item)
            stored = item.get("largest_part_mm")
            if stored is None or max(abs(a - b) for a, b in zip(stored, measured["largest_part_mm"])) > 0.02:
                failures.append(f"{item['file']}: dimensão {stored} != {measured['largest_part_mm']}")
            if item.get("fits_ad5x") != measured["fits_ad5x"]:
                failures.append(f"{item['file']}: fits_ad5x {item.get('fits_ad5x')} != {measured['fits_ad5x']}")
            if not args.check:
                print(f"{i}/{len(items)} {item['file']} {measured['largest_part_mm']} AD5X={measured['fits_ad5x']}", flush=True)
            elif i % 20 == 0 or i == len(items):
                print(f"{i}/{len(items)} medidos", flush=True)
        except Exception as e:
            failures.append(f"{item['file']}: {e}")
    if failures:
        print("\n".join(failures))
        raise SystemExit(1)
    print(f"{len(items)} arquivos conferidos com index.json.", flush=True)


if __name__ == "__main__":
    main()
