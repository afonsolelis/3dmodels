// pokemon-filler-card-01.scad
// Card "tapa-buraco" de album Pokemon: 67 x 90mm, MAIOR que o card oficial de
// 63x88, justamente para NAO ficar solto no bolso do album. Arte em BAIXO
// RELEVO DE NIVEIS, impressa em COR UNICA (um filamento so, sem IFS).
//
// Medidas definidas pelo usuario em 2026-08-29: 67 x 90mm de contorno e corpo
// de 1.2mm (6 camadas a 0.20mm), a espessura minima que ainda sai solida em
// FDM. O relevo soma por cima: com relief_max 0.8mm o card acabado tem 2.0mm
// no ponto mais alto -- a MESMA espessura do insert do pokemon-coin-binder-01,
// que ja foi impresso e prova que 2.0mm entra nesse album.
//
// Imprime com o VERSO na mesa e o relevo para cima: uma peca, sem suporte,
// sem ponte. Chanfro de 0.4mm na aresta de baixo mata o pe de elefante para o
// card assentar plano no bolso. Placa lisa e BRIM recomendado: 67x90 com 1.2mm
// de corpo e' geometria classica de empeno. Camada de 0.10mm aproveita os 8
// niveis do relevo; a 0.20mm o relevo colapsa para 4 niveis e ainda funciona.
//
// ARTE - dois caminhos:
//   art_src = "relief"  heightmap PNG gerado por svg2relief.py a partir de um
//                       SVG de trace colorido. A LUMINANCIA de cada cor vira
//                       ALTURA: armadura clara sobe, contorno escuro desce.
//                       E' o caminho bom, da volume de escultura em cor unica.
//   art_src = "svg"     silhueta chapada, import() direto do SVG. O import de
//                       SVG do OpenSCAD 2021.01 desta maquina foi testado:
//                       aceita <path>, <circle> e furos por fill-rule evenodd,
//                       e IGNORA cor -- num trace colorido isso funde tudo
//                       numa mancha unica. So serve para SVG ja de silhueta.
//   art_src = "none"    pokebola de fallback, para testar o layout.
//
// Escalas medidas nesta maquina (nao chutar, foi conferido em 2026-08-29):
//   import() de SVG le a 72 dpi, 1 px = 0.352778mm, honrando width/height e
//   viewBox. resize() abaixo anula isso de qualquer jeito.
//   surface() de PNG: cinza 0 -> z 0, cinza 255 -> z 100, linear; cada pixel
//   e' 1 unidade em XY (a imagem ocupa px-1 unidades); o solido fecha o fundo
//   1 unidade abaixo do minimo. O contrato de cinza esta em svg2relief.py.
//
// Exports canonicos (usar o Flatpak nesta maquina, caminhos ABSOLUTOS):
//   flatpak run org.openscad.OpenSCAD -o stl/pokemon-filler-card-01-armarouge.stl pokemon-filler-card-01.scad
//   flatpak run org.openscad.OpenSCAD -o 3mf/pokemon-filler-card-01-armarouge-x6.3mf -D 'part="plate"' pokemon-filler-card-01.scad

/* [Peca a renderizar] */
// "card"  peca inteira em cor unica (corpo + moldura + texto + arte)
// "plate" chapa de cards inteiros
// "body"  SO o corpo liso -- peca 1 da versao MULTICOLOR
// "trim"  SO moldura + hexagonos + texto -- peca 2 da versao multicolor
// As pecas de ARTE da versao multicolor nao saem daqui: quem gera e o
// svg2relief.py --parts-dir, porque ele tem o mapa de cor pixel a pixel e
// assim a cor casa com o relevo sem meio-pixel de desalinhamento.
part = "card"; // "card" | "plate" | "body" | "trim"

/* [Cartao - medida do bolso informada pelo usuario] */
card_w = 67.0;   // mm, contra 63mm do card oficial
card_h = 90.0;   // mm, contra 88mm do card oficial
card_t = 1.20;   // mm, corpo; 6 camadas a 0.20mm
corner_r = 3.50; // mm
foot_chamfer = 0.40; // mm, alivio de pe de elefante na aresta de baixo

