#!/usr/bin/env python3
"""Monta os tres jobs 3MF do xadrez-01 para a AD5X.

Usa somente a biblioteca padrao para manter o projeto reproduzivel.

  job 1  tabuleiro BICOLOR: dois corpos de cor numa montagem unica, porque
         as 32 casas escuras PRECISAM nascer alinhadas com a laje clara.
  job 2  16 pecas CLARAS   -> uma cor so
  job 3  16 pecas ESCURAS  -> uma cor so, mesma malha do job 2

As pecas sairam do job bicolor em 2026-08-28: as duas cores sao solidos
disjuntos, entao dividir chapa so pagava purga (~320 mm3 por troca x 230
camadas = ~89 g de purga para ~44 g de peca).
"""

from __future__ import annotations

import io
import re
import struct
import zipfile
from pathlib import Path
from xml.sax.saxutils import escape


ROOT = Path(__file__).resolve().parent
ARMY_STL = ROOT / "stl" / "xadrez-01-exercito.stl"
JOBS = (
    {
        "output": ROOT / "3mf" / "xadrez-01-tabuleiro-bicolor.3mf",
        "title": "Xadrez 01 - tabuleiro bicolor - AD5X",
        "plate": "Tabuleiro bicolor 168 mm",
        "assembly": "XADREZ_01__TABULEIRO_BICOLOR",
        "description": ("Job 1: tabuleiro deitado, dois corpos de cor numa "
                        "montagem unica. Sem suporte; brim recomendado."),
        "meshes": (
            {"path": ROOT / "stl" / "xadrez-01-tabuleiro-claro.stl",
             "name": "COR_1_CLARA__BASE_DO_TABULEIRO",
             "label": "COR 1 CLARA - laje do tabuleiro", "material": 0},
            {"path": ROOT / "stl" / "xadrez-01-tabuleiro-escuro.stl",
             "name": "COR_2_ESCURA__32_CASAS",
             "label": "COR 2 ESCURA - 32 casas de 0.6mm", "material": 1},
        ),
    },
    {
        "output": ROOT / "3mf" / "xadrez-01-pecas-claras.3mf",
        "title": "Xadrez 01 - 16 pecas claras - AD5X",
        "plate": "16 pecas claras 4x4",
        "assembly": "XADREZ_01__16_PECAS_CLARAS",
        "description": ("Job 2: 16 pecas em pe numa cor so, arranjo 4x4 a "
                        "passo 20 mm. Sem suporte e sem troca de filamento."),
        "meshes": (
            {"path": ARMY_STL, "name": "COR_1_CLARA__16_PECAS",
             "label": "COR 1 CLARA - 16 pecas", "material": 0},
        ),
    },
    {
        "output": ROOT / "3mf" / "xadrez-01-pecas-escuras.3mf",
        "title": "Xadrez 01 - 16 pecas escuras - AD5X",
        "plate": "16 pecas escuras 4x4",
        "assembly": "XADREZ_01__16_PECAS_ESCURAS",
        "description": ("Job 3: 16 pecas em pe numa cor so, arranjo 4x4 a "
                        "passo 20 mm. Mesma malha do job 2, outro filamento."),
        "meshes": (
            {"path": ARMY_STL, "name": "COR_2_ESCURA__16_PECAS",
             "label": "COR 2 ESCURA - 16 pecas", "material": 1},
        ),
    },
)

FLOAT = r"[-+]?(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][-+]?\d+)?"
VERTEX_RE = re.compile(
    rf"\bvertex\s+({FLOAT})\s+({FLOAT})\s+({FLOAT})", re.IGNORECASE
)


def load_stl(path: Path) -> list[tuple[tuple[float, float, float], ...]]:
    data = path.read_bytes()
    if len(data) >= 84:
        count = struct.unpack_from("<I", data, 80)[0]
        if 84 + count * 50 == len(data):
            triangles = []
            offset = 84
            for _ in range(count):
                values = struct.unpack_from("<12fH", data, offset)
                triangles.append(
                    (
                        (values[3], values[4], values[5]),
                        (values[6], values[7], values[8]),
                        (values[9], values[10], values[11]),
                    )
                )
                offset += 50
            return triangles

    text = data.decode("utf-8", errors="strict")
    vertices = [tuple(map(float, match)) for match in VERTEX_RE.findall(text)]
    if not vertices or len(vertices) % 3:
        raise ValueError(f"STL ASCII invalido ou vazio: {path}")
    return [tuple(vertices[i : i + 3]) for i in range(0, len(vertices), 3)]


