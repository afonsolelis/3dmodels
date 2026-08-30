#!/usr/bin/env python3
"""art2parts.py - parte o heightmap do svg2relief.py em DUAS pecas de cor
pelo NIVEL do relevo, nao pela matiz.

Por que nao usar `svg2relief.py --colors 2`: la os grupos saem de k-means em
RGB, que num trace do Armarouge separa AMARELO de VERMELHO -- duas cores
igualmente claras. Em preto/cinza isso vira uma mancha chapada so (foi o que o
render 2cores-v1 mostrou: a figura sumiu). O que da leitura em duas cores e'
separar CLARO de ESCURO, e a luminancia ja esta codificada no heightmap: o
svg2relief converteu luminancia em ALTURA, entao o nivel do relevo E' o tom.

    niveis 1-2 (face +0.20 e +0.40mm)  contorno e sombra  -> filamento ESCURO
    niveis 3-4 (face +0.60 e +0.80mm)  luz da armadura    -> filamento CLARO

Reusa blocky_mesh/write_binary_stl do svg2relief pra a malha sair identica a
dele: caixas fundidas por greedy meshing, cada caixa um solido fechado, parede
vertical na fronteira de cor (rampa borraria a troca de filamento).

Os argumentos de geometria TEM que bater com os ECHO do .scad, igual no
svg2relief -- ver o README.
"""
import argparse
import os

from PIL import Image

import svg2relief as s


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("png", help="heightmap gerado pelo svg2relief.py")
    ap.add_argument("out_dir")
    ap.add_argument("--prefix", default="arte")
    ap.add_argument("--levels", type=int, default=4)
    ap.add_argument("--split", type=int, default=2,
                    help="ultimo nivel que vai pro filamento ESCURO")
    ap.add_argument("--h-min", type=float, default=0.20)
    ap.add_argument("--h-step", type=float, default=0.20)
    ap.add_argument("--relief-max", type=float, default=0.80)
    ap.add_argument("--relief-bury", type=float, default=0.05)
    ap.add_argument("--card-t", type=float, default=1.20)
    ap.add_argument("--art-w", type=float, required=True)
    ap.add_argument("--art-h", type=float, required=True)
    ap.add_argument("--art-cx", type=float, required=True)
    ap.add_argument("--art-cy", type=float, required=True)
    a = ap.parse_args()

    heights = [a.h_min + i * a.h_step for i in range(a.levels)]
    grays = [int(round(s.gray_for_height(h, a.relief_max, a.relief_bury)))
             for h in heights]
    gray_to_level = {g: i + 1 for i, g in enumerate(grays)}

    im = Image.open(a.png).convert("L")
    w, h = im.size
    p = im.load()
    levels = [gray_to_level.get(p[x, y], 0) for y in range(h) for x in range(w)]
    unknown = sum(1 for y in range(h) for x in range(w)
                  if p[x, y] != s.GRAY_BG and p[x, y] not in gray_to_level)
    if unknown:
        raise SystemExit("ERRO: %d px com cinza fora do contrato de niveis; "
                         "os --h-*/--relief-* nao batem com os do svg2relief"
                         % unknown)

    cw, ch = a.art_w / w, a.art_h / h
    geom = (cw, ch, a.art_cx - a.art_w / 2.0, a.art_cy - a.art_h / 2.0,
            a.card_t - a.relief_bury)
    ztop = [a.card_t + heights[l - 1] if l else 0.0 for l in levels]

    os.makedirs(a.out_dir, exist_ok=True)
    for tag, keep in (("escuro", lambda l: 1 <= l <= a.split),
                      ("claro", lambda l: l > a.split)):
        mask = [1 if keep(l) else 0 for l in levels]
        npx = sum(mask)
        tris = s.blocky_mesh(mask, ztop, w, h, geom)
        fn = os.path.join(a.out_dir, "%s-%s.stl" % (a.prefix, tag))
        s.write_binary_stl(fn, tris)
        niveis = [i for i in range(1, a.levels + 1) if keep(i)]
        print("  %-44s %6d px (%4.1f%% da figura)  %6d tri  niveis %s"
              % (os.path.basename(fn), npx,
                 100.0 * npx / max(1, sum(1 for l in levels if l)),
                 len(tris), niveis))


main()
