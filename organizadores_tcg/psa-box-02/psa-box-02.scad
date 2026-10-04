// psa-box-02.scad
// Caixa de 10 slabs PSA com Pokébola gravada na tampa — versão RÍGIDA e com
// tampa que DESLIZA, refeita do zero a partir do "Porta carte PSA x10"
// (DAMA_Lab, terceiros/no-ams-scatola-porta-10-carte-psa-pokemon-pokeball/).
//
// POR QUE EXISTE: o original foi impresso (2026-10) e voltou com dois
// defeitos, os dois medidos na malha dele:
//   1. TAMPA MOLENGA: parede de 1.9mm em 70mm de altura e teto de 2.0mm, com
//      a Pokébola gravada 1.0mm fundo — embaixo do desenho sobrava 1.0mm.
//   2. TAMPA PRENDENDO: gargalo da base 91.0 x 94.5, vão da tampa 91.2 x 94.7
//      = 0.1mm POR LADO num encaixe de 30mm. Com empeno e pé de elefante isso
//      é interferência, não folga (regra 6 do repo: deslize 0.5/lado).
// Aqui: tampa com parede 3.0 e teto 3.0 (2.0 embaixo da gravação), folga de
// 0.5/lado com chanfro de entrada nas duas bocas, paredes da base de 6.5.
// Rigidez de parede cresce com o CUBO da espessura: (3.0/1.9)^3 ~ 3.9x na
// lateral da tampa e (2.0/1.0)^3 = 8x no teto embaixo da Pokébola.
//
// O INTERIOR É O MESMO DO ORIGINAL (que já foi testado com slab na mão):
// canaleta de 85.0 x 88.5, 10 vagas de 7.5 com divisória de 1.5 (passo 9.0),
// nervuras de 7mm saindo das duas paredes laterais, e 140mm do chão da vaga
// ao teto da tampa fechada. Nenhum triângulo da malha original foi
// reaproveitado — só estes números de engenharia reversa.
//
// COMPATIBILIDADE: o gargalo continua 91.0 x 94.5 e o ombro continua a 72mm
// do chão da vaga, então a tampa NOVA também serve na base ORIGINAL já
// impressa (folga 0.5/lado inclusive na diagonal da quina viva do gargalo
// original, por isso o vão da tampa tem canto r0.5; 140mm até o teto). Na
// base original a tampa apoia em 1.0mm do ombro (que lá tem só 2.0) e sobra
// 1.5mm de beiral por lado, porque ela tem 95 x 98.5 e a tampa 98 x 101.5.
//
// COMO SE MANUSEIA:
//   Slabs entram em pé, de cima, uma por vaga; sobram ~37mm pra fora da boca
//   do gargalo pra pegar. A tampa desce por cima do gargalo e assenta no
//   ombro; fechada, a lateral fica lisa e contínua. Pra abrir, segura a base
//   e puxa a tampa — com 0.5/lado ela sai sem trancar no meio do curso.
//
// Peças: "base" e "lid". Juntas cabem numa chapa só da AD5X (~204 x 101.5).
// As duas imprimem SEM SUPORTE na orientação exportada: base com o chão na
// cama, tampa com a Pokébola na cama. O fundo da gravação é PONTE: no anel,
// onde a linha corre paralela à direção da ponte, o vão chega a ~40mm e o
// fundo pode sair meio caído (estético; o original tinha o mesmo). Com o IFS
// dá pra trocar de cor nas camadas 0-1mm e preencher a gravação.
//   openscad -o stl/psa-box-02-base.stl -D 'part="base"' psa-box-02.scad
//   openscad -o stl/psa-box-02-lid.stl  -D 'part="lid"'  psa-box-02.scad
//   openscad -o 3mf/psa-box-02-plate.3mf -D 'part="plate"' psa-box-02.scad
//   openscad -o 3mf/psa-box-02-lid.3mf   -D 'part="lid"'   psa-box-02.scad
// ("plate" = base + tampa lado a lado; "lid" sozinho serve pra quem já tem a
// base original impressa.) part="demo" e part="cut" são SÓ pra preview.
//
// Fatiador: com paredes de 3.0 e 6.5, 4 perímetros + 20% gyroid já deixa a
// caixa praticamente maciça onde importa. O perfil do original vinha com 2
// perímetros e 15% de grid.

/* [Peça a renderizar] */
part = "both"; // "base" | "lid" | "plate" | "both" | "demo" | "cut"

/* [Interior - igual ao original, testado com slab na mão] */
inner_x  = 85.0; // mm, canaleta (atravessa a largura da slab)
slot_t   = 7.5;  // mm, vaga (espessura da slab 7.1 + 0.2/lado)
divider  = 1.5;  // mm, nervura entre vagas
slots    = 10;   // nº de slabs
rib_len  = 7.0;  // mm, quanto cada nervura avança a partir da parede lateral
rib_fil  = 3.0;  // mm, reforço em rampa 45° no pé da nervura
rib_h    = 80.5; // mm, altura da nervura a partir do chão da vaga (topo reto a 76.5, ponta da rampa 8.5 acima do ombro)
rib_lead = 4.0;  // mm, rampa no topo da nervura (funil de entrada da slab)
head_in  = 140;  // mm, do chão da vaga ao teto da tampa fechada (slab 139 + 1)