def indexed_mesh(triangles):
    vertices: list[tuple[float, float, float]] = []
    indices: dict[tuple[float, float, float], int] = {}
    faces = []
    for triangle in triangles:
        face = []
        for vertex in triangle:
            # OpenSCAD ja quantiza o STL; arredondar elimina apenas -0.0 e
            # diferencas textuais, sem mover a malha em escala de impressao.
            key = tuple(0.0 if abs(value) < 5e-8 else round(value, 7)
                        for value in vertex)
            if key not in indices:
                indices[key] = len(vertices)
                vertices.append(key)
            face.append(indices[key])
        faces.append(tuple(face))
    return vertices, faces


def fmt(value: float) -> str:
    text = f"{value + 0.0:.7f}".rstrip("0").rstrip(".") or "0"
    return "0" if text in ("-0", "") else text


def bed_transform(meshes, bed=220.0):
    """Translacao que centraliza a montagem na cama e assenta a base em z=0.

    No 3MF a origem do sistema e o CANTO do volume de impressao, nao o centro.
    Como os STLs saem do OpenSCAD centrados na origem, sem isto metade do job
    nasce em coordenada negativa.
    """
    pts = [v for mesh in meshes for v in mesh["vertices"]]
    xs, ys, zs = zip(*pts)
    tx = bed / 2 - (min(xs) + max(xs)) / 2
    ty = bed / 2 - (min(ys) + max(ys)) / 2
    tz = -min(zs)
    return tx, ty, tz


def model_xml(job, meshes) -> bytes:
    out = io.StringIO()
    out.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    out.write(
        '<model xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02" '
        'xmlns:m="http://schemas.microsoft.com/3dmanufacturing/material/2015/02" '
        'xmlns:BambuStudio="http://schemas.bambulab.com/package/2021" '
        'unit="millimeter" xml:lang="pt-BR">\n'
    )
    out.write('  <metadata name="BambuStudio:3mfVersion">1</metadata>\n')
    out.write(f'  <metadata name="Title">{escape(job["title"])}</metadata>\n')
    out.write('  <metadata name="Designer">afonsolelis</metadata>\n')
    out.write(
        f'  <metadata name="Description">{escape(job["description"])}'
        '</metadata>\n'
    )
    out.write('  <metadata name="CreationDate">2026-08-28</metadata>\n')
    out.write('  <resources>\n')
    out.write('    <m:basematerials id="1">\n')
    out.write('      <m:base name="COR 1 - clara" displaycolor="#F2E8D5FF"/>\n')
    out.write('      <m:base name="COR 2 - escura" displaycolor="#202124FF"/>\n')
    out.write('    </m:basematerials>\n')

    for object_id, mesh in enumerate(meshes, start=2):
        out.write(
            f'    <object id="{object_id}" type="model" '
            f'name="{escape(mesh["name"])}" pid="1" '
            f'pindex="{mesh["material"]}">\n'
        )
        out.write('      <mesh>\n        <vertices>\n')
        for x, y, z in mesh["vertices"]:
            out.write(
                f'          <vertex x="{fmt(x)}" y="{fmt(y)}" '
                f'z="{fmt(z)}"/>\n'
            )
        out.write('        </vertices>\n        <triangles>\n')
        for v1, v2, v3 in mesh["faces"]:
            out.write(f'          <triangle v1="{v1}" v2="{v2}" v3="{v3}"/>\n')
        out.write('        </triangles>\n      </mesh>\n    </object>\n')

    # Um unico item de build impede que fatiadores auto-organizem/recentrem
    # os corpos separadamente. Os filhos continuam selecionaveis como
    # componentes e mantem seus materiais-base. Num job de uma cor so ele
    # tambem serve: as 16 pecas viram UM objeto de build com 16 ilhas, que e
    # o que faz o brim do Orca nascer em volta de cada base.
    assembly_id = 2 + len(meshes)
    out.write(
        f'    <object id="{assembly_id}" type="model" '
        f'name="{escape(job["assembly"])}">\n'
    )
    out.write('      <components>\n')
    for object_id in range(2, assembly_id):
        out.write(f'        <component objectid="{object_id}"/>\n')
    out.write('      </components>\n    </object>\n')
    out.write('  </resources>\n  <build>\n')
    tx, ty, tz = bed_transform(meshes)
    out.write(
        f'    <item objectid="{assembly_id}" '
        f'transform="1 0 0 0 1 0 0 0 1 {fmt(tx)} {fmt(ty)} {fmt(tz)}"/>\n'
    )
    out.write('  </build>\n</model>\n')
    return out.getvalue().encode("utf-8")


