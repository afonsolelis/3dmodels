// pokemon-coin-stack-01.scad
// Porta-moedas de mesa em PILHA para moedas Pokemon TCG (flip coins /
// marcadores), BLOCO UNICO de 70mm com 9 tubos verticais: as moedas ficam
// DEITADAS, empilhadas dentro de cada tubo.
//   - 3 tubos pequenos  (moeda Ø42mm,   furo Ø44)   — degrau da FRENTE
//   - 3 tubos grandes   (moeda Ø51.5mm, furo Ø53.5) — fileira do MEIO
//   - 3 tubos grandes   (moeda Ø51.5mm, furo Ø53.5) — fileira de TRAS
//
// Arranjo em ARQUIBANCADA (2 degraus) e por que:
//   Tirar moeda do fundo de um tubo de 65mm exige uma fenda vertical de dedo
//   aberta pro LADO DE FORA. Com 3 fileiras, a do meio fica presa entre as
//   outras duas — e por conta (perimetro necessario ~480mm de passo entre
//   tubos), deixar os 9 tubos na borda de um bloco de altura cheia pede
//   >210mm de cama. Entao o degrau da frente (tubos pequenos) para em
//   tier_h=36mm, o fundo dos tubos do meio fica nessa mesma altura, e a fenda
//   deles abre pra frente POR CIMA do degrau. A fileira de tras tem altura
//   cheia e fenda pra TRAS. Todas as 9 fendas dao pra fora.
//
// Como se usa na mao:
//   - Guardar: solta a moeda na boca do tubo (chanfro de entrada); ela desce
//     deitada ate a pilha. Folga de conteudo de 1mm por lado.
//   - Tirar: a fenda de 20mm do tubo deixa o indicador (~16mm) entrar
//     INTEIRO; a borda da moeda fica 4mm pra dentro da face. Encosta e
//     empurra a pilha pra cima ate as de cima sairem pela boca. A fenda tem
//     fundo RETO no nivel do fundo do tubo, entao ate a ultima moeda fica
//     exposta na largura cheia. Pra ULTIMA moeda: o piso de cada tubo tem
//     um REBAIXO de dedo (16mm de largura, 2.8 de fundo, entra 12mm no tubo
//     a partir da fenda); a moeda de baixo fica em ponte sobre ele e a ponta
//     do dedo entra por baixo da beirada. Frente/tras: piso de 4.4mm (sobra
//     1.6 sob o rebaixo); nos pequenos o rebaixo vira canal de 20mm
//     (largura do furo) fundido no furo do fundo, sem bico na juncao.
//     Os tubos do meio tem o fundo no nivel do degrau: o dedo chega deitado
//     por cima do degrau. Alternativa nos tubos da frente e de tras: furo
//     Ø20 no fundo pra empurrar a pilha por baixo.
//
// Visual: Pokebola em faixas de cor por ALTURA (branco embaixo, faixa preta
// de 26 a 36.2mm — que cobre o TOPO do degrau da frente — e vermelho em
// cima). No IFS da AD5X sao so DUAS trocas de filamento no job inteiro.
// Nas laterais um medalhao redondo (vira uma mini-Pokebola, porque herda as
// 3 faixas) com botao PRETO inteiro dentro da faixa (z 26.4-35.8): botao
// branco custaria ~50 trocas de filamento (uma por camada na altura da
// faixa) contra as 2 do job, entao ficou preto. Colmeia de hexagonos de ponta pra cima rebaixada 0.8mm nas
// paredes externas, longe das fendas. Sulco horizontal na base da faixa pra
// ela aparecer tambem em impressao mono.
//
// Impressao: em pe, de boca pra cima, como exportado. Sem suporte (fenda e'
// aberta em cima e o fundo dela e' o proprio piso, medalhao/botao sao
// troncos de cone a 45 graus, aresta do degrau com chanfro a 45, pe com
// chanfro de 0.6 contra pe de elefante). Fatiar com 1a camada de 0.2 pra
// os cortes de cor (26.0 / 36.2) cairem em fronteira de camada. Prime
// tower estreita (<=18mm) num canto, ou desligada; infill 10-15%.
//
// Exports canonicos — caminhos ABSOLUTOS; -D so em `part` (variavel final):
//   OpenSCAD = "C:/Program Files/OpenSCAD/openscad.com" (Windows) ou
//              flatpak run org.openscad.OpenSCAD (Linux)
//   $OPENSCAD -o <abs>/stl/pokemon-coin-stack-01.stl       -D 'part="block"' <abs>/pokemon-coin-stack-01.scad
//   $OPENSCAD -o <abs>/stl/pokemon-coin-stack-01-white.stl -D 'part="white"' <abs>/pokemon-coin-stack-01.scad
//   $OPENSCAD -o <abs>/stl/pokemon-coin-stack-01-black.stl -D 'part="black"' <abs>/pokemon-coin-stack-01.scad
//   $OPENSCAD -o <abs>/stl/pokemon-coin-stack-01-red.stl   -D 'part="red"'   <abs>/pokemon-coin-stack-01.scad
//   3MF de impressao (job unico, 1 objeto com 3 pecas = 3 filamentos):
//   python3 cartoes/armarouge-card-2cores-01/multicolor3mf.py \
//     coin_holders/pokemon-coin-stack-01/3mf/pokemon-coin-stack-01.3mf \
//     --name pokemon-coin-stack-01 --colors "#F2F2F2,#1A1A1A,#D32020" \
//     --part branco 1 coin_holders/pokemon-coin-stack-01/stl/pokemon-coin-stack-01-white.stl \
//     --part faixa  2 coin_holders/pokemon-coin-stack-01/stl/pokemon-coin-stack-01-black.stl \
//     --part tampa  3 coin_holders/pokemon-coin-stack-01/stl/pokemon-coin-stack-01-red.stl

