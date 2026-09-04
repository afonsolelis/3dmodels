// snap-organizer-01.scad
// Organizador MODULAR "snap" de bancada. Três módulos de mesmo footprint
// (50 x 50 mm, o passo da grade) e ALTURAS diferentes, que se unem lado a
// lado por ÍMÃS de disco 5 x 1 mm embutidos nas quatro paredes.
//
// COMO O USUÁRIO MANUSEIA:
// - Cada módulo é uma peça única, aberta em cima, que fica de pé na mesa.
// - Ele encosta um módulo no outro e o conjunto "snapa" sozinho: são 2 ímãs
//   por parede POR FILEIRA, então qualquer face encontra qualquer face, em
//   qualquer rotação de 90°, e sempre ATRAI (ver "REGRA DE POLARIDADE").
// - Para separar, ele puxa o módulo de lado ou gira: os ímãs soltam.
//   A junta é de ALINHAMENTO, não estrutural — ver "FORÇA DA JUNTA".
// - O módulo de PARAFUSOS tem a parede da FRENTE rebaixada (19 mm, contra
//   30 mm das outras) e, por dentro, uma RAMPA a 45° que sobe do piso até
//   essa borda. O uso principal é TOMBAR o módulo pra frente e DESPEJAR; a
//   rampa a 45° também deixa varrer parafuso com o dedo até a borda (a 60°
//   nada ficava parado: aço em PLA para de escorregar só abaixo de ~17°).
// - O módulo de PEN DRIVES tem 3 canaletas partidas ao meio por uma costela
//   transversal = 6 nichos de 14 x 21.8 mm. O pen drive entra 35 mm e sobra
//   ~20 mm pra fora pra pegar com a mão. A costela é o que impede ele de
//   cair DEITADO ao longo da canaleta (sem ela seriam 35.8° de inclinação e
//   a ponta saía 4.6 mm pra fora do footprint, batendo no módulo vizinho).
// - O módulo de CANETAS é um copo fundo de 78 mm: caneta/lápis/pincel em pé.
//
// COLAGEM DOS ÍMÃS (obrigatório ler antes de colar):
// Os bolsos abrem na face EXTERNA de cada parede, com 1.25 mm de fundo pra
// um ímã de 1.0 mm — o ímã fica ~0.25 mm afundado, então as duas paredes
// ENCOSTAM de verdade mesmo com ímã 0.1 mm mais grosso que o nominal e um
// filete de cola. Atrás de cada ímã fica 1.15 mm de pele sólida.
// O bolso NÃO é press-fit: Ø5.35 com chanfro de 0.3 na boca, folga real de
// ~0.34 diametral. Ímã de neodímio é frágil e lasca quando forçado, e ele é
// COLADO de qualquer jeito — errar pro lado folgado é de graça.
//
// REGRA DE POLARIDADE (errar aqui arruína o conjunto):
// Cada parede tem DUAS COLUNAS de ímãs: a da ESQUERDA (vista de fora) é
// NORTE pra fora, a da DIREITA é SUL pra fora. TODO bolso da coluna
// esquerda — em TODAS as fileiras de altura — leva um PONTO GRAVADO logo
// abaixo. Ponto = coluna NORTE. Como as paredes que se encostam se
// espelham, a esquerda de uma sempre encontra a direita da outra: N-S,
// atrai. Vale girando 90/180/270° e entre alturas diferentes.
//
// PLANO Z COMUM DOS ÍMÃS (o ponto crítico do projeto):
// Como os módulos têm alturas diferentes, a fileira PRINCIPAL de ímãs é
// ancorada numa cota baixa compartilhada por TODOS: centro a 12 mm do piso
// (fileira 1, universal, presente nos três módulos e também na parede baixa
// do módulo de parafusos). Os módulos altos (>= 37.975 mm de parede) ganham
// uma fileira 2 de reforço a 32 mm — canetas e pen drives têm as duas e se
// unem por 4 ímãs; qualquer coisa encostada no parafusos une por 2.
//
// FORÇA DA JUNTA (é de alinhamento, não estrutural):
// Junta de 4 ímãs segura ~8.4 N na normal, contra ~1.05 N de cisalhamento
// que o canetas carregado exige — sobra folgado pro uso. Mas por ALAVANCA,
// ~64 gf aplicados no topo do canetas descolam uma junta de 2 ímãs. E o
// canetas SOZINHO tomba com ~19 gf de empurrão lateral (CM a 59.4 mm com 12
// canetas); acoplado ao pen drives isso sobe pra ~62 gf. Recomendação de
// uso: canetas SEMPRE acoplado, de preferência ao pen drives (junta de 4
// ímãs), não ao parafusos (junta de 2).
//
// Peças / STLs individuais:
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/Repos/3dmodels/organizadores/snap-organizer-01/stl/snap-organizer-01-canetas.stl   -D 'part="canetas"'   /home/afonsolelis/Repos/3dmodels/organizadores/snap-organizer-01/snap-organizer-01.scad
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/Repos/3dmodels/organizadores/snap-organizer-01/stl/snap-organizer-01-pendrives.stl -D 'part="pendrives"' /home/afonsolelis/Repos/3dmodels/organizadores/snap-organizer-01/snap-organizer-01.scad
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/Repos/3dmodels/organizadores/snap-organizer-01/stl/snap-organizer-01-parafusos.stl -D 'part="parafusos"' /home/afonsolelis/Repos/3dmodels/organizadores/snap-organizer-01/snap-organizer-01.scad
//
// Jobs de impressão (cama FlashForge AD5X 220x220, alvo 210x210), já na
// orientação de impressão (todos de pé, boca pra cima, SEM suporte):
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/Repos/3dmodels/organizadores/snap-organizer-01/3mf/snap-organizer-01-set.3mf            -D 'part="plate"'           /home/afonsolelis/Repos/3dmodels/organizadores/snap-organizer-01/snap-organizer-01.scad
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/Repos/3dmodels/organizadores/snap-organizer-01/3mf/snap-organizer-01-canetas-x3.3mf     -D 'part="plate-canetas"'   /home/afonsolelis/Repos/3dmodels/organizadores/snap-organizer-01/snap-organizer-01.scad
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/Repos/3dmodels/organizadores/snap-organizer-01/3mf/snap-organizer-01-pendrives-x3.3mf   -D 'part="plate-pendrives"' /home/afonsolelis/Repos/3dmodels/organizadores/snap-organizer-01/snap-organizer-01.scad
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/Repos/3dmodels/organizadores/snap-organizer-01/3mf/snap-organizer-01-parafusos-x3.3mf   -D 'part="plate-parafusos"' /home/afonsolelis/Repos/3dmodels/organizadores/snap-organizer-01/snap-organizer-01.scad
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/Repos/3dmodels/organizadores/snap-organizer-01/3mf/snap-organizer-01-jogo.3mf           -D 'part="plate-jogo"'      /home/afonsolelis/Repos/3dmodels/organizadores/snap-organizer-01/snap-organizer-01.scad
//
// ATENÇÃO CLI: nesta máquina `-D nome_override=...` NÃO funciona (o -D entra
// no fim do escopo e o is_undef já foi avaliado). Por isso este arquivo NÃO
// usa o padrão *_override: só a variável final `part` é mirada por -D, e os
// ECHO de derivados no fim confirmam qual peça saiu.