CONTENT_TYPES = b"""<?xml version="1.0" encoding="UTF-8"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="model" ContentType="application/vnd.ms-package.3dmanufacturing-3dmodel+xml"/>
</Types>
"""

RELATIONSHIPS = b"""<?xml version="1.0" encoding="UTF-8"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Target="/3D/3dmodel.model" Id="rel0" Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel"/>
</Relationships>
"""


def model_settings_xml(job, meshes, source_name: str) -> bytes:
    """Metadados de volumes usados por Orca / Flash Studio Desktop.

    A montagem e o objeto 2+len(meshes); os ids 2.. sao os corpos. O valor de
    extrusor e 1-based nesses fatiadores, entao material 0 -> extrusor 1.
    """
    assembly_id = 2 + len(meshes)
    parts = []
    for index, mesh in enumerate(meshes):
        parts.append(
            f'    <part id="{2 + index}" subtype="normal_part">\n'
            f'      <metadata key="name" value="{escape(mesh["label"])}"/>\n'
            f'      <metadata key="extruder" value="{mesh["material"] + 1}"/>\n'
            '      <metadata key="matrix" '
            'value="1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1"/>\n'
            f'      <metadata key="source_file" value="{escape(source_name)}"/>\n'
            '      <metadata key="source_object_id" value="0"/>\n'
            f'      <metadata key="source_volume_id" value="{index}"/>\n'
            '      <mesh_stat edges_fixed="0" degenerate_facets="0" '
            'facets_removed="0" facets_reversed="0" backwards_edges="0"/>\n'
            '    </part>\n'
        )

    return f"""<?xml version="1.0" encoding="UTF-8"?>
<config>
  <object id="{assembly_id}">
    <metadata key="name" value="{escape(job["assembly"])}"/>
    <metadata key="extruder" value="0"/>
{"".join(parts)}  </object>
  <plate>
    <metadata key="plater_id" value="1"/>
    <metadata key="plater_name" value="{escape(job["plate"])}"/>
    <metadata key="locked" value="false"/>
    <model_instance>
      <metadata key="object_id" value="{assembly_id}"/>
      <metadata key="instance_id" value="0"/>
    </model_instance>
  </plate>
  <assemble>
  </assemble>
</config>
""".encode("utf-8")


def zip_write(archive: zipfile.ZipFile, name: str, data: bytes) -> None:
    info = zipfile.ZipInfo(name, date_time=(1980, 1, 1, 0, 0, 0))
    info.compress_type = zipfile.ZIP_DEFLATED
    info.external_attr = 0o644 << 16
    archive.writestr(info, data)


def bbox(vertices):
    axes = list(zip(*vertices))
    return tuple(max(axis) - min(axis) for axis in axes)


def main() -> None:
    for job in JOBS:
        meshes = []
        for spec in job["meshes"]:
            if not spec["path"].is_file():
                raise SystemExit(f"Falta exportar: {spec['path'].relative_to(ROOT)}")
            vertices, faces = indexed_mesh(load_stl(spec["path"]))
            meshes.append({**spec, "vertices": vertices, "faces": faces})

        output = job["output"]
        output.parent.mkdir(parents=True, exist_ok=True)
        with zipfile.ZipFile(output, "w") as archive:
            zip_write(archive, "[Content_Types].xml", CONTENT_TYPES)
            zip_write(archive, "_rels/.rels", RELATIONSHIPS)
            zip_write(archive, "3D/3dmodel.model", model_xml(job, meshes))
            zip_write(archive, "Metadata/model_settings.config",
                      model_settings_xml(job, meshes, output.name))

        all_vertices = [v for mesh in meshes for v in mesh["vertices"]]
        size = bbox(all_vertices)
        print(f"criado: {output.relative_to(ROOT)}")
        print(f"item de placa: 1 conjunto; corpos: {len(meshes)}; cores usadas: {len({m['material'] for m in meshes})}")
        print(f"triangulos: {sum(len(mesh['faces']) for mesh in meshes)}")
        print(f"envelope: {size[0]:.2f} x {size[1]:.2f} x {size[2]:.2f} mm")


if __name__ == "__main__":
    main()
