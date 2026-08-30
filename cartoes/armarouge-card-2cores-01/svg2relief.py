#!/usr/bin/env python3
"""
svg2relief.py - converte um SVG de trace COLORIDO (regioes de cor chapada,
sem stroke) num heightmap PNG em escala de cinza pronto pro surface() do
OpenSCAD, para imprimir a arte como BAIXO-RELEVO DE NIVEIS em cor unica.

A ideia: a luminancia de cada cor do trace vira ALTURA. Partes claras da arte
sobem, partes escuras (contornos, sombras) ficam baixas. O resultado le como
uma escultura em relevo, nao como uma silhueta chapada.

Contrato do cinza (casado com pokemon-filler-card-01.scad, NAO mexer num sem
mexer no outro). O .scad faz UM mapa linear so:
    cinza  51 -> z100 = 20  -> face do card MENOS relief_bury (fica enterrado)
    cinza 255 -> z100 = 100 -> face do card MAIS relief_max
Este script escolhe os cinzas dos niveis da figura a partir das alturas em mm
que voce quer, usando esse mesmo mapa -- por isso ele recebe relief_max e
relief_bury como argumento: se mudar no .scad, mudar aqui e REGERAR o PNG.

Por que POUCOS niveis: com 8 niveis em 0.8mm o degrau vira 0.1mm e o nivel
mais baixo da figura fica a 0.056mm da face, ou seja, a silhueta nao descola
do card e a arte some. O padrao e' 4 niveis comecando em 0.2mm com passo de
0.2mm: cada degrau e' UMA CAMADA inteira a 0.20mm de altura de camada, entao
o relevo le de longe e ainda cai exatamente em fronteira de camada no
fatiador.

Uso:
    python3 svg2relief.py entrada.svg art/nome.png [--px-w 128] [--levels 8]

Requer ImageMagick (`convert`) e Pillow. Nesta maquina nao ha rsvg/inkscape;
o renderizador interno do ImageMagick da conta desse tipo de trace (so <path>
com fill e fill-rule, sem stroke, sem gradiente, sem filtro).
"""

import argparse
import os
import subprocess
import sys
from collections import deque

from PIL import Image

GRAY_BG = 51     # z100 = 20, o plano de fundo enterrado
Z100_BG = 20.0
Z100_TOP = 100.0

SUPERSAMPLE = 4  # renderiza grande e reduz, pra suavizar borda e vazamento


def gray_for_height(h_mm, relief_max, relief_bury):
    """Inverte o mapa linear do .scad: altura em mm acima da face -> cinza."""
    per_z100 = (relief_max + relief_bury) / (Z100_TOP - Z100_BG)
    z100 = Z100_BG + (h_mm + relief_bury) / per_z100
    return z100 * 255.0 / 100.0