/* [Peça a renderizar] */
// "canetas" | "pendrives" | "parafusos" | "plate" (job de 3, 1 de cada) |
// "plate-canetas" | "plate-pendrives" | "plate-parafusos" (3 iguais) |
// "plate-jogo" (job de 9, 3 de cada) | "acoplado" (verificação: 3 alturas
// encostadas) | "none" (nada, pros scripts de corte) | "preview" (as 3 peças)
part = "preview";

/* [Grade modular] */
mod_size = 50;  // mm, passo da grade — lado do footprint quadrado de TODO módulo

/* [Alturas dos módulos] */
h_canetas   = 80; // mm, altura total da parede do módulo de canetas (medida decidida pelo usuário)
h_pendrives = 45; // mm, altura total da parede do módulo de pen drives
h_parafusos = 30; // mm, altura total da parede do módulo de parafusos (cuba rasa)

/* [Paredes e piso] */
wall        = 2.4; // mm, parede externa = bolso do ímã (1.25) + pele sólida atrás (1.15)
floor_t     = 2.0; // mm, piso do módulo
divider_t   = 1.6; // mm, divisórias internas (cubas do parafusos, canaletas e costela do pen drives)
foot_relief = 0.6; // mm, chanfro a 45° na base — alívio de pé de elefante