/* [Peca a renderizar] */
// "block"   bloco inteiro, mono
// "white" | "black" | "red"  zona de cor (pecas do 3MF multicolor)
// "preview" bloco colorido, so pra olhar (F5)
part = "preview";

/* [Moedas - medidas reais do usuario] */
coin_big_d   = 51.5; // mm, Ø da moeda grande (medida do usuario)
coin_small_d = 42.0; // mm, Ø da moeda pequena (medida do usuario)
coin_t       = 2.7;  // mm, espessura SUPOSTA (a grande medida no coin-binder-01; so pra ecoar capacidade)
n_cols       = 3;    // tubos por fileira (3 pequenos, 3+3 grandes)

/* [Bloco] */
height     = 70.0; // mm, altura total (fileiras do meio e de tras)
tier_h     = 36.0; // mm, altura do degrau da frente = fundo dos tubos do meio (multiplo de 0.2)
floor_t    = 4.4;  // mm, fundo dos tubos da frente/tras (22 camadas; grosso pra caber o rebaixo de dedo com 1.6 embaixo)
fit        = 1.0;  // mm por lado, folga de conteudo (padrao do repo ~1)
wall       = 3.0;  // mm, parede externa minima na frente de cada tubo
web        = 3.0;  // mm, parede entre tubos grandes vizinhos
riser_gap  = 3.0;  // mm, de borda do tubo pequeno ate a face do degrau (folga do chanfro da boca)
corner_r   = 8.0;  // mm, raio dos cantos verticais do bloco
mouth_ch   = 1.0;  // mm, chanfro de entrada na boca (1.0 deixa 1mm de topo plano nas divisorias de 3mm)
top_ch     = 1.0;  // mm, chanfro das arestas externas de topo
foot_ch    = 0.6;  // mm, chanfro do pe (anti pe de elefante)
floor_hole = 20.0; // mm, Ø do furo no fundo dos tubos da frente/tras

/* [Fenda de dedo] */
slot_w  = 20.0; // mm, largura da fenda (indicador ~16 entra inteiro)
slot_ch = 1.0;  // mm, chanfro das bordas da fenda na face externa
slot_r  = 3.0;  // mm, raio dos cantos do fundo da fenda

