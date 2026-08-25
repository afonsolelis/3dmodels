#!/usr/bin/env python3
"""Bounding box de STLs (binário ou ASCII) + veredito pra cama FlashForge AD5X.

uso: bbox.py arquivo.stl [outro.stl ...]
sai com código 2 se algum arquivo estourar a cama (>220 em qualquer eixo).
"""
import struct
import sys

BED = 220.0      # cama da AD5X (mm)
COMFORT = 210.0  # alvo com margem pra brim/skirt (mm)


def bbox(path):
    with open(path, "rb") as f:
        data = f.read()
    verts = []
    if data[:5] == b"solid" and b"facet" in data[:1000]:
        try:
            for line in data.decode("ascii").splitlines():
                parts = line.split()
                if len(parts) == 4 and parts[0] == "vertex":
                    verts.append(tuple(float(v) for v in parts[1:]))
        except (UnicodeDecodeError, ValueError):
            verts = []
    if not verts:  # binário (ou ASCII quebrado)
        n = struct.unpack_from("<I", data, 80)[0]
        for i in range(n):
            off = 84 + i * 50 + 12  # pula a normal
            for j in range(3):
                verts.append(struct.unpack_from("<3f", data, off + j * 12))
    xs, ys, zs = zip(*verts)
    return max(xs) - min(xs), max(ys) - min(ys), max(zs) - min(zs)


def main():
    if len(sys.argv) < 2:
        print(__doc__.strip())
        sys.exit(1)
    fail = False
    for path in sys.argv[1:]:
        dx, dy, dz = bbox(path)
        if max(dx, dy, dz) > BED:
            verdict, fail = "REPROVADO (estoura a cama de 220)", True
        elif dx > COMFORT or dy > COMFORT:
            verdict = "justo (210-220: brim/skirt podem nao caber)"
        else:
            verdict = "ok"
        print(f"{path}: {dx:.1f} x {dy:.1f} x {dz:.1f} mm -> {verdict}")
    sys.exit(2 if fail else 0)


main()