/* [Ímãs 5 x 1 mm - medida real dada pelo usuário] */
magnet_d        = 5.0;  // mm, diâmetro do disco de neodímio
magnet_h        = 1.0;  // mm, espessura do disco
// As duas folgas são DESACOPLADAS de propósito. O ímã é colado, não
// pressionado: no diâmetro sobra folga de verdade (o furo horizontal em
// parede vertical ainda encolhe 0.1-0.3 na impressão, e disco de neodímio
// lasca quando forçado); na profundidade a folga garante que ele NUNCA
// sobre pra fora, nem com ímã 0.1 acima do nominal + filete de cola.
magnet_fit_d    = 0.35; // mm, folga no diâmetro do bolso
magnet_fit_z    = 0.25; // mm, folga na profundidade do bolso
pocket_chamfer  = 0.3;  // mm, chanfro a 45° na boca do bolso (entrada e saída limpa da camada)
magnet_row1_z   = 12;   // mm, centro da fileira UNIVERSAL de ímãs (todos os módulos, sem exceção)
magnet_row2_z   = 32;   // mm, centro da fileira 2 de reforço (só em parede alta o bastante)
magnet_edge_min = 3;    // mm, material mínimo entre o topo da boca do bolso e o topo da parede
magnet_offset   = 17;   // mm, distância do CENTRO da parede até cada COLUNA de ímãs

/* [Marca de polaridade] */
// Ponto gravado sob CADA bolso da coluna ESQUERDA (vista de fora), em TODAS
// as fileiras. Marca de COLUNA, não de bolso isolado: a coluna marcada é a
// NORTE inteira. Foi assim que o print-review pegou o erro da v1, em que só
// a fileira 1 era marcada e a regra escrita fazia colar a fileira 2 invertida.
polarity_mark = true;
mark_d        = 2.4;  // mm, diâmetro do ponto
mark_depth    = 0.7;  // mm, profundidade gravada
mark_drop     = 5.5;  // mm, quanto o ponto fica ABAIXO do centro do ímã da sua fileira

/* [Colmeia hexagonal - identidade visual do repo] */
hex_d        = 7;   // mm, entre-faces de cada hexágono (ponta pra cima)
hex_web      = 2.6; // mm, material entre hexágonos vizinhos
hex_margin   = 3.5; // mm, faixa sólida na borda de cada parede (anti-lasca, regra 4 do CLAUDE.md)
hex_keepout  = 3;   // mm, faixa sólida entre a BOCA do bolso do ímã e o furo hexagonal
badge_depth  = 0.8; // mm, profundidade do hexágono gravado do módulo de parafusos
badge_gap    = 3;   // mm, folga entre o hexágono gravado e a boca do bolso do ímã

/* [Módulo de parafusos - cuba rasa com rampa de frente] */
parafusos_front_h    = 19; // mm, altura da parede DA FRENTE (rebaixada; >= 17.975 pra caber a fileira 1)
parafusos_ramp_angle = 45; // graus, inclinação da rampa interna da frente (45° = rampa de dedo de verdade)
parafusos_bins       = 2;  // nº de compartimentos (divisória no meio, frente-fundo)

/* [Módulo de pen drives - nichos verticais] */
slot_count = 3; // nº de canaletas paralelas (partidas ao meio pela costela => 2 x slot_count nichos)
slot_floor_h = 10; // mm, cota do piso dos nichos — é o que define a altura de PEGA do item

/* [Chapa de impressão] */
plate_gap  = 6; // mm, vão entre peças na chapa
plate_cols = 3; // peças por fileira na chapa