/* [Arte] */
art_src = "relief";                 // "relief" | "svg" | "none"
relief_png = "art/armarouge.png";   // heightmap do svg2relief.py
svg_file = "art/armarouge.svg";     // usado so quando art_src = "svg"
relief_max = 0.80;   // mm, quanto a figura sobe acima da face do card
relief_bury = 0.05;  // mm, quanto o plato de fundo do heightmap fica ENTERRADO
png_w = 128;         // px, largura do heightmap (conferir com o arquivo!)
png_h = 209;         // px, altura do heightmap
art_flip_y = false;  // conferido em render de topo: surface() ja poe a
                     // primeira linha do PNG no y MAXIMO, ou seja, a arte
                     // sai em pe sem espelhar. true deixa de cabeca pra baixo.
art_dx = 0;          // mm, ajuste fino horizontal
art_dy = 0;          // mm, ajuste fino vertical

/* [Textos e moldura] */
name_text = "ARMAROUGE";
dex_text = "936";
name_size = 5.6;    // mm
dex_size = 3.6;     // mm
font = "DejaVu Sans:style=Bold";
relief_h = 0.40;    // mm, alto relevo da moldura, hexagonos e texto
frame_inset = 3.5;  // mm, da borda do card ate a face externa da moldura
frame_w = 1.6;      // mm, espessura da linha da moldura
frame_r = 2.2;      // mm, raio da moldura
band_h = 12.0;      // mm, faixa de baixo reservada para nome e numero
hex_mark = 3.2;     // mm, hexagonos de identidade nos cantos

/* [Chapa] */
// 2x2 = 138 x 184mm. Cabe 3x2 na cama (209 x 184), MAS 209 encosta no limite
// de conforto de 210 do repo e nao sobra nada para o brim -- e brim aqui nao
// e' opcional: 67x90 com 1.2mm de corpo e' a geometria que mais empena.
plate_cols = 2;
plate_rows = 2;
plate_gap = 4.0; // mm

/* [Qualidade] */
$fn = 72;
eps = 0.02;

// ---------------------------------------------------------------------
// Derivados e verificacoes
// ---------------------------------------------------------------------
// janela util de arte: dentro da moldura, acima da faixa de nome
win_x0 = frame_inset + frame_w + 2.5;
win_w = card_w - 2 * win_x0;
win_y0 = frame_inset + frame_w + 2.5 + band_h;
win_y1 = card_h - (frame_inset + frame_w + 2.5);
win_h = win_y1 - win_y0;
win_cx = card_w / 2;
win_cy = (win_y0 + win_y1) / 2;

// o heightmap entra encaixado na janela PRESERVANDO a proporcao
png_aspect = (png_w - 1) / (png_h - 1);
art_h = min(win_h, win_w / png_aspect);
art_w = art_h * png_aspect;

// contrato de cinza do svg2relief.py: fundo em z100=20, topo da figura em 100
Z100_BG = 20;
Z100_TOP = 100;
zscale = (relief_max + relief_bury) / (Z100_TOP - Z100_BG);
relief_z0 = card_t - relief_bury - Z100_BG * zscale; // onde o z=0 do surface vai
surface_floor = relief_z0 - zscale;                  // fundo do solido do surface

total_t = card_t + max(relief_max, relief_h);
band_cy = frame_inset + frame_w + 2.5 + band_h / 2;
plate_w = plate_cols * card_w + (plate_cols - 1) * plate_gap;
plate_h = plate_rows * card_h + (plate_rows - 1) * plate_gap;

assert(card_t >= 1.0, "card_t abaixo de 1mm nao sai solido em FDM");
assert(win_w > 20 && win_h > 20, "Janela de arte pequena demais; revise frame_inset/band_h");
assert(foot_chamfer < card_t, "foot_chamfer precisa ser menor que card_t");
assert(surface_floor > 0.05,
       "O heightmap furaria o verso do card: aumente card_t ou reduza relief_bury");
assert(art_w <= win_w + eps && art_h <= win_h + eps, "Arte estourou a janela");