/* [Rebaixo de dedo no piso] */
// Canal no piso de cada tubo, nascendo da fenda e entrando no tubo: a
// ultima moeda fica em PONTE sobre ele e a ponta do dedo entra por baixo
// da beirada dela.
rec_w     = 16.0; // mm, largura do rebaixo
rec_len   = 12.0; // mm, quanto entra no tubo (radial, a partir da parede do furo)
rec_depth = 2.8;  // mm, profundidade abaixo do piso
rec_ch    = 0.8;  // mm, chanfro das bordas de cima do rebaixo
rec_min_floor = 2.0; // mm, se a ponta do rebaixo ficar a menos disso do furo do fundo, ele vira canal da largura do furo, fundido nele (sem lasca)

/* [Pokebola] */
band_lo   = 26.0;   // mm, inicio da faixa preta (multiplo de 0.2)
band_hi   = tier_h + 0.2; // mm, fim da faixa preta: 1 camada ACIMA do topo do degrau (corte coplanar com o degrau gera folha degenerada)
groove_d  = 0.6;  // mm, profundidade do sulco na base da faixa
groove_h  = 1.0;  // mm, altura do sulco
med_d     = 26.0; // mm, Ø do medalhao nas laterais (no topo do cone)
med_h     = 1.6;  // mm, quanto o medalhao sobressai
btn_d     = 7.0;  // mm, Ø do botao (no topo do cone); base = btn_d+2*btn_h tem que caber DENTRO da faixa preta
btn_h     = 1.2;  // mm, quanto o botao sobressai do medalhao
btn_ring  = 3.6;  // mm, Ø interno do anel gravado no botao (sulco de 0.6, sobra 1.1 de aba)
col_white = "#F2F2F2";
col_black = "#1A1A1A";
col_red   = "#D32020";

/* [Colmeia nas paredes] */
hex_r     = 4.2; // mm, circunraio do hexagono (centro -> ponta)
hex_webw  = 1.8; // mm, largura da teia entre celulas
hex_depth = 0.8; // mm, profundidade das celulas
hex_m     = 2.6; // mm, faixa solida minima ate fenda/faixa/canto/borda

/* [Qualidade] */
$fn = 96;

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
eps = 0.01;
band_zc = (band_lo + band_hi) / 2;

hole_b = coin_big_d + 2 * fit;     // furo grande
hole_s = coin_small_d + 2 * fit;   // furo pequeno
Rb = hole_b / 2;
Rs = hole_s / 2;
pitch = hole_b + web;              // passo em X (pequenos alinhados com grandes)

W = (n_cols - 1) * pitch + hole_b + 2 * wall;
D = wall + hole_s + riser_gap + wall + hole_b + web + hole_b + wall;

y_front = -D / 2 + wall + Rs;           // centro dos tubos pequenos
y_r     = y_front + Rs + riser_gap;     // face do degrau (riser)
y_mid   = y_r + wall + Rb;              // centro dos tubos grandes do meio
y_back  = y_mid + pitch;                // centro dos tubos grandes de tras
y_med   = (y_r + D / 2) / 2;            // medalhao centrado na parte alta

function col_x(i) = (i - (n_cols - 1) / 2) * pitch;
xs = [for (i = [0 : n_cols - 1]) col_x(i)];

btn_base = btn_d + 2 * btn_h;
function rec_len_for(R) =
    (R - rec_len - floor_hole / 2 < rec_min_floor) ? R : rec_len; // funde: vai ate o centro
depth_front = tier_h - floor_t;
depth_mid   = height - tier_h;
depth_back  = height - floor_t;

hex_hw  = hex_r * sqrt(3) / 2;          // meia largura (entre-faces / 2)
hex_px  = 2 * hex_hw + hex_webw;        // passo horizontal
hex_pz  = hex_px * sqrt(3) / 2;         // passo vertical entre fileiras

echo(str("BLOCO ", W, " x ", D, " x ", height, " | degrau ", tier_h,
         " | face do degrau em y=", y_r));
echo(str("furos: pequeno ", hole_s, " grande ", hole_b, " | passo X ", pitch));
echo(str("profundidade/capacidade (moeda ", coin_t, "mm SUPOSTA): frente ",
         depth_front, "mm ~", floor(depth_front / coin_t), " | meio ",
         depth_mid, "mm ~", floor(depth_mid / coin_t), " | tras ",
         depth_back, "mm ~", floor(depth_back / coin_t),
         " | total ~", n_cols * (floor(depth_front / coin_t) +
         floor(depth_mid / coin_t) + floor(depth_back / coin_t))));
