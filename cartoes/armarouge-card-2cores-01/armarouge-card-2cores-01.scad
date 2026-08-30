// armarouge-card-2cores-01.scad
// Card tapa-buraco do Armarouge, 67 x 90mm, SEM NOME E SEM NUMERO e em DUAS
// CORES no IFS: fundo CINZA CLARO (filamento 1) e moldura + figura PRETAS
// (filamento 2). Derivado do cartoes/pokemon-filler-card-01, que e' a versao
// com texto e 4 cores -- as medidas do bolso do album e a espessura vem de la
// (67x90 de proposito MAIOR que o card oficial de 63x88, corpo de 1.2mm =
// 6 camadas a 0.20mm, total acabado 2.0mm, a mesma espessura que ja foi
// impressa e provada no pokemon-coin-binder-01).
//
// O que muda em relacao ao 01:
//   - labels_2d() saiu: sem "ARMAROUGE", sem "#936".
//   - band_h = 0: a faixa que existia so pra abrigar o texto virou area util,
//     entao a arte cresce de 38.3 x 62.8 para 45.7 x 74.8mm.
//   - so 2 grupos de cor, e o corte sai do NIVEL DO RELEVO, nao da matiz:
//     k-means em RGB separaria amarelo de vermelho, duas cores igualmente
//     claras que em preto/cinza viram uma mancha chapada so (testado, a
//     figura sumiu). Como o svg2relief converteu luminancia em ALTURA, o
//     nivel do relevo E' o tom -- quem faz esse corte e' o art2parts.py.
//
// Imprime com o verso na mesa e o relevo pra cima, uma peca, sem suporte.
// Chanfro de 0.4mm na aresta de baixo mata o pe de elefante. BRIM recomendado:
// placa de 67x90 com 1.2mm de corpo e' geometria classica de empeno.
//
// Escalas ja conferidas nesta maquina (ver cabecalho do 01, nao rechutar):
//   surface() de PNG: cinza 0 -> z 0, cinza 255 -> z 100; 1 px = 1 unidade XY.
//   O contrato de cinza (fundo em z100=20) esta no svg2relief.py.
//
// Exports canonicos (Flatpak, caminhos ABSOLUTOS a partir da pasta do modelo):
//   flatpak run org.openscad.OpenSCAD -o stl/armarouge-card-2cores-01-body.stl -D 'part="body"' armarouge-card-2cores-01.scad
//   flatpak run org.openscad.OpenSCAD -o stl/armarouge-card-2cores-01-trim.stl -D 'part="trim"' armarouge-card-2cores-01.scad
//   o heightmap sai do svg2relief.py, as duas malhas de ARTE saem do
//   art2parts.py (corte por nivel) e o 3MF de 2 filamentos, do
//   multicolor3mf.py. Linhas de comando exatas no README.

/* [Peca a renderizar] */
// "card"  peca inteira em cor unica, so pra PREVIEW/render
// "plate" chapa de cards inteiros, so pra conferir footprint
// "body"  corpo liso do card -- peca do filamento 1 (CINZA CLARO)
// "trim"  moldura + hexagonos -- peca do filamento 2 (PRETO)
part = "card"; // "card" | "plate" | "body" | "trim"

/* [Cartao] */
card_w = 67.0;
card_h = 90.0;
card_t = 1.20;
corner_r = 3.50;
foot_chamfer = 0.40;

/* [Arte] */
art_src = "relief";                 // "relief" | "none"
relief_png = "art/armarouge.png";   // heightmap do svg2relief.py
relief_max = 0.80;   // mm acima da face do card
relief_bury = 0.05;  // mm de plato de fundo enterrado
png_w = 128;         // px, conferir com o arquivo
png_h = 209;         // px
art_flip_y = false;
art_dx = 0;
art_dy = 0;

/* [Moldura] */
relief_h = 0.40;    // mm de alto relevo da moldura e dos hexagonos
frame_inset = 3.5;
frame_w = 1.6;
frame_r = 2.2;
band_h = 0.0;       // 0 = sem faixa de texto; a arte ocupa o card todo
hex_mark = 3.2;

/* [Chapa] */
plate_cols = 2;
plate_rows = 2;
plate_gap = 4.0;

/* [Qualidade] */
$fn = 72;
eps = 0.02;

// ---------------------------------------------------------------------
win_x0 = frame_inset + frame_w + 2.5;
win_w = card_w - 2 * win_x0;
win_y0 = frame_inset + frame_w + 2.5 + band_h;
win_y1 = card_h - (frame_inset + frame_w + 2.5);
win_h = win_y1 - win_y0;
win_cx = card_w / 2;
win_cy = (win_y0 + win_y1) / 2;

