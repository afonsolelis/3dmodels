#!/usr/bin/env python3
"""Monta um 3MF de PROJETO do Bambu Studio com varias plates numa so file.

uso: plates.py saida.3mf --plate "Nome da plate" peca.stl [peca2.stl ...] \
                         --plate "Outra plate" peca3.stl ... \
                         [--bed 180] [--usable 170] [--gap 5]

O 3MF cru que o OpenSCAD exporta so sabe de UMA chapa: pra imprimir 15 peças
o usuario abria 15 arquivos. Este aqui escreve o formato de PROJETO do Bambu
Studio, que guarda varias plates no mesmo arquivo — abre uma vez e imprime
plate por plate.

Como o formato funciona (engenharia reversa de diversos/Jabonera.3mf, que e
um projeto do Bambu Studio 02.07.01 pra A1 mini):

  3D/3dmodel.model            objetos + um <item> por peça, com a translacao
                              num espaco VIRTUAL onde cada plate ocupa uma
                              celula de `bed * 1.2` (180 -> 216mm)
  Metadata/model_settings.config   as tags <plate>, cada uma com plater_name
                              e a lista de object_id que vivem nela

  plate i (0-based): col = i % cols, row = i // cols, cols = ceil(sqrt(n))
  origem da plate  : (col * stride, -row * stride)   <- Y cresce pra BAIXO
  a peça fica centrada na cama: origem + (bed/2, bed/2)

Nao escrevemos Metadata/project_settings.config de proposito: sem ele o Bambu
Studio aplica o perfil de impressora/filamento que o usuario ja tem
selecionado, em vez de arrastar o perfil de outra pessoa junto.
"""
import math
import struct
import sys
import zipfile

NS = "http://schemas.microsoft.com/3dmanufacturing/core/2015/02"
STRIDE_RATIO = 1.2  # cama 180 -> celula 216, igual ao Bambu Studio


def read_stl(path):
    """Devolve (vertices, triangulos) a partir de um STL ASCII ou binario."""
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
        if len(set(ids)) == 3:  # descarta triangulo degenerado
            faces.append(ids)
    return verts, faces


def bbox(verts):
    xs, ys, zs = zip(*verts)
    return (min(xs), min(ys), min(zs)), (max(xs), max(ys), max(zs))


def shelf_pack(sizes, usable, gap):
    """Arruma retangulos em fileiras. Devolve (posicoes, largura, profundidade).

    Levanta ValueError se nao couber — melhor estourar aqui do que gerar uma
    plate com peça pra fora da cama, que o usuario so descobre no slicer.
    """
    pos, rows = [], []
    row, row_w, row_d, total_d = [], 0.0, 0.0, 0.0
    for i, (w, d) in enumerate(sizes):
        if w > usable or d > usable:
            raise ValueError("peça %d tem %.1fx%.1f, nao cabe em %gx%g"
                             % (i + 1, w, d, usable, usable))
        add = w if not row else row_w + gap + w
        if row and add > usable:
            rows.append((row, row_w, row_d))
            total_d += row_d + gap
            row, row_w, row_d = [], 0.0, 0.0
            add = w
        row.append((i, row_w if not row else row_w + gap))
        row_w = add
        row_d = max(row_d, d)
    rows.append((row, row_w, row_d))
    total_d += row_d

    if total_d > usable:
        raise ValueError("as peças somam %.1fmm de profundidade, passa de %g"
                         % (total_d, usable))

    width = max(r[1] for r in rows)
    y = 0.0
    slots = [None] * len(sizes)
    for row, row_w, row_d in rows:
        for i, x in row:
            slots[i] = (x, y)
        y += row_d + gap
    return slots, width, total_d


def parse_args(argv):
    out, plates, bed, usable, gap = None, [], 180.0, 170.0, 5.0
    i = 0
    while i < len(argv):
        a = argv[i]
        if a == "--plate":
            plates.append([argv[i + 1], []])
            i += 2
        elif a in ("--bed", "--usable", "--gap"):
            v = float(argv[i + 1])
            bed, usable, gap = (v, usable, gap) if a == "--bed" else \
                               (bed, v, gap) if a == "--usable" else (bed, usable, v)
            i += 2
        elif out is None:
            out = a
            i += 1
        else:
            if not plates:
                raise SystemExit("erro: peça '%s' antes do primeiro --plate" % a)
            plates[-1][1].append(a)
            i += 1
    if not out or not plates:
        raise SystemExit(__doc__.strip())
    for name, srcs in plates:
        if not srcs:
            raise SystemExit("erro: plate '%s' esta sem peça" % name)
    return out, plates, bed, usable, gap


