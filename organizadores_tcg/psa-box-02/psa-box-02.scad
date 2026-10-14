// psa-box-02.scad
// Caixa de 10 slabs PSA com Pokébola gravada na tampa — fonte paramétrica
// PRÓPRIA do "Porta carte PSA x10" (DAMA_Lab,
// terceiros/no-ams-scatola-porta-10-carte-psa-pokemon-pokeball/), com os
// números da original medidos na malha dela.
//
// POR QUE EXISTE: ter a caixa da DAMA_Lab em OpenSCAD, com cada medida virando
// parâmetro, pra poder ajustar sem mexer em malha de terceiro. Nenhum
// triângulo da original foi reaproveitado — só os números de engenharia
// reversa abaixo.
//
// HISTÓRICO (2026-10-13): a primeira versão desta fonte tinha uma tampa
// "engrossada" (parede 3.0, teto 3.0, base 6.5, externo 98 x 101.5) e folga de
// deslize de 0.5/lado (regra 6 do CLAUDE.md). Foi impressa e o TESTE FÍSICO
// reprovou: a capa ficou SOLTA, e a original, com 0.1/lado, estava muito boa
// na mão. Decisão do usuário: voltar a TODOS os números da original. A folga
// de 0.1/lado aqui é intencional e contraria a regra 6 de propósito — neste
// encaixe curto (30mm de gargalo, tampa de parede fina) a 0.5/lado foi
// testada e ficou solta. NÃO "corrigir" de volta pra 0.5.
//
// O que é igual à original (medido na malha, 2026-10-13):
//   base 95.0 x 98.5 x 105.5, tampa 95.0 x 98.5 x 70.0, fechada 145.5;
//   canaleta 85.0 x 88.5, 10 vagas de 7.5 com divisória 1.5 (passo 9.0),
//   nervuras de 7mm nas duas paredes laterais; chão 3.5; parede da base 5.0;
//   gargalo 91.0 x 94.5 x 30 com parede 3.0 e quinas vivas; ombro a 72mm do
//   chão da vaga; vão da tampa 91.2 x 94.7 (0.1/lado) com quinas vivas;
//   parede da tampa 1.9 e teto 1.9; cantos verticais externos r2.0; aresta do
//   chão da base arredondada r2.0, aresta do teto da tampa r3.0, topo externo
//   do gargalo r1.0 e boca da tampa r1.0 (as duas bocas viram entrada);
//   Pokébola gravada 1.0 fundo.
//
// COMO SE MANUSEIA:
//   Slabs entram em pé, de cima, uma por vaga; sobram ~37mm pra fora da boca
//   do gargalo pra pegar. A tampa desce por cima do gargalo (o raio r1.0 nas
//   duas bocas guia a entrada) e assenta no ombro; fechada, a lateral fica
//   lisa e contínua. Pra abrir, segura a base e puxa a tampa — o encaixe de
//   0.1/lado é justo de propósito, segura a tampa sem trava.
//
// Peças: "base" e "lid". Juntas cabem numa chapa só da AD5X (~198 x 98.5).
// As duas imprimem SEM SUPORTE na orientação exportada: base com o chão na
// cama, tampa com a Pokébola na cama. O fundo da gravação é PONTE: no anel,
// onde a linha corre paralela à direção da ponte, o vão chega a ~40mm e o
// fundo pode sair meio caído (estético; a original tem o mesmo). Com o IFS
// dá pra trocar de cor nas camadas 0-1mm e preencher a gravação.
//   openscad -o stl/psa-box-02-base.stl -D 'part="base"' psa-box-02.scad
//   openscad -o stl/psa-box-02-lid.stl  -D 'part="lid"'  psa-box-02.scad
//   openscad -o 3mf/psa-box-02-plate.3mf -D 'part="plate"' psa-box-02.scad
//   openscad -o 3mf/psa-box-02-lid.3mf   -D 'part="lid"'   psa-box-02.scad
// (Windows: "C:/Program Files/OpenSCAD/openscad.com", caminhos absolutos.)
// ("plate" = base + tampa lado a lado; "lid" sozinho serve pra reimprimir só
// a tampa.) part="demo" e part="cut" são SÓ pra preview.
//
// Fatiador: o perfil da original vinha em 0.16mm, 2 paredes, 10% de
// preenchimento (Bambu A1 mini). Com bico 0.4, a parede de 1.9 da tampa fica
// praticamente maciça com 4 perímetros.