echo(str("moeda recuada da face: grande ", Rb + wall - coin_big_d / 2,
         " pequeno ", Rs + wall - coin_small_d / 2,
         " | parede na borda da fenda: grande ",
         Rb + wall - sqrt(Rb * Rb - slot_w * slot_w / 4),
         " pequeno ", Rs + wall - sqrt(Rs * Rs - slot_w * slot_w / 4)));
echo(str("parede lateral minima: pequeno ", W / 2 - xs[n_cols - 1] - Rs,
         " grande ", W / 2 - xs[n_cols - 1] - Rb,
         " | chanfro da boca pequena ate o degrau ", riser_gap - mouth_ch,
         " | topo plano na divisoria ", web - 2 * mouth_ch));
echo(str("botao: z ", band_zc - btn_base / 2, " a ", band_zc + btn_base / 2,
         " dentro da faixa ", band_lo, "-", band_hi, " ? ",
         band_zc - btn_base / 2 >= band_lo && band_zc + btn_base / 2 <= band_hi));
echo(str("rebaixo: sobra embaixo frente/tras ", floor_t - rec_depth,
         " meio ", tier_h - rec_depth, " (z ", tier_h - rec_depth, "-", tier_h,
         ") | comprimento grande ", rec_len_for(Rb), " pequeno ", rec_len_for(Rs),
         " | piso entre ponta e furo: grande ", Rb - rec_len_for(Rb) - floor_hole / 2,
         " pequeno ", Rs - rec_len_for(Rs) - floor_hole / 2, " (negativo = funde no furo)"));

// ---------------------------------------------------------------------
// 2D / helpers
// ---------------------------------------------------------------------
module rrect(w, d, r) {
    offset(r = r) square([w - 2 * r, d - 2 * r], center = true);
}

module hex2d(r) { rotate(90) circle(r = r, $fn = 6); } // ponta pra cima

// perfil da fenda no plano (u, z): fundo RETO no nivel do fundo do tubo
// (zf), cantos com raio slot_r, aberta ate acima do topo. Fundo reto e' pro
// dedo alcancar a moeda de baixo com a largura cheia de 20mm.
module slot2d(w, zf) {
    translate([-w / 2, zf])
        offset(r = slot_r) offset(delta = -slot_r) square([w, height + 2 * slot_r]);
}

// casca de altura h com chanfro no pe e no topo
module shell(h) {
    hull() {
        linear_extrude(eps) rrect(W - 2 * foot_ch, D - 2 * foot_ch, corner_r - foot_ch);
        translate([0, 0, foot_ch])
            linear_extrude(h - foot_ch - top_ch) rrect(W, D, corner_r);
        translate([0, 0, h - eps])
            linear_extrude(eps) rrect(W - 2 * top_ch, D - 2 * top_ch, corner_r - top_ch);
    }
}

// corpo em degrau: frente ate tier_h, parte alta de y_r pra tras
module body() {
    shell(tier_h);
    difference() {
        intersection() {
            shell(height);
            translate([-W, y_r, -1]) cube([2 * W, D, height + 2]);
        }
        // chanfro da aresta de topo do degrau
        translate([0, y_r, height]) rotate([45, 0, 0])
            cube([2 * W, top_ch * sqrt(2), top_ch * sqrt(2)], center = true);
    }
}

module tube_cut(hd, zf, through) {
    translate([0, 0, zf]) cylinder(d = hd, h = height);
    if (through) translate([0, 0, -1]) cylinder(d = floor_hole, h = zf + 2);
}

module mouth_cut(hd, ztop) {
    translate([0, 0, ztop - mouth_ch])
        cylinder(d1 = hd, d2 = hd + 2 * mouth_ch + 2 * eps, h = mouth_ch + eps);
}

