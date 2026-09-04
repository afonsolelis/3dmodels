#!/usr/bin/env python3
"""Monta um 3MF MULTICOLOR do Flash Studio: UM objeto com varias PECAS, cada
peca amarrada a um filamento do IFS.

uso: multicolor3mf.py saida.3mf --name "nome do objeto" \\
         --part corpo 1 stl/corpo.stl \\
         --part arte-amarelo 2 stl/cor1.stl ... \\
         [--colors "#F2EDE3,#E5CD2C,#CD321F,#3B2C2B"] [--bed 220]

Diferenca pro plates.py: la cada peca e' um OBJETO separado (pecas distintas
na mesma chapa); aqui todas as pecas sao PARTES DO MESMO objeto, que e' como
Orca/Flash Studio representa multimaterial. Uma parte = um filamento.

Formato (mesma engenharia reversa do plates.py, estendida para <components>):

  3D/3dmodel.model
      um <object> por malha de peca, mais um <object> "montagem" que so tem
      <components> apontando pras pecas; o <build> traz UM <item> da montagem
  Metadata/model_settings.config
      <object id="montagem"> com um <part id="N"> por peca, e o filamento em
      <metadata key="extruder">. O id da <part> e' o id do <object> da malha.

ORDEM DAS PECAS IMPORTA: onde duas se sobrepoem, a ULTIMA vence. As pecas de
arte afundam 0.05mm no corpo de proposito (pra fundir sem coplanaridade),
entao o corpo tem que vir ANTES delas.

COR: com --colors o script escreve um Metadata/project_settings.config MINIMO,
so com as chaves de filamento (filament_colour, filament_multi_colour,
filament_type, diametro e densidade). Sem esse arquivo o 3MF carrega apenas o
NUMERO do filamento e o card abre cinza no slicer -- foi assim na v1 e nao e'
o que se quer de um "3mf colorido".

Isso e' um desvio consciente da regra do plates.py, que manda NAO escrever
project_settings.config. A razao daquela regra era nao arrastar o perfil de
impressora/processo de outra pessoa (o Jabonera.3mf, por exemplo, vem com o
perfil de uma Anycubic Kobra 3 e camada de 0.1mm). Aqui nao escrevemos
NENHUMA chave de impressora, de processo ou de altura de camada: so cor e
material de filamento. O perfil de impressora que o usuario ja tem
selecionado continua valendo.

Conferido em projetos reais de 4 filamentos deste repo (diversos/
4floral_travel_pill_box_single_colour.3mf e Jabonera.3mf): o 3dmodel.model
deles NAO usa <basematerials> nem grupo de cor -- a cor vem so daquelas chaves.

CONFERIR NO FLASH STUDIO depois de gerar: o objeto tem que aparecer como um so,
com a lista de pecas, cada uma no filamento certo. O slicer nao roda headless
nesta maquina, entao este passo e' seu.
"""
import json
import struct
import sys
import zipfile

NS = "http://schemas.microsoft.com/3dmanufacturing/core/2015/02"


def read_stl(path):
    """(vertices, faces) de um STL ASCII ou binario, com vertices unificados."""
    data = open(path, "rb").read()
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
        tris = [[struct.unpack_from("<3f", data, 84 + i * 50 + 12 + j * 12)
                 for j in range(3)] for i in range(n)]

    index, verts, faces = {}, [], []
    for tri in tris:
        ids = []
        for v in tri:
            key = (round(v[0], 5), round(v[1], 5), round(v[2], 5))
            if key not in index:
                index[key] = len(verts)
                verts.append(key)
            ids.append(index[key])
        if len(set(ids)) == 3:
            faces.append(ids)
    return verts, faces


def parse_args(argv):
    out, name, parts, bed, colors = None, "objeto", [], 220.0, []
    i = 0
    while i < len(argv):
        a = argv[i]
        if a == "--colors":
            colors = [c.strip().upper() for c in argv[i + 1].split(",")]
            i += 2
        elif a == "--part":
            parts.append((argv[i + 1], int(argv[i + 2]), argv[i + 3]))
            i += 4
        elif a == "--name":
            name = argv[i + 1]; i += 2
        elif a == "--bed":
            bed = float(argv[i + 1]); i += 2
        elif out is None:
            out = a; i += 1
        else:
            raise SystemExit("argumento nao entendido: " + a)
    if not out or not parts:
        raise SystemExit(__doc__.strip())
    need = max(e for _, e, _ in parts)
    if colors and len(colors) < need:
        raise SystemExit("erro: %d cores para %d filamentos usados pelas pecas"
                         % (len(colors), need))
    for c in colors:
        if not (len(c) == 7 and c[0] == "#" and all(k in "0123456789ABCDEF"
                                                    for k in c[1:])):
            raise SystemExit("erro: cor '%s' nao esta no formato #RRGGBB" % c)
    return out, name, parts, bed, colors