/* [Qualidade] */
$fn = 48;
pocket_fn = 64; // facetas só dos bolsos de ímã: com $fn=48 o polígono inscrito
                // já comia 0.011 de entre-faces; com 64 o erro cai pra 0.006

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
inner        = mod_size - 2 * wall;                 // 45.2 mm, lado interno livre
pocket_d     = magnet_d + magnet_fit_d;             // 5.35 mm, Ø nominal do bolso
pocket_flats = pocket_d * cos(180 / pocket_fn);     // 5.339 mm, entre-faces REAL do polígono
pocket_slack = pocket_flats - magnet_d;             // 0.339 mm, folga diametral que o ímã enxerga
pocket_depth = magnet_h + magnet_fit_z;             // 1.25 mm, profundidade do bolso
pocket_mouth_d = pocket_d + 2 * pocket_chamfer;     // 5.95 mm, Ø da BOCA (é o que ocupa a parede)
skin         = wall - pocket_depth;                 // 1.15 mm, pele sólida atrás do ímã
magnet_sink  = pocket_depth - magnet_h;             // 0.25 mm, quanto o ímã afunda (nominal)
magnet_gap   = 2 * magnet_sink;                     // 0.50 mm, ar entre dois ímãs com as paredes encostadas

// posições das 2 COLUNAS de ímãs ao longo de uma parede, simétricas em
// relação ao centro. mag_x[0] = ESQUERDA vista de fora = coluna NORTE
// (é a que leva o ponto gravado, em todas as fileiras).
mag_x = [mod_size / 2 - magnet_offset, mod_size / 2 + magnet_offset]; // [8, 42]

// altura mínima de parede pra cada fileira existir (medida pela BOCA do bolso)
rows_all  = [magnet_row1_z, magnet_row2_z];
row_min_h = [for (z = rows_all) z + pocket_mouth_d / 2 + magnet_edge_min];
function rows_for(h) = [for (z = rows_all) if (z + pocket_mouth_d / 2 + magnet_edge_min <= h) z];

// colmeia
hex_R       = hex_d / sqrt(3);           // circunraio (centro -> ponta), 4.041 mm
hex_sx      = hex_d + hex_web;           // passo entre colunas, 9.6 mm
hex_sy      = hex_sx * sqrt(3) / 2;      // passo entre fileiras, 8.314 mm
hex_cols    = floor((mod_size - 2 * hex_margin - hex_d) / hex_sx); // índice máximo de coluna
hex_cx0     = (mod_size - (hex_cols * hex_sx + hex_d)) / 2 + hex_d / 2; // 10.6 -> padrão CENTRADO na parede
skip_r      = pocket_mouth_d / 2 + hex_keepout + hex_R; // 10.016 mm, exclusão em volta da boca do bolso
mark_skip_r = mark_d / 2 + 1.5 + hex_R;                 // 6.741 mm, idem em volta de cada ponto

// parafusos
para_rise  = parafusos_front_h - floor_t;                   // 17 mm, altura da rampa
para_run   = para_rise / tan(parafusos_ramp_angle);         // 17 mm a 45°, avanço da rampa pra dentro
para_bin_w = (inner - (parafusos_bins - 1) * divider_t) / parafusos_bins; // 21.8 mm
para_depth = h_parafusos - floor_t;                         // 28 mm, altura da cuba
para_flat  = inner - para_run;                              // 28.2 mm, piso plano que sobra por cuba
// topo da divisória: acompanha a rampa, saindo de parafusos_front_h na boca
// (nada de lâmina atravessando a boca de despejo) e subindo até o aro.
para_div_run = (h_parafusos - parafusos_front_h) / tan(parafusos_ramp_angle); // 11 mm
// volumes (unificados: mesma conta no .scad, no README e no index.json)
para_vol_bruto = para_bin_w * inner * para_depth / 1000;          // 27.59 cm³
para_vol_rampa = para_bin_w * (para_run * para_rise / 2) / 1000;  //  3.15 cm³
para_vol_cuba  = para_vol_bruto - para_vol_rampa;                 // 24.44 cm³ até o aro de 30
para_vol_util  = para_bin_w * (para_flat * para_rise + para_run * para_rise / 2) / 1000; // 13.60 cm³ até a boca de 19