// fenda radial; frame da FRENTE: face em y = -n, tubo em (0, yc), fundo zf
module slot_cut(n, yc, zf) {
    translate([0, yc, 0]) rotate([90, 0, 0])
        linear_extrude(yc + n + 1) slot2d(slot_w, zf);
    // chanfro das bordas; recortado em z >= zf pra nao morder o degrau
    intersection() {
    translate([-slot_w, -n - 5, zf]) cube([2 * slot_w, slot_ch + 10, height]);
    hull() {
        translate([0, -n + slot_ch, 0]) rotate([90, 0, 0])
            linear_extrude(eps) slot2d(slot_w, zf);
        translate([0, -n + eps, 0]) rotate([90, 0, 0])
            linear_extrude(eps) offset(delta = slot_ch) slot2d(slot_w, zf);
        translate([0, -n - 1, 0]) rotate([90, 0, 0])
            linear_extrude(eps) offset(delta = slot_ch + 1) slot2d(slot_w, zf);
    }
    }
}

// sulco na base da faixa (volta inteira)
module band_groove() {
    translate([0, 0, band_lo - groove_h / 2]) linear_extrude(groove_h)
        difference() {
            rrect(W + 2, D + 2, corner_r + 1);
            rrect(W - 2 * groove_d, D - 2 * groove_d, corner_r - groove_d);
        }
}

// ---------------------------------------------------------------------
// Colmeia numa face. Frame da FRENTE: face em y = -n, u = coordenada
// horizontal da face, comprimento L. slots = u das fendas. zmin = base da
// face. ysign: 0 = face de topo uniforme (top_hi); +-1 = face lateral, com
// y = ysign*u e topo top_lo antes do degrau / top_hi depois. med_u = u do
// medalhao (undef = sem).
// ---------------------------------------------------------------------
function cell_ok(u, z, L, slots, zmin, top_lo, top_hi, ysign, med_u) =
    let(
        rear    = ysign == 0 || (ysign * u - hex_hw >= y_r + hex_m),
        top     = rear ? top_hi : top_lo,
        in_u    = abs(u) + hex_hw <= L / 2 - corner_r - hex_m,
        in_low  = z - hex_r >= max(foot_ch, zmin) + hex_m
                  && z + hex_r <= band_lo - groove_h / 2 - hex_m,
        in_high = z - hex_r >= max(band_hi, zmin) + hex_m
                  && z + hex_r <= top - top_ch - hex_m,
        clear_s = len([for (s = slots)
                       if (abs(u - s) < slot_w / 2 + slot_ch + hex_m + hex_hw) 1]) == 0,
        clear_m = is_undef(med_u)
                  || norm([u - med_u, z - band_zc]) >= (med_d / 2 + med_h) + hex_m + hex_r
    ) in_u && (in_low || in_high) && clear_s && clear_m;

module face_hex(n, L, slots, zmin, top_lo, top_hi, ysign, med_u) {
    kmax = ceil(height / hex_pz) + 1;
    imax = ceil(L / hex_px) + 1;
    for (k = [-kmax : kmax], i = [-imax : imax]) {
        z = band_zc + k * hex_pz;
        u = i * hex_px + ((abs(k) % 2) == 1 ? hex_px / 2 : 0);
        if (cell_ok(u, z, L, slots, zmin, top_lo, top_hi, ysign, med_u))
            translate([u, -n + hex_depth, z]) rotate([90, 0, 0])
                linear_extrude(hex_depth + 1) hex2d(hex_r);
    }
}

// medalhao + botao (frame da frente, face em y=-n), centro (u, band_zc)
module medallion(n, u) {
    translate([u, -n + eps, band_zc]) rotate([90, 0, 0]) {
        cylinder(d1 = med_d + 2 * med_h, d2 = med_d, h = med_h);
        translate([0, 0, med_h - eps])
            difference() {
                cylinder(d1 = btn_d + 2 * btn_h, d2 = btn_d, h = btn_h);
                translate([0, 0, btn_h - 0.4])
                    difference() {
                        cylinder(d = btn_ring + 0.6 * 2, h = 1);
                        translate([0, 0, -0.5]) cylinder(d = btn_ring, h = 2);
                    }
            }
    }
}