def main():
    out, name, parts, bed, colors = parse_args(sys.argv[1:])

    meshes = [read_stl(src) for _, _, src in parts]
    allv = [v for verts, _ in meshes for v in verts]
    lo = [min(v[i] for v in allv) for i in range(3)]
    hi = [max(v[i] for v in allv) for i in range(3)]
    # centra o conjunto na cama e apoia em z=0
    dx = (bed - (hi[0] - lo[0])) / 2.0 - lo[0]
    dy = (bed - (hi[1] - lo[1])) / 2.0 - lo[1]
    dz = -lo[2]

    objects, comps, cfg_parts = [], [], []
    for k, (pname, extruder, src) in enumerate(parts):
        oid = k + 1
        verts, faces = meshes[k]
        vx = "".join('<vertex x="%.5g" y="%.5g" z="%.5g"/>' % v for v in verts)
        tx = "".join('<triangle v1="%d" v2="%d" v3="%d"/>' % tuple(f)
                     for f in faces)
        objects.append('<object id="%d" type="model" name="%s"><mesh>'
                       "<vertices>%s</vertices><triangles>%s</triangles>"
                       "</mesh></object>" % (oid, pname, vx, tx))
        comps.append('<component objectid="%d" transform="1 0 0 0 1 0 0 0 1 '
                     '0 0 0"/>' % oid)
        cfg_parts.append('<part id="%d" subtype="normal_part">'
                         '<metadata key="name" value="%s"/>'
                         '<metadata key="extruder" value="%d"/></part>'
                         % (oid, pname, extruder))
        print("  peca %d  %-22s filamento %d  %6d tri  %s"
              % (oid, pname, extruder, len(faces), src.split("/")[-1]))

    aid = len(parts) + 1
    objects.append('<object id="%d" type="model" name="%s"><components>%s'
                   "</components></object>" % (aid, name, "".join(comps)))

    model = ('<?xml version="1.0" encoding="UTF-8"?>'
             '<model unit="millimeter" xml:lang="en-US" xmlns="%s">'
             "<resources>%s</resources>"
             '<build><item objectid="%d" transform="1 0 0 0 1 0 0 0 1 '
             '%.5f %.5f %.5f" printable="1"/></build></model>'
             % (NS, "".join(objects), aid, dx, dy, dz))

    settings = ('<?xml version="1.0" encoding="UTF-8"?><config>'
                '<object id="%d"><metadata key="name" value="%s"/>'
                '<metadata key="extruder" value="%d"/>%s</object>'
                "<plate>"
                '<metadata key="plater_id" value="1"/>'
                '<metadata key="plater_name" value="%s"/>'
                '<metadata key="locked" value="false"/>'
                '<model_instance><metadata key="object_id" value="%d"/>'
                '<metadata key="instance_id" value="0"/></model_instance>'
                "</plate></config>"
                % (aid, name, parts[0][1], "".join(cfg_parts), name, aid))

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
        if colors:
            n = len(colors)
            proj = {
                "filament_colour": colors,
                "filament_multi_colour": colors,
                "filament_type": ["PLA"] * n,
                "filament_diameter": ["1.75"] * n,
                "filament_density": ["1.24"] * n,
                "filament_self_index": [str(k + 1) for k in range(n)],
            }
            z.writestr("Metadata/project_settings.config",
                       json.dumps(proj, indent=4, ensure_ascii=False))

    if colors:
        print("\n  cores gravadas no project_settings.config (so filamento, "
              "nenhuma chave de impressora):")
        for k, c in enumerate(colors, 1):
            usados = [p[0] for p in parts if p[1] == k]
            print("    filamento %d  %s  %s" % (k, c, ", ".join(usados) or "(nao usado)"))
    else:
        print("\n  SEM --colors: o 3MF carrega so o numero do filamento e vai "
              "abrir cinza no slicer")

    print("\n%s: %d pecas, %d filamentos, conjunto %.1f x %.1f x %.1f mm"
          % (out, len(parts), len({p[1] for p in parts}),
             hi[0] - lo[0], hi[1] - lo[1], hi[2] - lo[2]))
    print("  posicionado em +%.2f, +%.2f, %.2f (centrado na cama de %g)"
          % (dx, dy, dz, bed))


main()
