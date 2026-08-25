#!/usr/bin/env python3
"""Monta o 3MF bicolor padrao a partir dos dois STLs da placa.

Usa somente a biblioteca padrao para manter o projeto reproduzivel. O 3MF
resultante tem dois objetos nomeados e dois materiais-base; fatiadores que
nao importam a cor visual ainda preservam os corpos separados para atribuicao
manual aos dois slots do CFS.
"""

from __future__ import annotations

import io
import re
import struct
import zipfile
from pathlib import Path
from xml.sax.saxutils import escape


ROOT = Path(__file__).resolve().parent
OUTPUT = ROOT / "3mf" / "xadrez-01-placa-bicolor.3mf"

MESHES = (
    {
        "path": ROOT / "stl" / "xadrez-01-cor-1-clara.stl",
        "name": "COR_1_CLARA__TABULEIRO_E_16_PECAS",
        "material": 0,
    },
    {
        "path": ROOT / "stl" / "xadrez-01-cor-2-escura.stl",
        "name": "COR_2_ESCURA__CASAS_E_16_PECAS",
        "material": 1,
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
    return f"{value:.7f}".rstrip("0").rstrip(".") or "0"


def model_xml(meshes) -> bytes:
    out = io.StringIO()
    out.write('<?xml version="1.0" encoding="UTF-8"?>\n')
    out.write(
        '<model xmlns="http://schemas.microsoft.com/3dmanufacturing/core/2015/02" '
        'xmlns:m="http://schemas.microsoft.com/3dmanufacturing/material/2015/02" '
        'xmlns:BambuStudio="http://schemas.bambulab.com/package/2021" '
        'unit="millimeter" xml:lang="pt-BR" requiredextensions="m">\n'
    )
    out.write('  <metadata name="BambuStudio:3mfVersion">1</metadata>\n')
    out.write('  <metadata name="Title">Xadrez 01 - placa bicolor FlashForge AD5X</metadata>\n')
    out.write('  <metadata name="Designer">afonsolelis</metadata>\n')
    out.write(
        '  <metadata name="Description">Tabuleiro 168 mm e 32 pecas; '
        'placa unica, dois corpos de cor, sem suporte.</metadata>\n'
    )
    out.write('  <metadata name="CreationDate">2026-08-23</metadata>\n')
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
    # os dois corpos de cor separadamente. Os filhos continuam selecionaveis
    # como componentes e mantem seus materiais-base.
    assembly_id = 2 + len(meshes)
    out.write(
        f'    <object id="{assembly_id}" type="model" '
        'name="XADREZ_01__CONJUNTO_BICOLOR">\n'
    )
    out.write('      <components>\n')
    for object_id in range(2, assembly_id):
        out.write(f'        <component objectid="{object_id}"/>\n')
    out.write('      </components>\n    </object>\n')
    out.write('  </resources>\n  <build>\n')
    out.write(f'    <item objectid="{assembly_id}"/>\n')
    out.write('  </build>\n</model>\n')
    return out.getvalue().encode("utf-8")


CONTENT_TYPES = b"""<?xml version="1.0" encoding="UTF-8"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Extension Extension="model" ContentType="application/vnd.ms-package.3dmanufacturing-3dmodel+xml"/>
</Types>
"""

RELATIONSHIPS = b"""<?xml version="1.0" encoding="UTF-8"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Target="/3D/3dmodel.model" Id="rel0" Type="http://schemas.microsoft.com/3dmanufacturing/2013/01/3dmodel"/>
</Relationships>
"""


def model_settings_xml() -> bytes:
    """Metadados de volumes usados por Orca / Flash Studio Desktop.

    O objeto 4 e a montagem; os ids 2 e 3 sao os dois componentes de cor.
    O valor de extrusor e 1-based nesses fatiadores.
    """
    return b"""<?xml version="1.0" encoding="UTF-8"?>
<config>
  <object id="4">
    <metadata key="name" value="XADREZ_01__CONJUNTO_BICOLOR"/>
    <metadata key="extruder" value="0"/>
    <part id="2" subtype="normal_part">
      <metadata key="name" value="COR 1 CLARA - tabuleiro e 16 pecas"/>
      <metadata key="extruder" value="1"/>
      <metadata key="matrix" value="1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1"/>
      <metadata key="source_file" value="xadrez-01-placa-bicolor.3mf"/>
      <metadata key="source_object_id" value="0"/>
      <metadata key="source_volume_id" value="0"/>
      <mesh_stat edges_fixed="0" degenerate_facets="0" facets_removed="0" facets_reversed="0" backwards_edges="0"/>
    </part>
    <part id="3" subtype="normal_part">
      <metadata key="name" value="COR 2 ESCURA - casas e 16 pecas"/>
      <metadata key="extruder" value="2"/>
      <metadata key="matrix" value="1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 1"/>
      <metadata key="source_file" value="xadrez-01-placa-bicolor.3mf"/>
      <metadata key="source_object_id" value="0"/>
      <metadata key="source_volume_id" value="1"/>
      <mesh_stat edges_fixed="0" degenerate_facets="0" facets_removed="0" facets_reversed="0" backwards_edges="0"/>
    </part>
  </object>
  <plate>
    <metadata key="plater_id" value="1"/>
    <metadata key="plater_name" value="Xadrez completo - duas cores"/>
    <metadata key="locked" value="false"/>
    <model_instance>
      <metadata key="object_id" value="4"/>
      <metadata key="instance_id" value="0"/>
    </model_instance>
  </plate>
  <assemble>
  </assemble>
</config>
"""


def zip_write(archive: zipfile.ZipFile, name: str, data: bytes) -> None:
    info = zipfile.ZipInfo(name, date_time=(1980, 1, 1, 0, 0, 0))
    info.compress_type = zipfile.ZIP_DEFLATED
    info.external_attr = 0o644 << 16
    archive.writestr(info, data)


def bbox(vertices):
    axes = list(zip(*vertices))
    return tuple(max(axis) - min(axis) for axis in axes)


def main() -> None:
    meshes = []
    for spec in MESHES:
        if not spec["path"].is_file():
            raise SystemExit(f"Falta exportar: {spec['path'].relative_to(ROOT)}")
        vertices, faces = indexed_mesh(load_stl(spec["path"]))
        meshes.append({**spec, "vertices": vertices, "faces": faces})

    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    with zipfile.ZipFile(OUTPUT, "w") as archive:
        zip_write(archive, "[Content_Types].xml", CONTENT_TYPES)
        zip_write(archive, "_rels/.rels", RELATIONSHIPS)
        zip_write(archive, "3D/3dmodel.model", model_xml(meshes))
        zip_write(archive, "Metadata/model_settings.config", model_settings_xml())

    all_vertices = [v for mesh in meshes for v in mesh["vertices"]]
    size = bbox(all_vertices)
    print(f"criado: {OUTPUT.relative_to(ROOT)}")
    print(f"item de placa: 1 conjunto; corpos de cor: {len(meshes)}; materiais: 2")
    print(f"triangulos: {sum(len(mesh['faces']) for mesh in meshes)}")
    print(f"envelope: {size[0]:.2f} x {size[1]:.2f} x {size[2]:.2f} mm")


if __name__ == "__main__":
    main()
