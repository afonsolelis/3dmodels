#!/usr/bin/env python3
"""Gera as páginas dos downloads a partir de index.json."""

import argparse
import html
import json
import re
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
BT = chr(96)

CATEGORY_NAMES = {
    "bumpers": "Bumpers de slabs",
    "cardholders": "Porta-cartas",
    "casa": "Casa",
    "coin_holders": "Porta-moedas",
    "deckboxes": "Deckboxes e estojos",
    "figures": "Figuras",
    "jogos": "Jogos",
    "logistica_pokemon": "Logística Pokémon",
    "manutencao_impressoras": "Manutenção de impressoras",
    "miniaturas": "Miniaturas e expositores",
    "organizadores": "Organizadores",
    "organizadores_tcg": "Organizadores TCG",
    "pets": "Pets",
    "saude": "Caixas de remédio",
    "suportes": "Suportes",
}


def clean(value):
    text = html.unescape(html.unescape(str(value or "")))
    text = re.sub(r"<[^>]+>", " ", text)
    return re.sub(r"\s+", " ", text).strip()


def md(value):
    return clean(value).replace("|", "/")


def yes_no(value):
    return "sim" if value else "não"


def write_or_check(path, contents, check, errors):
    contents = contents.rstrip() + "\n"
    if check:
        if not path.is_file() or path.read_text() != contents:
            errors.append(str(path.relative_to(ROOT)))
    else:
        path.parent.mkdir(parents=True, exist_ok=True)
        path.write_text(contents)


def item_page(group):
    item = group[0]
    title = clean(item["title"])
    lines = [f"# {title}", "", clean(item["summary_pt"]), ""]
    if any(record.get("fits_ad5x") is False for record in group):
        lines += ["**Atenção: há peça que não cabe na cama de 220 × 220 mm da AD5X.**", ""]
    elif any(max(record["largest_part_mm"][:2]) > 210 for record in group):
        lines += ["**Atenção: uma peça passa do limite de conforto de 210 mm; confira a margem para brim.**", ""]
    if item.get("preview"):
        lines += ["![Prévia do arquivo](preview.png)", ""]
    lines += ["## Arquivos", "",
              "| Arquivo | Nome anterior | Maior peça (mm) | Perfil embutido | Trocar perfil? |",
              "| --- | --- | --- | --- | --- |"]
    for record in group:
        name = Path(record["file"]).name
        original = Path(record["original_file"]).name
        profile = record.get("embedded_profile") or {}
        printer = profile.get("printer_model") or "sem perfil identificado"
        swap = yes_no(record["needs_profile_swap"]) if "needs_profile_swap" in record else "a confirmar"
        dimensions = " × ".join(str(n) for n in record["largest_part_mm"])
        lines.append(f"| [{md(name)}]({name}) | {BT}{original}{BT} | {dimensions} | {md(printer)} | {swap} |")
    lines += ["", f"**Autor:** {clean(item.get('designer', 'a confirmar'))}  ",
              f"**Licença:** {clean(item.get('license', 'a confirmar'))}"]
    if item.get("source_title") and item["source_title"] != item["title"]:
        lines.append(f"**Título no 3MF:** {clean(item['source_title'])}")
    if all("fits_ad5x" in record for record in group):
        lines.append(f"**Peças cabem individualmente na AD5X:** {yes_no(all(record['fits_ad5x'] for record in group))}")
    if item.get("rebuilt_as"):
        target = item["rebuilt_as"].split(" (", 1)[0]
        lines.append(f"**Projeto próprio relacionado:** [{target}](../../../{target}/README.md)")
    if item.get("reused_by"):
        lines.append(f"**Reutilizado por:** {clean(item['reused_by'])}")
    notes_seen = set()
    for record in group:
        if record.get("notes"):
            note = clean(record["notes"])
            if note not in notes_seen:
                lines += ["", f"**Nota:** {note}"]
                notes_seen.add(note)
        if record.get("ATENCAO"):
            lines += ["", f"**Atenção:** {clean(record['ATENCAO'])}"]
        if record.get("measurement_note"):
            lines += ["", f"**Medida:** {clean(record['measurement_note'])}"]
    lines += ["", "Este item é um download de terceiro. A prévia pode mostrar uma foto promocional, uma renderização da malha ou só uma das plates. As medidas consideram cada peça separadamente; confira a disposição das plates e o perfil no Flash Studio antes de imprimir.", ""]
    return "\n".join(lines)


def gallery_page(category, groups):
    count = sum(len(group) for group in groups.values())
    lines = [
        f"# Downloads: {CATEGORY_NAMES[category]}", "",
        f"{count} arquivo(s) de terceiros em {len(groups)} item(ns). Cada item tem pasta própria, função resumida, nome anterior, autoria e licença.",
        "", "A prévia ajuda a reconhecer o modelo; para imprimir, abra o item e confira as plates e o perfil no Flash Studio.", "",
        "| Prévia | Item | O que é | Maior peça (mm) | AD5X |",
        "| --- | --- | --- | --- |",
    ]
    for folder, group in sorted(groups.items(), key=lambda pair: pair[1][0]["title"].casefold()):
        item = group[0]
        slug = Path(folder).name
        preview = f"![{md(item['title'])}]({slug}/preview.png)" if item.get("preview") else "Sem prévia"
        largest = max(group, key=lambda record: record["largest_part_mm"][0] * record["largest_part_mm"][1] * record["largest_part_mm"][2])
        dimensions = " × ".join(str(n) for n in largest["largest_part_mm"])
        if not all(record.get("fits_ad5x") for record in group):
            fit = "**não cabe**"
        elif any(max(record["largest_part_mm"][:2]) > 210 for record in group):
            fit = "cabe; margem curta"
        else:
            fit = "peças cabem"
        lines.append(
            f"| {preview} | [{md(item['title'])}]({slug}/README.md) | "
            f"{md(item['summary_pt'])} | {dimensions} | {fit} |"
        )
    lines += ["", "AD5X indica se cada peça cabe individualmente na cama; a disposição conjunta das plates precisa ser conferida no Flash Studio. Autor, licença e perfil estão no README de cada item. Os dados completos estão em [index.json](../../index.json).", ""]
    return "\n".join(lines)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true", help="verifica se as páginas estão em dia")
    args = parser.parse_args()
    data = json.loads((ROOT / "index.json").read_text())
    categories = defaultdict(lambda: defaultdict(list))
    for item in data["third_party"]:
        path = Path(item["file"])
        assert path.parts[0] == item["category"]
        assert path.parts[1] == "terceiros"
        categories[item["category"]][str(path.parent)].append(item)
    errors = []
    for category, groups in categories.items():
        for folder, group in groups.items():
            write_or_check(ROOT / folder / "README.md", item_page(group), args.check, errors)
        gallery = ROOT / category / "terceiros" / "README.md"
        write_or_check(gallery, gallery_page(category, groups), args.check, errors)
    if errors:
        print("Páginas desatualizadas:\n" + "\n".join(errors))
        raise SystemExit(1)
    print(f"{'Verificados' if args.check else 'Gerados'} {sum(len(x) for x in categories.values())} itens em {len(categories)} categorias.")


if __name__ == "__main__":
    main()
