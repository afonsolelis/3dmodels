#!/usr/bin/env python3
"""Assinatura de malha de STL binário: nº de triângulos, bbox, VOLUME (mm³) e
hash dos vértices ORDENADOS.

Serve pra dois usos no repo:
  - provar que uma interseção de duas peças é VAZIA (volume = 0) ou medir a
    interferência em mm³ quando não é;
  - comparar duas exportações da MESMA geometria sem cair na armadilha da
    ordem das facetas (que muda entre versões do OpenSCAD): compara-se
    triângulos + bbox + hash dos vértices ordenados, nunca `cmp`/`diff` cru.

uso: stlinfo.py arquivo.stl [outro.stl ...]
"""
import hashlib
import struct
import sys


def read_tris(path):
    with open(path, "rb") as f:
        data = f.read()
    if len(data) >= 84:
        n = struct.unpack_from("<I", data, 80)[0]
        if 84 + n * 50 == len(data) and data[:5] != b"solid":  # binário
            return [
                tuple(struct.unpack_from("<3f", data, 84 + i * 50 + 12 + j * 12)
                      for j in range(3))
                for i in range(n)
            ]
    # ASCII (é o default do OpenSCAD 2021.01 pra .stl)
    verts = []
    for line in data.decode("ascii", "replace").splitlines():
        p = line.split()
        if len(p) == 4 and p[0] == "vertex":
            verts.append(tuple(float(v) for v in p[1:]))
    return [tuple(verts[i:i + 3]) for i in range(0, len(verts) - 2, 3)]


def info(path):
    tris = read_tris(path)
    if not tris:
        return dict(n=0, vol=0.0, bbox=None, sig="vazio")
    vol = 0.0
    for a, b, c in tris:  # teorema da divergência: soma dos tetraedros com a origem
        vol += (
            a[0] * (b[1] * c[2] - b[2] * c[1])
            - a[1] * (b[0] * c[2] - b[2] * c[0])
            + a[2] * (b[0] * c[1] - b[1] * c[0])
        ) / 6.0
    vs = [v for t in tris for v in t]
    xs, ys, zs = zip(*vs)
    bbox = (max(xs) - min(xs), max(ys) - min(ys), max(zs) - min(zs))
    key = "".join("%.4f,%.4f,%.4f;" % v for v in sorted(vs))
    return dict(n=len(tris), vol=abs(vol), bbox=bbox,
                sig=hashlib.sha256(key.encode()).hexdigest()[:16])


for p in sys.argv[1:]:
    d = info(p)
    if d["bbox"] is None:
        print(f"{p}: MALHA VAZIA (0 triangulos, volume 0.000 mm3)")
    else:
        dx, dy, dz = d["bbox"]
        print(f"{p}: {d['n']} tri | bbox {dx:.2f} x {dy:.2f} x {dz:.2f} mm | "
              f"volume {d['vol']:.3f} mm3 ({d['vol']/1000:.2f} cm3) | vsig {d['sig']}")