/* [Peça a renderizar] */
part = "both"; // "base" | "lid" | "plate" | "both" | "demo" | "cut"

/* [Interior - igual ao original, testado com slab na mão] */
inner_x  = 85.0; // mm, canaleta (atravessa a largura da slab)
slot_t   = 7.5;  // mm, vaga (espessura da slab 7.1 + 0.2/lado)
divider  = 1.5;  // mm, nervura entre vagas
slots    = 10;   // nº de slabs
rib_len  = 7.0;  // mm, quanto cada nervura avança a partir da parede lateral
rib_fil  = 3.0;  // mm, reforço em rampa 45° no pé da nervura (na original é uma concordância curva que avança ~5 no chão)
rib_h    = 80.5; // mm, altura da nervura a partir do chão da vaga (original: topo a 80.0, arredondado)
rib_lead = 4.0;  // mm, rampa no topo da nervura (funil de entrada da slab)
head_in  = 140.1; // mm, do chão da vaga ao teto da tampa fechada (original: 72 + 68.1)

/* [Paredes - números da original] */
floor_t   = 3.5; // mm, chão da base
body_wall = 5.0; // mm, parede da base abaixo do ombro
neck_wall = 3.0; // mm, parede do gargalo
neck_h    = 30;  // mm, altura do gargalo = curso de encaixe da tampa
body_in_h = 72;  // mm, do chão da vaga ao ombro
lid_fit   = 0.1; // mm por lado, folga tampa/gargalo — DA ORIGINAL, escolha do usuário (0.5 testada em 2026-10 ficou solta)
lid_wall  = 1.9; // mm, parede da tampa
lid_top   = 1.9; // mm, teto da tampa (0.9 embaixo da gravação, como na original)

/* [Acabamento - raios da original] */
corner_r    = 2.0; // mm, raio dos cantos verticais externos (base e tampa)
neck_r      = 0;   // mm, canto vertical do gargalo (quina viva)
lid_in_r    = 0;   // mm, canto vertical do vão da tampa (quina viva, casa com o gargalo)
foot_round  = 2.0; // mm, raio da aresta do chão da base (também segura o pé de elefante)
top_round   = 3.0; // mm, raio da aresta do teto da tampa (fica na cama)
neck_round  = 1.0; // mm, raio da aresta externa do topo do gargalo (entrada da tampa)
mouth_round = 1.0; // mm, raio da aresta interna da boca da tampa (entrada no gargalo)
round_steps = 8;   // nº de fatias por arredondamento

/* [Pokébola gravada no teto da tampa] */
ball_r     = 37.6; // mm, raio externo do anel
ring_w     = 6.0;  // mm, largura do anel
band_w     = 5.1;  // mm, largura da faixa do meio
button_r   = 7.25; // mm, botão central (fica em relevo, a volta dele é gravada)
button_gap = 5.05; // mm, largura do anel gravado em volta do botão
engrave    = 1.0;  // mm, profundidade da gravação

/* [Qualidade] */
$fn = 64;

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
inner_y  = slots * slot_t + (slots - 1) * divider; // 88.5
pitch    = slot_t + divider;                       // 9.0
neck_x   = inner_x + 2 * neck_wall;                // 91.0
neck_y   = inner_y + 2 * neck_wall;                // 94.5
lid_in_x = neck_x + 2 * lid_fit;                   // 91.2
lid_in_y = neck_y + 2 * lid_fit;                   // 94.7
box_x    = lid_in_x + 2 * lid_wall;                // 95.0
box_y    = lid_in_y + 2 * lid_wall;                // 98.5
shoulder = floor_t + body_in_h;                    // 75.5
base_h   = shoulder + neck_h;                      // 105.5
lid_in_h = head_in - body_in_h;                    // 68.1
lid_h    = lid_in_h + lid_top;                     // 70.0
closed_h = shoulder + lid_h;                       // 145.5
seat     = (box_x - neck_x) / 2;                   // 2.0, largura do ombro
seat_lid = lid_wall - mouth_round;                 // 0.9, apoio plano da tampa no ombro
plate_gap = 8;                                     // mm entre as peças na chapa