png_aspect = (png_w - 1) / (png_h - 1);
art_h = min(win_h, win_w / png_aspect);
art_w = art_h * png_aspect;

Z100_BG = 20;
Z100_TOP = 100;
zscale = (relief_max + relief_bury) / (Z100_TOP - Z100_BG);
relief_z0 = card_t - relief_bury - Z100_BG * zscale;
surface_floor = relief_z0 - zscale;

total_t = card_t + max(relief_max, relief_h);
plate_w = plate_cols * card_w + (plate_cols - 1) * plate_gap;
plate_h = plate_rows * card_h + (plate_rows - 1) * plate_gap;

assert(card_t >= 1.0, "card_t abaixo de 1mm nao sai solido em FDM");
assert(win_w > 20 && win_h > 20, "Janela de arte pequena demais");
assert(foot_chamfer < card_t, "foot_chamfer precisa ser menor que card_t");
assert(surface_floor > 0.05, "O heightmap furaria o verso do card");
assert(art_w <= win_w + eps && art_h <= win_h + eps, "Arte estourou a janela");

echo(str("armarouge-card-2cores-01: card ", card_w, " x ", card_h,
         " mm, corpo ", card_t, " mm, acabado ", total_t, " mm"));
echo(str("  janela de arte: ", win_w, " x ", win_h, " mm, centro em [",
         win_cx, ", ", win_cy, "]"));
echo(str("  arte encaixada: ", art_w, " x ", art_h, " mm (heightmap ",
         png_w, "x", png_h, " px, ", art_w / (png_w - 1), " mm/px)"));
echo(str("  z0 do surface em ", relief_z0, " mm | piso do solido em ",
         surface_floor, " mm (tem que ser > 0)"));
echo(str("  chapa ", plate_cols, "x", plate_rows, " = ", plate_cols * plate_rows,
         " cards, footprint ", plate_w, " x ", plate_h, " mm"));

// ---------------------------------------------------------------------
module card_outline_2d(inset = 0) {
    translate([corner_r, corner_r])
        offset(r = -inset) offset(r = corner_r)
            square([card_w - 2 * corner_r, card_h - 2 * corner_r]);
}

// Retangulo arredondado ANCORADO: o translate soma o raio de proposito,
// senao offset(r) desloca a forma r pra esquerda e pra baixo (bug da v1 do 01).
module rrect_2d(x, y, w, h, r) {
    translate([x + r, y + r]) offset(r = r) square([w - 2 * r, h - 2 * r]);
}

module frame_2d() {
    difference() {
        rrect_2d(frame_inset, frame_inset,
                 card_w - 2 * frame_inset, card_h - 2 * frame_inset, frame_r);
        rrect_2d(frame_inset + frame_w, frame_inset + frame_w,
                 card_w - 2 * (frame_inset + frame_w),
                 card_h - 2 * (frame_inset + frame_w),
                 max(0.1, frame_r - frame_w));
    }
}

module hex_marks_2d() {
    m = frame_inset + frame_w + 3.4;
    for (x = [m, card_w - m], y = [m, card_h - m])
        translate([x, y]) rotate([0, 0, 30]) circle(d = hex_mark, $fn = 6);
}

module relief_2d() { frame_2d(); hex_marks_2d(); }

module card_body() {
    hull() {
        linear_extrude(eps) card_outline_2d(foot_chamfer);
        translate([0, 0, foot_chamfer]) linear_extrude(eps) card_outline_2d();
    }
    translate([0, 0, foot_chamfer])
        linear_extrude(card_t - foot_chamfer) card_outline_2d();
}

module trim() {
    translate([0, 0, card_t - eps]) linear_extrude(relief_h + eps) relief_2d();
}

module art_relief() {
    translate([win_cx + art_dx, win_cy + art_dy, relief_z0])
        mirror([0, art_flip_y ? 1 : 0, 0])
            scale([art_w / (png_w - 1), art_h / (png_h - 1), zscale])
                translate([-(png_w - 1) / 2, -(png_h - 1) / 2, 0])
                    surface(file = relief_png, center = false, invert = false);
}

module card() {
    union() {
        card_body();
        trim();
        if (art_src == "relief") art_relief();
    }
}

module plate() {
    for (c = [0 : plate_cols - 1], r = [0 : plate_rows - 1])
        translate([c * (card_w + plate_gap), r * (card_h + plate_gap), 0]) card();
}

// ---------------------------------------------------------------------
if (part == "card") card();
else if (part == "plate") plate();
else if (part == "body") card_body();
else if (part == "trim") trim();
else assert(false, "part invalido: card | plate | body | trim");