// pen drives
slot_w      = (inner - (slot_count - 1) * divider_t) / slot_count; // 14.0 mm, largura de cada canaleta
slot_cell_l = (inner - divider_t) / 2;                             // 21.8 mm, comprimento de cada nicho
slot_depth  = h_pendrives - slot_floor_h;                          // 35 mm, quanto do item entra
slot_cells  = slot_count * 2;                                      // 6 nichos
// inclinação máxima de um item DENTRO do nicho (é o que segura ele em pé)
function tilt(folga, engate) = atan(folga / engate);

// canetas
canetas_depth = h_canetas - floor_t; // 78 mm

// chapas
plate_pitch = mod_size + plate_gap;               // 56 mm
plate_row3  = 3 * mod_size + 2 * plate_gap;       // 162 mm

// ---------------------------------------------------------------------
// Blocos de apoio
// ---------------------------------------------------------------------

// Bloco externo do módulo, com alívio de pé de elefante na base.
module outer_block(h) {
    hull() {
        translate([foot_relief, foot_relief, 0])
            cube([mod_size - 2 * foot_relief, mod_size - 2 * foot_relief, 0.01]);
        translate([0, 0, foot_relief])
            cube([mod_size, mod_size, 0.01]);
    }
    translate([0, 0, foot_relief])
        cube([mod_size, mod_size, h - foot_relief]);
}

// Coloca os filhos no referencial LOCAL de uma parede:
//   local X = ao longo da parede, 0..mod_size (visto DE FORA, X cresce pra DIREITA)
//   local Y = pra DENTRO do módulo (a face externa fica em y = 0)
//   local Z = Z global
// i: 0 = frente (-Y), 1 = direita (+X), 2 = fundo (+Y), 3 = esquerda (-X)
module on_wall(i) {
    if (i == 0)      children();
    else if (i == 1) translate([mod_size, 0, 0])        rotate([0, 0,  90]) children();
    else if (i == 2) translate([mod_size, mod_size, 0]) rotate([0, 0, 180]) children();
    else             translate([0, mod_size, 0])        rotate([0, 0, 270]) children();
}

// Um bolso de ímã (eixo pra dentro da parede) com chanfro de boca.
module magnet_pocket(x, z) {
    translate([x, -0.01, z])
        rotate([-90, 0, 0]) {
            cylinder(h = pocket_depth + 0.01, d = pocket_d, $fn = pocket_fn);
            cylinder(h = pocket_chamfer + 0.01, d1 = pocket_mouth_d, d2 = pocket_d, $fn = pocket_fn);
        }
}

// Bolsos + pontos de polaridade de UMA parede de altura h (frame local).
// O ponto acompanha CADA fileira da coluna esquerda — foi o bug crítico da
// v1 ter marcado só a fileira 1.
module wall_magnet_cuts(h) {
    for (z = rows_for(h)) {
        for (x = mag_x) magnet_pocket(x, z);
        if (polarity_mark)
            translate([mag_x[0], -0.01, z - mark_drop])
                rotate([-90, 0, 0])
                    cylinder(h = mark_depth + 0.01, d = mark_d);
    }
}

// Colmeia de UMA parede de altura h (frame local), furos PASSANTES.
// Só entra hexágono que caiba inteiro dentro das margens E que fique fora do
// raio de exclusão de toda BOCA de bolso e de todo ponto de polaridade —
// o padrão vira um campo de favos com bossas sólidas em volta dos ímãs, sem
// lasca nenhuma na borda. O padrão é centrado na parede (hex_cx0).
module wall_hex_field(h, z_min = 0) {
    rz  = rows_for(h);
    z0  = z_min + hex_margin + hex_R;
    zmx = h - hex_margin - hex_R;
    xmx = mod_size - hex_margin - hex_d / 2;
    nrows = floor((zmx - z0) / hex_sy);