/* [Paredes - o ponto desta versão] */
floor_t   = 4.0; // mm, chão da base (era 3.5)
body_wall = 6.5; // mm, parede da base abaixo do ombro (era 5.0)
neck_wall = 3.0; // mm, parede do gargalo (igual ao original, garante compatibilidade)
neck_h    = 30;  // mm, altura do gargalo = curso de encaixe da tampa
body_in_h = 72;  // mm, do chão da vaga ao ombro (igual ao original)
lid_fit   = 0.5; // mm por lado, folga tampa/gargalo (padrão de deslize do repo; era 0.1)
lid_wall  = 3.0; // mm, parede da tampa (era 1.9)
lid_top   = 3.0; // mm, teto da tampa (era 2.0)
lead      = 1.0; // mm, chanfro 45° de entrada no topo do gargalo
lid_lead  = 0.5; // mm, chanfro 45° na boca da tampa (pequeno pra sobrar apoio no ombro da base ORIGINAL, que só tem 2.0)

/* [Acabamento] */
corner_r   = 5.0; // mm, raio dos cantos verticais externos
top_cham   = 1.5; // mm, chanfro da aresta do teto da tampa (fica na cama)
foot_cham  = 0.6; // mm, chanfro da aresta do chão da base (anti pé de elefante)

/* [Pokébola gravada no teto da tampa] */
ball_r     = 37.5; // mm, raio externo do anel
ring_w     = 6.0;  // mm, largura do anel
band_w     = 5.0;  // mm, largura da faixa do meio
button_r   = 7.3;  // mm, botão central (fica em relevo, a volta dele é gravada)
button_gap = 4.7;  // mm, largura do anel gravado em volta do botão
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
lid_in_x = neck_x + 2 * lid_fit;                   // 92.0
lid_in_y = neck_y + 2 * lid_fit;                   // 95.5
box_x    = lid_in_x + 2 * lid_wall;                // 98.0
box_y    = lid_in_y + 2 * lid_wall;                // 101.5
shoulder = floor_t + body_in_h;                    // 76.0
base_h   = shoulder + neck_h;                      // 106.0
lid_in_h = head_in - body_in_h;                    // 68.0
lid_h    = lid_in_h + lid_top;                     // 71.0
closed_h = shoulder + lid_h;                       // 147.0
neck_r   = 1.5;                                    // canto externo do gargalo
lid_in_r = 0.5;                                    // canto do vão da tampa: o gargalo ORIGINAL tem quina VIVA,
                                                   // e com r maior a diagonal interfere (r=2.0 dava -0.12)
plate_gap = 8;                                     // mm entre as peças na chapa

assert(box_x - 2 * body_wall > inner_x - 0.01, "parede da base invadiu a canaleta");
assert(abs((box_x - inner_x) / 2 - body_wall) < 0.01, "base e tampa com larguras diferentes");
assert(rib_h + floor_t <= base_h, "nervura passa da boca");

echo(str("psa-box-02: base ", box_x, " x ", box_y, " x ", base_h,
         " | tampa ", box_x, " x ", box_y, " x ", lid_h,
         " | fechado h=", closed_h, " | chapa ", 2 * box_x + plate_gap, " x ", box_y));
echo(str("encaixe: gargalo ", neck_x, " x ", neck_y, " | vao da tampa ", lid_in_x, " x ", lid_in_y,
         " | folga ", lid_fit, "/lado em ", neck_h, "mm | ombro z=", shoulder));
echo(str("paredes: tampa ", lid_wall, " (era 1.9) | teto ", lid_top, " - gravacao ", engrave,
         " = ", lid_top - engrave, " (era 1.0) | base ", body_wall, " (era 5.0) | gargalo ", neck_wall,
         " | chao ", floor_t));
echo(str("vagas: ", slots, " x ", slot_t, " passo ", pitch, " | canaleta ", inner_x, " x ", inner_y,
         " | chao da vaga ao teto ", head_in));

// ---------------------------------------------------------------------
// Primitivas
// ---------------------------------------------------------------------
module rrect(x, y, r) {
    rr = max(min(r, min(x, y) / 2 - 0.01), 0.01);
    offset(r = rr) square([x - 2 * rr, y - 2 * rr], center = true);
}

// prisma de cantos arredondados com chanfro 45° embaixo (c0) e em cima (c1)
module rbox(x, y, h, r, c0 = 0, c1 = 0) {
    e = 0.01;
    hull() {
        if (c0 > 0) linear_extrude(e) rrect(x - 2 * c0, y - 2 * c0, r - c0);
        translate([0, 0, c0]) linear_extrude(h - c0 - c1) rrect(x, y, r);
        if (c1 > 0) translate([0, 0, h - e]) linear_extrude(e) rrect(x - 2 * c1, y - 2 * c1, r - c1);
    }
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
            rbox(box_x, box_y, shoulder, corner_r, c0 = foot_cham);
            translate([0, 0, shoulder - 0.01])
                rbox(neck_x, neck_y, neck_h + 0.01, neck_r, c1 = lead);
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
        rbox(box_x, box_y, lid_h, corner_r, c0 = top_cham);
        // vão interno + chanfro de entrada na boca
        translate([0, 0, lid_top]) linear_extrude(lid_h) rrect(lid_in_x, lid_in_y, lid_in_r);
        translate([0, 0, lid_h - lid_lead])
            hull() {
                linear_extrude(0.01) rrect(lid_in_x, lid_in_y, lid_in_r);
                translate([0, 0, lid_lead]) linear_extrude(0.02)
                    rrect(lid_in_x + 2 * lid_lead, lid_in_y + 2 * lid_lead, lid_in_r + lid_lead);
            }
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