def median3(levels, w, h):
    """Mediana 3x3 sobre o mapa de NIVEIS: mata pixel solto do trace, que em
    0.3mm/px fica menor que o bico de 0.4 e o fatiador jogaria fora."""
    out = list(levels)
    for y in range(h):
        for x in range(w):
            win = []
            for dy in (-1, 0, 1):
                for dx in (-1, 0, 1):
                    nx, ny = x + dx, y + dy
                    if 0 <= nx < w and 0 <= ny < h:
                        win.append(levels[ny * w + nx])
            win.sort()
            out[y * w + x] = win[len(win) // 2]
    return out


def rasterize(svg_path, px_w, px_h):
    """SVG -> RGBA na resolucao pedida, fundo TRANSPARENTE."""
    out = svg_path + ".raster.png"
    subprocess.run(
        ["convert", "-background", "none", "-density", "288",
         svg_path, "-resize", f"{px_w}x{px_h}!", "PNG32:" + out],
        check=True,
    )
    im = Image.open(out).convert("RGBA")
    os.unlink(out)
    return im


def outside_mask(alpha, w, h, thresh=128):
    """Flood fill a partir da borda: separa fundo VERDADEIRO dos furos internos
    do trace (que nao podem virar buraco no relevo)."""
    outside = bytearray(w * h)
    q = deque()
    for x in range(w):
        for y in (0, h - 1):
            i = y * w + x
            if alpha[i] < thresh and not outside[i]:
                outside[i] = 1
                q.append(i)
    for y in range(h):
        for x in (0, w - 1):
            i = y * w + x
            if alpha[i] < thresh and not outside[i]:
                outside[i] = 1
                q.append(i)
    while q:
        i = q.popleft()
        x, y = i % w, i // w
        for nx, ny in ((x - 1, y), (x + 1, y), (x, y - 1), (x, y + 1)):
            if 0 <= nx < w and 0 <= ny < h:
                j = ny * w + nx
                if not outside[j] and alpha[j] < thresh:
                    outside[j] = 1
                    q.append(j)
    return outside


def luminance(r, g, b):
    return 0.2126 * r + 0.7152 * g + 0.0722 * b


# ---------------------------------------------------------------------
# Versao MULTICOLOR: uma malha por grupo de cor
# ---------------------------------------------------------------------
def kmeans_palette(palette, k, iters=40):
    """k-means em RGB sobre as cores da paleta, PONDERADO por area.

    Ponderar por area importa: sem isso uma cor usada em 1 path sozinho puxa
    um centroide inteiro e some uma cor que cobre 30% da figura.
    Semeadura deterministica tipo k-means++ (maior area, depois a mais
    distante), pra rodar duas vezes dar o mesmo resultado.
    """
    cols = list(palette)
    if k >= len(cols):
        return {c: i for i, c in enumerate(cols)}, [c for c in cols]

    def d2(a, b):
        return sum((a[i] - b[i]) ** 2 for i in range(3))

    seeds = [max(cols, key=lambda c: palette[c])]
    while len(seeds) < k:
        seeds.append(max(cols, key=lambda c: min(d2(c, s) for s in seeds)
                                             * palette[c] ** 0.5))
    cent = [tuple(float(v) for v in s) for s in seeds]

    assign = {}
    for _ in range(iters):
        new = {c: min(range(k), key=lambda j: d2(c, cent[j])) for c in cols}
        if new == assign:
            break
        assign = new
        for j in range(k):
            members = [c for c in cols if assign[c] == j]
            if not members:
                continue
            wt = sum(palette[c] for c in members)
            cent[j] = tuple(sum(c[i] * palette[c] for c in members) / wt
                            for i in range(3))
    order = sorted(range(k), key=lambda j: -sum(palette[c] for c in cols
                                                if assign[c] == j))
    remap = {j: i for i, j in enumerate(order)}
    return ({c: remap[assign[c]] for c in cols},
            [tuple(int(round(v)) for v in cent[j]) for j in order])


def write_binary_stl(path, tris):
    import struct as _s
    with open(path, "wb") as fh:
        fh.write(b"\0" * 80)
        fh.write(_s.pack("<I", len(tris)))
        for a, b, c in tris:
            ux, uy, uz = (b[i] - a[i] for i in range(3))
            vx, vy, vz = (c[i] - a[i] for i in range(3))
            nx, ny, nz = uy * vz - uz * vy, uz * vx - ux * vz, ux * vy - uy * vx
            n = (nx * nx + ny * ny + nz * nz) ** 0.5 or 1.0
            fh.write(_s.pack("<3f", nx / n, ny / n, nz / n))
            for v in (a, b, c):
                fh.write(_s.pack("<3f", *v))
            fh.write(_s.pack("<H", 0))


def greedy_boxes(mask, ztop, w, h):
    """Funde celulas vizinhas de MESMA altura em retangulos maximos.

    Sem isso sao 12 triangulos por pixel (139k no card inteiro). Com a fusao,
    as chapas grandes de armadura viram uma caixa so.
    """
    used = bytearray(w * h)
    out = []
    for row in range(h):
        for col in range(w):
            i = row * w + col
            if used[i] or not mask[i]:
                continue
            z = ztop[i]
            c1 = col
            while (c1 + 1 < w and mask[row * w + c1 + 1]
                   and not used[row * w + c1 + 1]
                   and ztop[row * w + c1 + 1] == z):
                c1 += 1
            r1 = row
            while r1 + 1 < h:
                nxt = (r1 + 1) * w
                if not all(mask[nxt + c] and not used[nxt + c]
                           and ztop[nxt + c] == z for c in range(col, c1 + 1)):
                    break
                r1 += 1
            for r in range(row, r1 + 1):
                for c in range(col, c1 + 1):
                    used[r * w + c] = 1
            out.append((col, c1, row, r1, z))
    return out


def blocky_mesh(mask, ztop, w, h, geom):
    """Peca de cor como conjunto de CAIXAS que se encostam.

    Cada caixa e' um solido fechado e manifold por si; o conjunto e' o que um
    exportador de voxel produz e todo fatiador resolve. A tentativa anterior,
    de malhar o campo de alturas como uma casca unica, vazava: nas arestas
    VERTICAIS de canto, onde tres celulas de alturas diferentes se encontram,
    os pedacos de parede nao casam e sobram T-junctions (734 arestas sem par
    na cor1). Caixa fundida nao tem esse problema.

    Parede VERTICAL de proposito, ao contrario do surface() do OpenSCAD que faz
    rampa de 1px: numa peca de cor a rampa borraria a fronteira entre dois
    filamentos.
    """
    cw, ch, x0, y0, zbase = geom
    tris = []
    for col0, col1, row0, row1, zt in greedy_boxes(mask, ztop, w, h):
        ax, bx = x0 + col0 * cw, x0 + (col1 + 1) * cw
        # linha 0 do PNG e' o TOPO da imagem -> maior Y no card
        by, ay = y0 + (h - row0) * ch, y0 + (h - row1 - 1) * ch
        v = [(ax, ay, zbase), (bx, ay, zbase), (bx, by, zbase), (ax, by, zbase),
             (ax, ay, zt), (bx, ay, zt), (bx, by, zt), (ax, by, zt)]
        for a, b, c, d in ((0, 3, 2, 1), (4, 5, 6, 7), (0, 1, 5, 4),
                           (1, 2, 6, 5), (2, 3, 7, 6), (3, 0, 4, 7)):
            tris.append((v[a], v[b], v[c]))
            tris.append((v[a], v[c], v[d]))
    return tris


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("svg")
    ap.add_argument("out_png")
    ap.add_argument("--px-w", type=int, default=128,
                    help="largura do heightmap em pixels (0.3mm/px e' o alvo)")
    ap.add_argument("--levels", type=int, default=4,
                    help="niveis de altura da figura")
    ap.add_argument("--h-min", type=float, default=0.20,
                    help="mm acima da face no nivel mais baixo da figura")
    ap.add_argument("--h-step", type=float, default=0.20,
                    help="mm entre niveis; 0.20 = uma camada inteira")
    ap.add_argument("--relief-max", type=float, default=0.80,
                    help="TEM que bater com relief_max do .scad")
    ap.add_argument("--relief-bury", type=float, default=0.05,
                    help="TEM que bater com relief_bury do .scad")
    ap.add_argument("--no-median", action="store_true",
                    help="pula a mediana 3x3 que remove pixel solto")
    ap.add_argument("--parts-dir",
                    help="se dado, escreve tambem uma malha STL por grupo de "
                         "cor, para montar o 3MF MULTICOLOR")
    ap.add_argument("--part-prefix", default="parte",
                    help="prefixo dos STL de cor")
    ap.add_argument("--colors", type=int, default=3,
                    help="grupos CROMATICOS da arte; o filamento restante e' o "
                         "do corpo do card, entao 3 aqui = 4 cores no total")
    ap.add_argument("--card-t", type=float, default=1.20,
                    help="TEM que bater com card_t do .scad")
    ap.add_argument("--art-w", type=float, default=38.3442,
                    help="TEM que bater com o ECHO 'arte encaixada' do .scad")
    ap.add_argument("--art-h", type=float, default=62.80)
    ap.add_argument("--art-cx", type=float, default=33.50,
                    help="TEM que bater com o ECHO 'centro em' do .scad")
    ap.add_argument("--art-cy", type=float, default=51.00)
    ap.add_argument("--linear", action="store_true",
                    help="mapeia luminancia -> nivel de forma linear em vez de "
                         "equalizada; o linear costuma empilhar 70%% da figura "
                         "num nivel so e o relevo fica chapado")
    ap.add_argument("--gap-level", type=float, default=0.55,
                    help="nivel 0..1 dado aos furos INTERNOS do trace")
    ap.add_argument("--gamma", type=float, default=1.0,
                    help=">1 achata os claros, <1 achata os escuros")
    args = ap.parse_args()

    src = Image.open(args.svg) if args.svg.lower().endswith(".png") else None
    if src is None:
        probe = subprocess.run(["identify", "-format", "%w %h", args.svg],
                               capture_output=True, text=True, check=True)
        sw, sh = (int(v) for v in probe.stdout.split())
    else:
        sw, sh = src.size

    px_w = args.px_w
    px_h = max(1, round(px_w * sh / sw))
    big_w, big_h = px_w * SUPERSAMPLE, px_h * SUPERSAMPLE

    im = rasterize(args.svg, big_w, big_h)
    px = im.load()
    w, h = im.size
    alpha = bytearray(w * h)
    for y in range(h):
        for x in range(w):
            alpha[y * w + x] = px[x, y][3]

    outside = outside_mask(alpha, w, h)

    # faixa de luminancia realmente presente na figura, pra usar o curso inteiro
    lo, hi = 255.0, 0.0
    for y in range(h):
        for x in range(w):
            i = y * w + x
            if outside[i] or alpha[i] < 128:
                continue
            r, g, b, _ = px[x, y]
            lum = luminance(r, g, b)
            lo = min(lo, lum)
            hi = max(hi, lum)
    span = max(1.0, hi - lo)

    # Equalizacao por QUANTIL: sem ela, a luminancia da arte se concentra e um
    # unico nivel leva ~70% da figura -- o relevo sai chapado. Com ela, cada
    # nivel fica com uma fatia parecida da area e o volume aparece.
    cuts = []
    if not args.linear:
        lums = []
        for y in range(h):
            for x in range(w):
                i = y * w + x
                if outside[i] or alpha[i] < 128:
                    continue
                r, g, b, _ = px[x, y]
                lums.append(luminance(r, g, b))
        lums.sort()
        cuts = [lums[min(len(lums) - 1, int(len(lums) * k / args.levels))]
                for k in range(1, args.levels)]

    def tone(lum):
        """luminancia -> posicao 0..1 na escala de niveis"""
        if cuts:
            lvl = sum(1 for c in cuts if lum >= c)
            return lvl / (args.levels - 1)
        return ((lum - lo) / span) ** args.gamma

    # mapa continuo 0..1 (fora da figura = -1, marcado a parte)
    field = [-1.0] * (w * h)
    for y in range(h):
        for x in range(w):
            i = y * w + x
            if outside[i]:
                continue
            if alpha[i] < 128:
                field[i] = args.gap_level  # furo interno do trace
                continue
            r, g, b, _ = px[x, y]
            field[i] = tone(luminance(r, g, b))

    # downsample por media -> indice de NIVEL (0 = fundo, 1..N = figura)
    n = SUPERSAMPLE * SUPERSAMPLE
    levels = [0] * (px_w * px_h)
    for oy in range(px_h):
        for ox in range(px_w):
            acc = 0.0
            cnt = 0
            for dy in range(SUPERSAMPLE):
                for dx in range(SUPERSAMPLE):
                    v = field[(oy * SUPERSAMPLE + dy) * w + ox * SUPERSAMPLE + dx]
                    if v >= 0.0:
                        acc += v
                        cnt += 1
            if cnt * 2 < n:  # maioria fora da figura -> fundo
                continue
            levels[oy * px_w + ox] = 1 + round((acc / cnt) * (args.levels - 1))

    if not args.no_median:
        levels = median3(levels, px_w, px_h)

    # alturas alvo -> cinzas, pelo mesmo mapa linear do .scad
    heights = [args.h_min + i * args.h_step for i in range(args.levels)]
    if abs(heights[-1] - args.relief_max) > 1e-6:
        print(f"AVISO: nivel mais alto em {heights[-1]:.3f}mm, mas relief_max "
              f"do .scad e' {args.relief_max:.3f}mm -- o topo nao vai encostar "
              f"no maximo declarado", file=sys.stderr)
    grays = [int(round(gray_for_height(h, args.relief_max, args.relief_bury)))
             for h in heights]
    if max(grays) > 255 or min(grays) <= GRAY_BG:
        sys.exit(f"ERRO: alturas pedidas caem fora do curso do .scad; cinzas={grays}")

    out = Image.new("L", (px_w, px_h))
    op = out.load()
    figure_px = 0
    for y in range(px_h):
        for x in range(px_w):
            lvl = levels[y * px_w + x]
            if lvl == 0:
                op[x, y] = GRAY_BG
            else:
                op[x, y] = grays[min(lvl, args.levels) - 1]
                figure_px += 1

    os.makedirs(os.path.dirname(os.path.abspath(args.out_png)), exist_ok=True)
    out.save(args.out_png)

    if args.parts_dir:
        # paleta real da figura, ponderada por AREA em pixel
        palette = {}
        gfield = [-1] * (w * h)
        for y in range(h):
            for x in range(w):
                i = y * w + x
                if outside[i] or alpha[i] < 128:
                    continue
                r, g, b, _ = px[x, y]
                palette[(r, g, b)] = palette.get((r, g, b), 0) + 1
        assign, centroids = kmeans_palette(palette, args.colors)
        for y in range(h):
            for x in range(w):
                i = y * w + x
                if outside[i] or alpha[i] < 128:
                    continue
                r, g, b, _ = px[x, y]
                gfield[i] = assign[(r, g, b)]

        # grupo por pixel de SAIDA: voto de maioria dentro do bloco
        groups = [-1] * (px_w * px_h)
        for oy in range(px_h):
            for ox in range(px_w):
                if levels[oy * px_w + ox] == 0:
                    continue
                tally = {}
                for dy in range(SUPERSAMPLE):
                    for dx in range(SUPERSAMPLE):
                        gv = gfield[(oy * SUPERSAMPLE + dy) * w
                                    + ox * SUPERSAMPLE + dx]
                        if gv >= 0:
                            tally[gv] = tally.get(gv, 0) + 1
                # so vao interno do trace, sem cor nenhuma -> cor do corpo
                groups[oy * px_w + ox] = (max(tally, key=tally.get)
                                          if tally else args.colors)

        cw, ch = args.art_w / px_w, args.art_h / px_h
        geom = (cw, ch,
                args.art_cx - args.art_w / 2.0,
                args.art_cy - args.art_h / 2.0,
                args.card_t - args.relief_bury)
        ztop = [args.card_t + heights[min(l, args.levels) - 1] if l else 0.0
                for l in levels]

        os.makedirs(args.parts_dir, exist_ok=True)
        print(f"\n  malhas de cor em {args.parts_dir}/ "
              f"(celula {cw:.4f} x {ch:.4f} mm):")
        for gi in range(args.colors + 1):
            mask = [1 if groups[i] == gi else 0 for i in range(px_w * px_h)]
            npx = sum(mask)
            if not npx:
                continue
            tris = blocky_mesh(mask, ztop, px_w, px_h, geom)
            if gi < args.colors:
                r, g, b = centroids[gi]
                tag = f"cor{gi + 1}"
                desc = f"#{r:02x}{g:02x}{b:02x}"
            else:
                tag = "vao"
                desc = "vao interno do trace, sem cor -> filamento do corpo"
            fn = os.path.join(args.parts_dir,
                              f"{args.part_prefix}-{tag}.stl")
            write_binary_stl(fn, tris)
            print(f"    {os.path.basename(fn):32} {npx:6} px  "
                  f"{len(tris):6} tri  {desc}")

    used = sorted({op[x, y] for y in range(px_h) for x in range(px_w)})
    print(f"{args.out_png}: {px_w} x {px_h} px, "
          f"{figure_px} px de figura ({100*figure_px/(px_w*px_h):.1f}%)")
    print(f"  luminancia da arte: {lo:.1f}..{hi:.1f}")
    print(f"  fundo: cinza {GRAY_BG} -> face - {args.relief_bury}mm (enterrado)")
    for i, (g, h) in enumerate(zip(grays, heights), 1):
        mark = "" if g in used else "   (nao usado)"
        print(f"  nivel {i}: cinza {g:3d} -> face + {h:.3f}mm{mark}")


if __name__ == "__main__":
    sys.exit(main())