    if (nrows >= 0 && hex_cols >= 0)
        for (j = [0 : nrows], i = [0 : hex_cols]) {
            cx = hex_cx0 + i * hex_sx + (j % 2) * hex_sx / 2;
            cz = z0 + j * hex_sy;
            near_magnet = len([for (z = rz, x = mag_x)
                               if (norm([cx - x, cz - z]) < skip_r) 1]) > 0;
            near_mark   = polarity_mark
                          && len([for (z = rz)
                                  if (norm([cx - mag_x[0], cz - (z - mark_drop)]) < mark_skip_r) 1]) > 0;
            if (cx <= xmx && !near_magnet && !near_mark)
                translate([cx, -0.3, cz])
                    rotate([-90, 0, 0])
                        rotate([0, 0, 30])
                            cylinder(h = wall + 0.6, r = hex_R, $fn = 6);
        }
}

// Um único hexágono GRAVADO (não passante), centrado na parede, do maior
// tamanho que caiba entre as duas bocas de bolso e dentro da altura útil.
// É a identidade visual do módulo de parafusos, que não tem parede sobrando
// pra um campo de favos e onde furo passante deixaria parafuso pequeno cair.
module wall_hex_badge(h) {
    zc     = (hex_margin + (h - hex_margin)) / 2;
    rz_max = (h - 2 * hex_margin) / 2;
    rx_max = (magnet_offset - pocket_mouth_d / 2 - badge_gap) / sin(60);
    R = min(rz_max, rx_max);
    if (R > 3)
        translate([mod_size / 2, -0.01, zc])
            rotate([-90, 0, 0])
                rotate([0, 0, 30])
                    cylinder(h = badge_depth + 0.01, r = R, $fn = 6);
}

// Casca do módulo: bloco externo menos a cavidade, menos os recessos das
// paredes. Os recessos são cortados AQUI, antes de qualquer divisória ser
// unida — senão um hexágono da parede abre uma janela de 0.2 mm na
// divisória atrás dela e liga dois nichos vizinhos (achado do print-review).
module shell(h, cavity_z, hex_mode, front_h = 0) {
    difference() {
        outer_block(h);
        translate([wall, wall, cavity_z])
            cube([inner, inner, h]);                      // topo aberto
        if (front_h > 0)                                  // rebaixa a parede da frente
            translate([-1, -1, front_h]) cube([mod_size + 2, wall + 1, h]);
        for (i = [0 : 3]) {
            wh = (i == 0 && front_h > 0) ? front_h : h;
            on_wall(i) {
                wall_magnet_cuts(wh);
                if (hex_mode == "field") wall_hex_field(wh, cavity_z);
                else if (hex_mode == "badge") wall_hex_badge(wh);
            }
        }
    }
}

// Cunha maciça: sobe de 0 em y=d até `rise` em y=0. Rampa de despejo.
// (mapeamento de rotate([90,0,90]): X = altura da extrusão, Y = polygon x,
//  Z = polygon y — conferido antes de usar.)
module scoop_wedge(w, d, rise) {
    rotate([90, 0, 90])
        linear_extrude(height = w)
            polygon([[0, 0], [d, 0], [0, rise]]);
}

// ---------------------------------------------------------------------
// Módulo 1 — CANETAS (80 mm): copo único e fundo, colmeia passante nas 4
// paredes. Caneta/lápis/pincel ficam em pé com folga de sobra.
// ---------------------------------------------------------------------
module mod_canetas() {
    shell(h_canetas, floor_t, "field");
}

// ---------------------------------------------------------------------
// Módulo 2 — PEN DRIVES / equipamentos pequenos (45 mm): 3 canaletas de
// 14 mm partidas ao meio por uma costela transversal = 6 nichos de
// 14 x 21.8 mm, piso a 10 mm. O item entra 35 mm e sobra o resto na mão
// (pen drive de 55 mm deixa 20 mm de fora).
// A costela é FUNCIONAL, não decorativa: sem ela o item de 20 mm tinha
// 25.2 mm de curso livre ao longo da canaleta e caía deitado (35.8°), com a
// ponta saindo 4.6 mm pra fora do footprint de 50 mm. Com ela sobram 1.8 mm
// de folga => 2.9°.
// ---------------------------------------------------------------------
module mod_pendrives() {
    union() {
        shell(h_pendrives, slot_floor_h, "field");
        // divisórias longitudinais das canaletas
        for (k = [0 : slot_count - 2])
            translate([wall + (k + 1) * slot_w + k * divider_t, wall, slot_floor_h])
                cube([divider_t, inner, slot_depth]);
        // costela transversal que parte todas as canaletas ao meio
        translate([wall, wall + slot_cell_l, slot_floor_h])
            cube([inner, divider_t, slot_depth]);
    }
}