assert(box_x - 2 * body_wall > inner_x - 0.01, "parede da base invadiu a canaleta");
assert(abs((box_x - inner_x) / 2 - body_wall) < 0.01, "base e tampa com larguras diferentes");
assert(rib_h + floor_t <= base_h, "nervura passa da boca");
assert(mouth_round < lid_wall, "raio da boca come a parede da tampa inteira");

echo(str("psa-box-02: base ", box_x, " x ", box_y, " x ", base_h,
         " | tampa ", box_x, " x ", box_y, " x ", lid_h,
         " | fechado h=", closed_h, " | chapa ", 2 * box_x + plate_gap, " x ", box_y));
echo(str("encaixe: gargalo ", neck_x, " x ", neck_y, " | vao da tampa ", lid_in_x, " x ", lid_in_y,
         " | folga ", lid_fit, "/lado em ", neck_h, "mm | ombro z=", shoulder,
         " | ombro ", seat, " / apoio plano da tampa ", seat_lid));
echo(str("paredes: tampa ", lid_wall, " | teto ", lid_top, " - gravacao ", engrave,
         " = ", lid_top - engrave, " | base ", body_wall, " | gargalo ", neck_wall,
         " | chao ", floor_t));
echo(str("raios: cantos ", corner_r, " | pe da base ", foot_round, " | teto da tampa ", top_round,
         " | topo do gargalo ", neck_round, " | boca da tampa ", mouth_round));
echo(str("vagas: ", slots, " x ", slot_t, " passo ", pitch, " | canaleta ", inner_x, " x ", inner_y,
         " | chao da vaga ao teto ", head_in));

// ---------------------------------------------------------------------
// Primitivas
// ---------------------------------------------------------------------
module rrect(x, y, r) {
    rr = max(min(r, min(x, y) / 2 - 0.01), 0.01);
    offset(r = rr) square([x - 2 * rr, y - 2 * rr], center = true);
}

// recuo de uma aresta arredondada de raio R a uma altura t (0 = na face)
function round_in(R, t) = R - sqrt(max(R * R - (R - t) * (R - t), 0));

// prisma de cantos verticais r com aresta de baixo (rb) e de cima (rt)
// arredondadas; convexo, então um hull das fatias resolve
module rbox(x, y, h, r, rb = 0, rt = 0) {
    e = 0.01;
    n = round_steps;
    hull() {
        translate([0, 0, rb]) linear_extrude(h - rb - rt) rrect(x, y, r);
        if (rb > 0) for (i = [0 : n - 1]) {
            t = rb * i / n; d = round_in(rb, t);
            translate([0, 0, t]) linear_extrude(e) rrect(x - 2 * d, y - 2 * d, r - d);
        }
        if (rt > 0) for (i = [0 : n - 1]) {
            t = rt * i / n; d = round_in(rt, t);
            translate([0, 0, h - t - e]) linear_extrude(e) rrect(x - 2 * d, y - 2 * d, r - d);
        }
    }
}

// alargamento côncavo de raio R na boca de um vão x*y (boca em z = 0, vão
// pra baixo). Não é convexo: hull de fatia em fatia.
module mouth_flare(x, y, r, R) {
    n = round_steps;
    for (i = [0 : n - 1]) {
        t0 = R * i / n; t1 = R * (i + 1) / n;
        d0 = round_in(R, t0); d1 = round_in(R, t1);
        hull() {
            translate([0, 0, -t0 - 0.01]) linear_extrude(0.02) rrect(x + 2 * d0, y + 2 * d0, r + d0);
            translate([0, 0, -t1 - 0.01]) linear_extrude(0.02) rrect(x + 2 * d1, y + 2 * d1, r + d1);
        }
    }
    translate([0, 0, -0.01]) linear_extrude(1) rrect(x + 2 * R, y + 2 * R, r + R);
}