def main():
    out, plates, bed, usable, gap = parse_args(sys.argv[1:])
    cols = math.ceil(math.sqrt(len(plates)))
    stride = bed * STRIDE_RATIO

    objects, items, cfg_objects, cfg_plates = [], [], [], []
    oid = 0

    for pi, (pname, srcs) in enumerate(plates):
        col, row = pi % cols, pi // cols
        ox, oy = col * stride, -row * stride

        meshes = [read_stl(s) for s in srcs]
        boxes = [bbox(v) for v, _ in meshes]
        sizes = [(hi[0] - lo[0], hi[1] - lo[1]) for lo, hi in boxes]
        try:
            slots, gw, gd = shelf_pack(sizes, usable, gap)
        except ValueError as e:
            raise SystemExit("plate %d (%s): %s" % (pi + 1, pname, e))

        gx0 = ox + (bed - gw) / 2.0
        gy0 = oy + (bed - gd) / 2.0
        ids = []

        for k, src in enumerate(srcs):
            verts, faces = meshes[k]
            lo, _ = boxes[k]
            oid += 1
            name = src.split("/")[-1]
            vx = "".join('<vertex x="%.5g" y="%.5g" z="%.5g"/>' % v
                         for v in verts)
            tx = "".join('<triangle v1="%d" v2="%d" v3="%d"/>' % tuple(f)
                         for f in faces)
            objects.append('<object id="%d" type="model" name="%s"><mesh>'
                           "<vertices>%s</vertices><triangles>%s</triangles>"
                           "</mesh></object>" % (oid, name, vx, tx))

            sx, sy = slots[k]
            dx = gx0 + sx - lo[0]
            dy = gy0 + sy - lo[1]
            dz = -lo[2]  # apoia na cama
            items.append('<item objectid="%d" transform="1 0 0 0 1 0 0 0 1 '
                         '%.5f %.5f %.5f" printable="1"/>' % (oid, dx, dy, dz))

            cfg_objects.append(
                '<object id="%d"><metadata key="name" value="%s"/>'
                '<metadata key="extruder" value="1"/>'
                '<part id="%d" subtype="normal_part">'
                '<metadata key="name" value="%s"/></part></object>'
                % (oid, name, oid, name))
            ids.append(oid)

        cfg_plates.append(
            "<plate>"
            '<metadata key="plater_id" value="%d"/>'
            '<metadata key="plater_name" value="%s"/>'
            '<metadata key="locked" value="false"/>'
            "%s</plate>"
            % (pi + 1, pname,
               "".join('<model_instance><metadata key="object_id" value="%d"/>'
                       '<metadata key="instance_id" value="0"/>'
                       "</model_instance>" % i for i in ids)))

        print("plate %2d  %-28s %s  (%.1f x %.1f na cama)"
              % (pi + 1, pname,
                 ", ".join(s.split("/")[-1] for s in srcs), gw, gd))

    model = ('<?xml version="1.0" encoding="UTF-8"?>'
             '<model unit="millimeter" xml:lang="en-US" xmlns="%s">'
             "<resources>%s</resources><build>%s</build></model>"
             % (NS, "".join(objects), "".join(items)))

    settings = ('<?xml version="1.0" encoding="UTF-8"?><config>%s%s</config>'
                % ("".join(cfg_objects), "".join(cfg_plates)))

    ctypes = ('<?xml version="1.0" encoding="UTF-8"?>'
              '<Types xmlns="http://schemas.openxmlformats.org/package/2006/'
              'content-types"><Default Extension="rels" ContentType='
              '"application/vnd.openxmlformats-package.relationships+xml"/>'
              '<Default Extension="model" ContentType="application/vnd.'
              'ms-package.3dmanufacturing-3dmodel+xml"/>'
              '<Default Extension="config" ContentType="application/xml"/>'
              "</Types>")

    rels = ('<?xml version="1.0" encoding="UTF-8"?>'
            '<Relationships xmlns="http://schemas.openxmlformats.org/package/'
            '2006/relationships"><Relationship Target="/3D/3dmodel.model" '
            'Id="rel0" Type="http://schemas.microsoft.com/3dmanufacturing/'
            '2013/01/3dmodel"/></Relationships>')

    with zipfile.ZipFile(out, "w", zipfile.ZIP_DEFLATED) as z:
        z.writestr("[Content_Types].xml", ctypes)
        z.writestr("_rels/.rels", rels)
        z.writestr("3D/3dmodel.model", model)
        z.writestr("Metadata/model_settings.config", settings)

    print("\n%s: %d plates, %d objetos, grade %dx%d de celula %gmm (cama %g)"
          % (out, len(plates), oid, cols,
             math.ceil(len(plates) / cols), stride, bed))


main()
