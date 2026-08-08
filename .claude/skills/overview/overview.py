#!/usr/bin/env python3
"""Monta um 3MF de visualização com várias peças numa grade.

uso: overview.py saida.3mf peca1.stl peca2.stl ... [--cell 180] [--cols 4]

Cada STL vira um OBJETO SEPARADO no 3MF (o Bambu Studio abre já dividido e
consegue distribuir nas plates sozinho), posicionado numa grade em que cada
célula tem o tamanho da cama da impressora.

Por que não fazer isso em OpenSCAD: reimportar STL e unir as malhas passa
pelo CGAL, que estoura com "assertion violation" em peça complexa por causa
da perda de precisão do round-trip. Aqui não há booleano nenhum — as malhas
são só copiadas e transladadas, então não tem o que dar errado.
"""
import struct
import sys
import zipfile

NS = "http://schemas.microsoft.com/3dmanufacturing/core/2015/02"


def read_stl(path):
    """Devolve (vertices, triangulos) a partir de um STL ASCII ou binário."""
    with open(path, "rb") as fh:
        data = fh.read()

    tris = []
    if data[:5] == b"solid" and b"facet" in data[:1000]:
        try:
            pts = []
            for line in data.decode("ascii", "strict").splitlines():
                p = line.split()
                if len(p) == 4 and p[0] == "vertex":
                    pts.append(tuple(float(v) for v in p[1:]))
            tris = [pts[i:i + 3] for i in range(0, len(pts) - 2, 3)]
        except (UnicodeDecodeError, ValueError):
            tris = []
    if not tris:
        n = struct.unpack_from("<I", data, 80)[0]
        for i in range(n):
            off = 84 + i * 50 + 12  # pula a normal
            tris.append([struct.unpack_from("<3f", data, off + j * 12)
                         for j in range(3)])

    index, verts, faces = {}, [], []
    for tri in tris:
        ids = []
        for v in tri:
            key = (round(v[0], 5), round(v[1], 5), round(v[2], 5))
            if key not in index:
                index[key] = len(verts)
                verts.append(key)
            ids.append(index[key])
        if len(set(ids)) == 3:  # descarta triângulo degenerado
            faces.append(ids)
    return verts, faces


def main():
    args = [a for a in sys.argv[1:]]
    cell, cols = 180.0, 4
    for flag, cast in (("--cell", float), ("--cols", int)):
        if flag in args:
            i = args.index(flag)
            globals()  # noqa
            value = cast(args[i + 1])
            del args[i:i + 2]
            if flag == "--cell":
                cell = value
            else:
                cols = value
    if len(args) < 2:
        print(__doc__.strip())
        sys.exit(1)

    out, sources = args[0], args[1:]
    objects, items = [], []

    for n, src in enumerate(sources):
        verts, faces = read_stl(src)
        oid = n + 1
        vx = "".join('<vertex x="%.5g" y="%.5g" z="%.5g"/>' % v for v in verts)
        tx = "".join('<triangle v1="%d" v2="%d" v3="%d"/>' % tuple(f)
                     for f in faces)
        objects.append(
            '<object id="%d" type="model" name="%s"><mesh>'
            "<vertices>%s</vertices><triangles>%s</triangles>"
            "</mesh></object>" % (oid, src.split("/")[-1], vx, tx))
        dx = (n % cols) * cell
        dy = (n // cols) * cell
        items.append('<item objectid="%d" transform="1 0 0 0 1 0 0 0 1 '
                     '%.5g %.5g 0"/>' % (oid, dx, dy))
        print("%-42s -> celula (%d, %d)  %d triangulos"
              % (src.split("/")[-1], n % cols, n // cols, len(faces)))

    model = ('<?xml version="1.0" encoding="UTF-8"?>'
             '<model unit="millimeter" xml:lang="en-US" xmlns="%s">'
             "<resources>%s</resources><build>%s</build></model>"
             % (NS, "".join(objects), "".join(items)))

    ctypes = ('<?xml version="1.0" encoding="UTF-8"?>'
              '<Types xmlns="http://schemas.openxmlformats.org/package/2006/'
              'content-types"><Default Extension="rels" ContentType='
              '"application/vnd.openxmlformats-package.relationships+xml"/>'
              '<Default Extension="model" ContentType="application/vnd.'
              'ms-package.3dmanufacturing-3dmodel+xml"/></Types>')

    rels = ('<?xml version="1.0" encoding="UTF-8"?>'
            '<Relationships xmlns="http://schemas.openxmlformats.org/package/'
            '2006/relationships"><Relationship Target="/3D/3dmodel.model" '
            'Id="rel0" Type="http://schemas.microsoft.com/3dmanufacturing/'
            '2013/01/3dmodel"/></Relationships>')

    with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as z:
        z.writestr("[Content_Types].xml", ctypes)
        z.writestr("_rels/.rels", rels)
        z.writestr("3D/3dmodel.model", model)
    print("\n%s: %d objetos, grade de %d colunas, celula de %gmm"
          % (out, len(sources), cols, cell))


main()