echo(str("pokemon-filler-card-01: card ", card_w, " x ", card_h, " mm, corpo ", card_t, " mm"));
echo(str("  fonte da arte: ", art_src, " | espessura total do card acabado: ", total_t, " mm"));
echo(str("  janela de arte: ", win_w, " x ", win_h, " mm, centro em [", win_cx, ", ", win_cy, "]"));
echo(str("  arte encaixada: ", art_w, " x ", art_h, " mm (heightmap ", png_w, "x", png_h, " px)"));
echo(str("  resolucao do relevo: ", art_w / (png_w - 1), " mm/px"));
echo(str("  relevo da figura: face + 0.2 a face + ", relief_max,
         " mm; os niveis vem do PNG, ver svg2relief.py"));
echo(str("  z0 do surface em ", relief_z0, " mm | piso do solido do surface em ",
         surface_floor, " mm (precisa ser > 0)"));
echo(str("  moldura: de ", frame_inset, " a ", card_w - frame_inset,
         " em X e ", card_h - frame_inset, " em Y (tem que ser simetrica)"));
echo(str("  chapa ", plate_cols, "x", plate_rows, " = ", plate_cols * plate_rows,
         " cards, footprint ", plate_w, " x ", plate_h, " mm"));

// ---------------------------------------------------------------------
// Formas 2D
// ---------------------------------------------------------------------
module card_outline_2d(inset = 0) {
    translate([corner_r, corner_r])
        offset(r = -inset) offset(r = corner_r)
            square([card_w - 2 * corner_r, card_h - 2 * corner_r]);
}

// Retangulo arredondado ANCORADO: canto inferior esquerdo exatamente em
// [x, y] e tamanho exatamente w x h. O translate soma o raio de proposito --
// offset(r) cresce para os DOIS lados, e sem essa compensacao a forma anda r
// para a esquerda e para baixo. Foi esse o bug da moldura v1, que saiu a
// 1.30mm da borda esquerda e 5.70mm da direita num card de 67mm.
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

module pokeball_2d(d) {
    r = d / 2;
    difference() {
        circle(r = r);
        translate([-r, -d * 0.045]) square([d, d * 0.09]);
        circle(r = d * 0.17);
    }
    circle(r = d * 0.105);
}

module labels_2d() {
    translate([card_w / 2, band_cy + 1.4])
        text(name_text, size = name_size, font = font,
             halign = "center", valign = "center");
    if (dex_text != "")
        translate([card_w / 2, band_cy - name_size * 0.85])
            text(str("#", dex_text), size = dex_size, font = font,
                 halign = "center", valign = "center");
}

module relief_2d() { frame_2d(); hex_marks_2d(); labels_2d(); }

// ---------------------------------------------------------------------
// Geometria 3D
// ---------------------------------------------------------------------
module card_body() {
    hull() {
        linear_extrude(eps) card_outline_2d(foot_chamfer);
        translate([0, 0, foot_chamfer]) linear_extrude(eps) card_outline_2d();
    }
    translate([0, 0, foot_chamfer])
        linear_extrude(card_t - foot_chamfer) card_outline_2d();
}

// baixo relevo de niveis a partir do heightmap
module art_relief() {
    translate([win_cx + art_dx, win_cy + art_dy, relief_z0])
        mirror([0, art_flip_y ? 1 : 0, 0])
            scale([art_w / (png_w - 1), art_h / (png_h - 1), zscale])
                translate([-(png_w - 1) / 2, -(png_h - 1) / 2, 0])
                    surface(file = relief_png, center = false, invert = false);
}

// silhueta chapada (SVG ja vetorizado como contorno) ou pokebola de fallback
module art_flat_2d() {
    if (art_src == "svg")
        resize([0, art_h], auto = true) import(svg_file, center = true);
    else
        pokeball_2d(min(win_w, win_h));
}

module trim() {
    translate([0, 0, card_t - eps]) linear_extrude(relief_h + eps) relief_2d();
}

module card() {
    union() {
        card_body();
        translate([0, 0, card_t - eps]) linear_extrude(relief_h + eps) relief_2d();
        // Sem intersection() de guarda aqui de proposito: quem garante que a
        // arte nao passa do card e' o assert de art_w/art_h contra a janela,
        // que e' de graca. A intersecao custava ~20s de CGAL POR CARD e fazia
        // a chapa de 6 estourar 2 minutos sem exportar nada.
        if (art_src == "relief")
            art_relief();
        else
            translate([win_cx + art_dx, win_cy + art_dy, card_t - eps])
                linear_extrude(relief_h + eps) art_flat_2d();
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