// ---------------------------------------------------------------------
// Módulo 3 — PARAFUSOS (30 mm): cuba rasa com 2 compartimentos.
// 2 e não 4: com 4 cada compartimento ficaria 21.8 x 21.8 mm, estreito
// demais pra pinçar um parafuso com dois dedos. Com 2, cada um mede
// 21.8 x 45.2 mm e o dedo entra pelo lado comprido. Quem quiser mais
// categorias imprime MAIS módulos — é para isso que serve a grade de 50 mm.
// A parede da frente é rebaixada pra 19 mm (ainda cobre a fileira 1 de ímãs)
// e por dentro tem uma rampa a 45° que sobe do piso até essa borda.
// A divisória do meio acompanha a mesma rampa: ela sai do topo da parede
// baixa e sobe até o aro, em vez de atravessar a boca de despejo como uma
// lâmina de 1.6 x 11 mm (achado do print-review).
// Paredes SEM furo: hexágono passante deixaria parafuso/arruela pequena
// escapar, e com só ~10 mm de parede livre acima da faixa dos ímãs não sobra
// campo de favos decente. Fica um hexágono GRAVADO centrado em cada parede.
// ---------------------------------------------------------------------
module mod_parafusos() {
    union() {
        shell(h_parafusos, floor_t, "badge", parafusos_front_h);
        // rampa de despejo, encostada na parede da frente
        translate([wall, wall, floor_t])
            scoop_wedge(inner, para_run, para_rise);
        // divisórias com o topo em rampa (mesma inclinação da de despejo)
        for (k = [0 : parafusos_bins - 2])
            translate([wall + (k + 1) * para_bin_w + k * divider_t, wall, floor_t])
                rotate([90, 0, 90])
                    linear_extrude(height = divider_t)
                        polygon([[0, 0], [inner, 0], [inner, para_depth],
                                 [para_div_run, para_depth],
                                 [0, parafusos_front_h - floor_t]]);
    }
}

module module_named(name) {
    if (name == "canetas")        mod_canetas();
    else if (name == "pendrives") mod_pendrives();
    else                          mod_parafusos();
}

// ---------------------------------------------------------------------
// Chapa de impressão: todos os módulos DE PÉ, boca pra cima, exatamente na
// orientação de uso — piso plano na mesa, nenhum balanço, ZERO suporte.
// ---------------------------------------------------------------------
// ARMADILHA: neste OpenSCAD (2021.01) o range [0:-1] NAO e vazio — ele
// INVERTE pra [-1:0] e itera 2 vezes. Sem o guarda `n <= 0 ? []`, uma chapa
// de um tipo so (plate(3,0,0)) saia com 7 peças em vez de 3, em silencio.
// Pego no sumario CGAL: Volumes = 8 quando o esperado era 4.
function rep(name, n) = n <= 0 ? [] : [for (i = [0 : n - 1]) name];

module plate(n_can, n_pen, n_par) {
    items = concat(rep("canetas", n_can), rep("pendrives", n_pen), rep("parafusos", n_par));
    for (i = [0 : len(items) - 1])
        translate([(i % plate_cols) * plate_pitch, floor(i / plate_cols) * plate_pitch, 0])
            module_named(items[i]);
}

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
if (part == "canetas")             mod_canetas();
else if (part == "pendrives")      mod_pendrives();
else if (part == "parafusos")      mod_parafusos();
else if (part == "plate")           plate(1, 1, 1);
else if (part == "plate-canetas")   plate(3, 0, 0);
else if (part == "plate-pendrives") plate(0, 3, 0);
else if (part == "plate-parafusos") plate(0, 0, 3);
else if (part == "plate-jogo")      plate(3, 3, 3);
else if (part == "none") {
    // nada: gancho pros scripts de verificação (include + override de `part`)
    // renderizarem só o corte que eles montam, sem o preview vir junto.
} else if (part == "acoplado") {
    // verificação: três alturas ENCOSTADAS (passo 50, sem folga), pra conferir
    // que a fileira universal de ímãs cai no mesmo Z nos três.
    mod_canetas();
    translate([mod_size, 0, 0]) mod_parafusos();
    translate([2 * mod_size, 0, 0]) mod_pendrives();
} else {
    mod_canetas();
    translate([mod_size + 15, 0, 0]) mod_pendrives();
    translate([2 * (mod_size + 15), 0, 0]) mod_parafusos();
}