// ---------------------------------------------------------------------
// Base
// ---------------------------------------------------------------------
module rib() {
    // nervura de rib_len saindo da parede, com rampa 45° no pé (reforço) e
    // no topo (funil) — nada horizontal em balanço
    // corpo: rib_len constante até rib_h - rib_lead, depois rampa até a parede
    hull() {
        translate([0, -divider / 2, 0]) cube([rib_len, divider, rib_h - rib_lead]);
        translate([0, -divider / 2, rib_h - 0.01]) cube([0.6, divider, 0.01]);
    }
    // pé: reforço 45° só nos primeiros rib_fil mm
    hull() {
        translate([0, -divider / 2, 0]) cube([rib_len + rib_fil, divider, 0.01]);
        translate([0, -divider / 2, 0]) cube([rib_len, divider, rib_fil]);
    }
}

module base() {
    difference() {
        union() {
            rbox(box_x, box_y, shoulder, corner_r, rb = foot_round);
            translate([0, 0, shoulder - 0.01])
                rbox(neck_x, neck_y, neck_h + 0.01, neck_r, rt = neck_round);
        }
        translate([0, 0, floor_t]) linear_extrude(base_h) square([inner_x, inner_y], center = true);
    }
    // nervuras: entre vagas vizinhas, nas duas paredes laterais
    for (i = [1 : slots - 1], s = [-1, 1]) {
        y = -inner_y / 2 + i * pitch - divider / 2;
        translate([s * inner_x / 2, y, floor_t - 0.01]) scale([-s, 1, 1]) rib();
    }
}

// ---------------------------------------------------------------------
// Tampa (modelada já na orientação de impressão: teto na cama, boca pra cima)
// ---------------------------------------------------------------------
module pokeball_2d() {
    difference() {
        circle(r = ball_r);
        circle(r = ball_r - ring_w);
    }
    difference() {
        square([2 * (ball_r - ring_w / 2), band_w], center = true);
        circle(r = button_r + button_gap - 0.01);
    }
    difference() {
        circle(r = button_r + button_gap);
        circle(r = button_r);
    }
}

module lid() {
    difference() {
        rbox(box_x, box_y, lid_h, corner_r, rb = top_round);
        // vão interno + raio de entrada na boca
        translate([0, 0, lid_top]) linear_extrude(lid_h) rrect(lid_in_x, lid_in_y, lid_in_r);
        translate([0, 0, lid_h]) mouth_flare(lid_in_x, lid_in_y, lid_in_r, mouth_round);
        // Pokébola gravada na face que vai na cama (a de fora quando fechada).
        // Espelhada pra ficar certa vista de fora.
        translate([0, 0, -0.01]) linear_extrude(engrave + 0.01) mirror([1, 0, 0]) pokeball_2d();
    }
}

// ---------------------------------------------------------------------
// Saídas
// ---------------------------------------------------------------------
module lid_closed() {
    translate([0, 0, shoulder + lid_h]) mirror([0, 0, 1]) lid();
}

if (part == "base") base();
else if (part == "lid") lid();
else if (part == "plate" || part == "both") {
    translate([-(box_x + plate_gap) / 2, 0, 0]) base();
    translate([(box_x + plate_gap) / 2, 0, 0]) lid();
}
else if (part == "demo") {
    base();
    color("silver", 0.6)
        for (i = [0 : slots - 1])
            translate([0, -inner_y / 2 + i * pitch + slot_t / 2, floor_t + 139 / 2])
                cube([83.6, 7.1, 139], center = true);
    color("tomato") translate([0, 0, 60]) lid_closed();
}
else if (part == "cut") {
    difference() {
        union() {
            base();
            color("tomato") lid_closed();
        }
        translate([-200, 0, -1]) cube([400, 200, 300]);
    }
}