// rebaixo de dedo no piso; frame local do tubo (centro na origem), fenda
// pra -y. y_out = onde o canal termina do lado de fora (relativo ao centro)
// Quando o rebaixo alcanca o furo do fundo (tubos pequenos), ele vira um
// canal reto da LARGURA DO FURO ate o centro: paredes tangentes ao furo, sem
// bico/lasca na juncao (com 16mm de largura sobravam cunhas de 37 graus).
function rec_merges(R) = R - rec_len - floor_hole / 2 < rec_min_floor;
module recess_plan(R, y_out) {
    if (rec_merges(R)) {
        hull() {
            circle(d = floor_hole);
            translate([-floor_hole / 2, y_out]) square([floor_hole, eps]);
        }
    } else {
        rw = rec_w / 2;
        hull() {
            translate([0, -(R - rec_len) - rw]) circle(r = rw);
            translate([-rw, y_out]) square([rec_w, eps]);
        }
    }
}
module recess_cut(R, zf, y_out) {
    hull() {
        translate([0, 0, zf - rec_depth])
            linear_extrude(rec_depth - rec_ch) recess_plan(R, y_out);
        translate([0, 0, zf - eps])
            linear_extrude(1) offset(r = rec_ch) recess_plan(R, y_out);
    }
}

// ---------------------------------------------------------------------
// Bloco completo
// ---------------------------------------------------------------------
module block() {
    union() {
        difference() {
            body();
            for (x = xs) {
                // frente: pequenos, fundo furado, boca no topo do degrau
                translate([x, y_front, 0]) { tube_cut(hole_s, floor_t, true); mouth_cut(hole_s, tier_h); }
                translate([x, y_front, 0]) slot_cut(D / 2 + y_front, 0, floor_t);
                translate([x, y_front, 0]) recess_cut(Rs, floor_t, -(D / 2 + y_front) - 1);
                // meio: grandes, fundo no nivel do degrau, fenda pra frente
                translate([x, y_mid, 0])   { tube_cut(hole_b, tier_h, false); mouth_cut(hole_b, height); }
                translate([x, 0, 0]) slot_cut(-y_r, y_mid, tier_h);
                // rebaixo do meio: o chanfro de cima termina NA face do degrau (nao morde o topo do degrau)
                translate([x, y_mid, 0]) recess_cut(Rb, tier_h, y_r - y_mid + rec_ch);
                // tras: grandes, altura cheia, fenda pra tras
                translate([x, y_back, 0])  { tube_cut(hole_b, floor_t, true); mouth_cut(hole_b, height); }
                rotate([0, 0, 180]) translate([-x, 0, 0]) slot_cut(D / 2, -y_back, floor_t);
                translate([x, y_back, 0]) rotate([0, 0, 180])
                    recess_cut(Rb, floor_t, -(D / 2 - y_back) - 1);
            }
            band_groove();
            // colmeia
            face_hex(D / 2, W, xs, 0, tier_h, tier_h, 0, undef);          // frente (degrau)
            face_hex(-y_r, W, xs, tier_h, height, height, 0, undef);      // face do degrau
            rotate([0, 0, 180]) face_hex(D / 2, W, [for (x = xs) -x], 0, height, height, 0, undef); // tras
            rotate([0, 0, 90])  face_hex(W / 2, D, [], 0, tier_h, height,  1,  y_med);  // lateral +x
            rotate([0, 0, -90]) face_hex(W / 2, D, [], 0, tier_h, height, -1, -y_med);  // lateral -x
        }
        rotate([0, 0, 90])  medallion(W / 2,  y_med);
        rotate([0, 0, -90]) medallion(W / 2, -y_med);
    }
}

module zone(z0, z1) {
    intersection() {
        children();
        translate([-500, -500, z0]) cube([1000, 1000, z1 - z0]);
    }
}

if (part == "block") block();
else if (part == "white") zone(-1, band_lo) block();
else if (part == "black") zone(band_lo, band_hi) block();
else if (part == "red")   zone(band_hi, height + 1) block();
else if (part == "preview") {
    color(col_white) zone(-1, band_lo) block();
    color(col_black) zone(band_lo, band_hi) block();
    color(col_red)   zone(band_hi, height + 1) block();
}