// ---------------------------------------------------------------------
// ECHO de derivados (conferir SEMPRE depois de exportar com -D)
// ---------------------------------------------------------------------
echo(str("part = ", part));
echo(str("footprint do modulo = ", mod_size, " x ", mod_size, " mm (passo da grade)"));
echo(str("alturas: canetas ", h_canetas, " | pendrives ", h_pendrives, " | parafusos ", h_parafusos,
         " (frente ", parafusos_front_h, ")"));
echo(str("interno = ", inner, " x ", inner, " mm | parede ", wall, " | piso ", floor_t));
echo(str("bolso do ima: D", pocket_d, " (entre-faces reais ", pocket_flats, ", folga ", pocket_slack,
         ") x ", pocket_depth, " fundo | boca D", pocket_mouth_d, " com chanfro ", pocket_chamfer));
echo(str("pele atras do ima ", skin, " | ima afunda ", magnet_sink, " | ar entre imas ", magnet_gap));
echo(str("altura minima de parede por fileira = ", row_min_h));
echo(str("fileiras canetas   = ", rows_for(h_canetas)));
echo(str("fileiras pendrives = ", rows_for(h_pendrives)));
echo(str("fileiras parafusos = ", rows_for(h_parafusos), " | parede da frente = ",
         rows_for(parafusos_front_h)));
echo(str("colunas de ima em x = ", mag_x, " | ESQUERDA (", mag_x[0],
         ") = NORTE, com ponto gravado em TODAS as fileiras"));
echo(str("pontos de polaridade por parede: canetas ", len(rows_for(h_canetas)),
         " | pendrives ", len(rows_for(h_pendrives)),
         " | parafusos ", len(rows_for(h_parafusos))));
echo(str("imas por modulo: canetas ", 4 * 2 * len(rows_for(h_canetas)),
         " | pendrives ", 4 * 2 * len(rows_for(h_pendrives)),
         " | parafusos ", 3 * 2 * len(rows_for(h_parafusos)) + 2 * len(rows_for(parafusos_front_h))));
echo(str("colmeia: ", hex_cols + 1, " colunas, 1o centro em x=", hex_cx0,
         " (simetrico: ultimo em ", hex_cx0 + hex_cols * hex_sx, ") | exclusao r=", skip_r));
echo(str("parafusos: ", parafusos_bins, " cubas de ", para_bin_w, " x ", inner, " x ", para_depth,
         " mm | rampa ", parafusos_ramp_angle, " deg, avanco ", para_run, ", piso plano ", para_flat));
echo(str("parafusos volume por cuba: ", para_vol_cuba, " cm3 ate o aro de ", h_parafusos,
         " / ", para_vol_util, " cm3 ate a boca de ", parafusos_front_h));
echo(str("parafusos divisoria: topo sai de z=", parafusos_front_h, " na boca e sobe ", para_div_run,
         " mm ate o aro (sem lamina na boca de despejo)"));
echo(str("pendrives: ", slot_cells, " nichos de ", slot_w, " x ", slot_cell_l,
         " mm, piso em z=", slot_floor_h, ", engate ", slot_depth, " mm"));
echo(str("pendrives inclinacao: item de 10mm na largura -> ", tilt(slot_w - 10, slot_depth),
         " deg | item de 20mm no comprimento -> ", tilt(slot_cell_l - 20, slot_depth), " deg"));
echo(str("canetas: copo de ", inner, " x ", inner, " x ", canetas_depth, " mm"));
echo(str("chapas: passo ", plate_pitch, " mm | 3 pecas = ", plate_row3, " x ", mod_size,
         " | jogo(9) = ", plate_row3, " x ", plate_row3));
