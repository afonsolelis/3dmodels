// prateleira-modular-01.scad
// Prateleira MODULAR "infinita" de parede, com MÃO FRANCESA integrada. UMA
// peça só, repetível: N cópias idênticas se emendam lado a lado, então não
// existe peça de canto, de ponta nem de emenda. Passo do módulo = 200 mm.
//
// COMO O USUÁRIO MANUSEIA:
// - Cada módulo é um conjunto inteiriço: prato de 200 x 100 x 6 mm, aba
//   traseira de 100 mm de altura encostada na parede (ela desce 68 mm ABAIXO
//   do prato e sobe 26 mm ACIMA dele) e DUAS MÃOS FRANCESAS a 45°, em
//   x = 50 e x = 150, ligando o pé da aba à barriga do prato.
// - Fixação: parafusos de haste Ø4. Dois OBRIGATÓRIOS em cima (x = 50 e 150,
//   z = 88, logo acima do prato, alinhados com as mãos francesas) e um
//   RECOMENDADO embaixo (x = 100, z = 12), que é o que impede o pé da aba de
//   chutar pra fora da parede. Cada furo fica num RESSALTO HEXAGONAL (ponta
//   pra cima) que engrossa a aba pra 6 mm no ponto do parafuso, com rebaixo
//   cônico de 90° e boca Ø9 — aceita cabeça chata/escareada (afunda rente) e
//   cabeça panela (encosta na boca do cone).
// - MONTAGEM DA FILEIRA: parafusa o módulo A na parede. Pega o módulo B,
//   apresenta ele À FRENTE do A com o RASGO EM T da esquerda alinhado com o
//   TRILHO EM T da direita do A, e EMPURRA B PRA TRÁS, em direção à parede,
//   até a aba do B encostar. Aí parafusa o B. Repete pra sempre.
//   Pra tirar um módulo do MEIO da fileira: solta os parafusos e PUXA ele
//   pra frente — ele sai dos dois vizinhos ao mesmo tempo, no mesmo eixo.
// - A ponta DIREITA da fileira fica com o trilho de 7 mm exposto e a ponta
//   ESQUERDA com o rasgo aberto. É o preço de ter UMA peça só (era o pedido).
//   Quem quiser ponta limpa imprime um módulo com `with_rail=false` — isso é
//   opção de parâmetro, não peça nova: o 3MF do repo é o módulo universal.
//
// POR QUE MÃO FRANCESA (e por que o encaixe MUDOU):
// Chapa em balanço presa só pela aba põe TODO o momento na junção prato/aba
// e TODO o arranque nos parafusos. Com a mão francesa a 45° o caminho de
// carga vira prato -> mísula -> diagonal em compressão -> pé da aba na
// parede, e a perna vertical de 100 mm dá braço de 88 mm pro parafuso de
// cima: o arranque no parafuso cai ~4x (de T = 4.8P pra T = 1.1P) e o momento
// que sobra na junção despenca. Ver as contas no README.
//
// O ENCAIXE (v2 — trilho em T ao longo da PROFUNDIDADE, não mais rabo de
// andorinha de descer):
// - O rabo de andorinha "de descer" da v1 foi DESCARTADO por três motivos:
//   (1) com mão francesa embaixo, a peça não imprime mais deitada, e naquela
//   orientação a língua ficava no ar; (2) rabo de andorinha de aba curta tem
//   folga amplificada — a folga de flanco vira folga de arranque dividida
//   pelo seno do ângulo; (3) ele só encostava numa área pequena no meio do
//   vão, e o que precisa ficar alinhado é a EMENDA INTEIRA.
// - v2: TRILHO EM T de seção constante correndo os 100 mm de profundidade.
//   Face direita = trilho (pescoço de 2 x 3 mm + cabeça de 5 x 4 mm, 7 mm de
//   saliência total). Face esquerda = rasgo com o mesmo perfil + folga.
//   A cabeça NÃO passa pelo pescoço: trava em X com batente de 90°, sem
//   amplificação de folga nenhuma. Trava também Z e rotação, e ao longo dos
//   100 mm inteiros — a emenda não consegue formar degrau, e o vizinho da
//   direita ajuda a segurar a borda do módulo da esquerda.
// - A seção é constante ao longo da profundidade, que é a direção VERTICAL na
//   impressão: o perfil inteiro sai em parede vertical, sem ponte, sem
//   balanço e com a melhor tolerância que a máquina tem. Por isso um encaixe
//   com rebaixo de 90° (que seria impensável deitado) aqui é de graça.
// - Folga 0.35/lado em todo o contorno (offset uniforme, não medida a medida)
//   + chanfro de entrada nos últimos 5 mm do trilho. É encaixe LONGO (100 mm),
//   mas na direção em que a peça não empena: cada camada é uma cópia da
//   anterior. Se um exemplar sair apertado, subir `joint_clear` pra 0.45.
// - A emenda tem BANDA REFORÇADA: os 14 mm de cada borda do prato descem pra
//   10 mm de espessura (engrossam pra BAIXO, o topo fica plano). É onde o T
//   mora e vira uma viga longitudinal embaixo de cada emenda.
//
// ORIENTAÇÃO DE IMPRESSÃO: a peça é exportada DEITADA DE COSTAS — a face da
// aba que encosta na parede vai na cama, o prato sobe em pé (a profundidade
// vira a altura de 100 mm) e as mãos francesas viram duas nervuras verticais.
// Nessa orientação NADA precisa de suporte: não existe uma única superfície
// voltada pra baixo. A diagonal da mão francesa aponta pra CIMA, os furos de
// parafuso e os cones ficam VERTICAIS (furo redondo perfeito, sem barriga), o
// perfil do encaixe é extrusão vertical e a colmeia do prato é furo
// horizontal de hexágono PONTA PRA CIMA em parede vertical — a regra de
// identidade do repo aqui não é enfeite, é o que faz o furo imprimir limpo.
// A primeira camada é a aba inteira (200 x 100 mm de área): adere muito bem.
// O ponto fraco da orientação é a interface de camada na base do prato e das
// nervuras; é exatamente ela que a mão francesa alivia (ver README).
//
// DESVIO DECLARADO — "aba_h = 0 tem que ser um caso válido" caiu na v2:
// na v1 a aba era um apêndice anti-tombamento de 30 mm e fazia sentido zerar
// ela pra sobrar uma chapa pura. Aqui a aba É a peça: ela é a perna vertical
// da mão francesa, o que dá o braço de 88 mm pro parafuso e o que apoia as
// nervuras. Zerar `aba_up` deixa os furos de cima fora do material (o ECHO de
// AVISO no fim do arquivo acusa) e zerar `aba_down` apaga a mão francesa
// junto. Quem quiser a chapa pura da v1 tira a colmeia e usa só o prato —
// mas aí é outro modelo, não este.
//
// PENDÊNCIAS DECLARADAS (o usuário ainda não mediu / não informou):
// - `depth = 100` é ASSUNÇÃO, não medida com régua.
// - Tipo de cabeça do parafuso não informado: rebaixo cônico generoso de
//   propósito pra aceitar chata e panela.
// - Bucha/âncora de parede não definida — é quase sempre ELA, e não o PLA, o
//   elo fraco de uma prateleira de parede.
// - Peça NÃO impressa nem testada na mão.
//
// Peça / STL (já na orientação de impressão):
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/prateleiras/prateleira-modular-01/stl/prateleira-modular-01.stl -D 'part="modulo"' /home/afonsolelis/repos/3dmodels/prateleiras/prateleira-modular-01/prateleira-modular-01.scad
// Jobs de impressão (3MF):
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/prateleiras/prateleira-modular-01/3mf/prateleira-modular-01-x1.3mf -D 'part="plate-1"' /home/afonsolelis/repos/3dmodels/prateleiras/prateleira-modular-01/prateleira-modular-01.scad
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/prateleiras/prateleira-modular-01/3mf/prateleira-modular-01-x2.3mf -D 'part="plate"'   /home/afonsolelis/repos/3dmodels/prateleiras/prateleira-modular-01/prateleira-modular-01.scad
// Prova de encaixe (part="fit" = interseção de dois módulos; tem que dar 0):
//   -D 'part="fit"' -D fit_dy=0    -> montado no fim do curso: VAZIO
//   -D 'part="fit"' -D fit_dy=50   -> meio do curso de 100 mm: VAZIO
//   -D 'part="fit"' -D fit_dx=1    -> puxar pra fora: TEM que dar interferência
//   -D 'part="fit"' -D fit_dz=0.5  -> degrau em Z além da folga: interferência

/* [Módulo] */
mod_w  = 200;  // mm, passo do módulo em X (largura útil da prateleira)
depth  = 100;  // mm, profundidade do prato em Y (ASSUNÇÃO: não foi medida)
deck_t = 6;    // mm, espessura do prato

/* [Aba de parede e mão francesa] */
aba_t     = 3;   // mm, espessura da aba
aba_down  = 68;  // mm, quanto a aba desce ABAIXO do prato (perna da mão francesa)
aba_up    = 26;  // mm, quanto a aba sobe ACIMA do prato (guarda traseira)
rib_t     = 5;   // mm, espessura de cada mão francesa
rib_reach = 68;  // mm, alcance da diagonal (= aba_down dá 45° exatos)
rib_x     = [50, 150]; // mm, posição das mãos francesas (mesma coluna dos parafusos)
rib_hex   = 26;  // mm, entre-faces do hexágono vazado na mão francesa (0 = maciça)

/* [Parafuso de parede] */
screw_d      = 4;    // mm, diâmetro da HASTE do parafuso
screw_slack  = 0.3;  // mm, folga por lado no furo (regra do repo: peça solta)
screw_cone_d = 9;    // mm, diâmetro da boca do rebaixo cônico de 90°
screw_top_z  = 88;   // mm, altura dos 2 furos de cima (obrigatórios)
screw_bot_z  = 12;   // mm, altura do furo de baixo (recomendado)
screw_bot_x  = 100;  // mm, posição em X do furo de baixo (entre as mãos francesas)
boss_flats   = 13;   // mm, entre-faces do ressalto hexagonal do furo
boss_t       = 3;    // mm, quanto o ressalto engrossa a aba

/* [Encaixe: trilho em T ao longo da profundidade] */
with_rail   = true; // false = módulo de PONTA (sem trilho); opção, não peça nova
seam_w      = 14;   // mm, largura da banda reforçada em cada borda do prato
seam_t      = 10;   // mm, espessura da banda reforçada (engrossa pra baixo)
neck_l      = 3;    // mm, comprimento do pescoço do T (em X)
neck_h      = 2;    // mm, altura do pescoço do T (em Z)
head_l      = 4;    // mm, comprimento da cabeça do T (em X)
head_h      = 5;    // mm, altura da cabeça do T (em Z)
joint_round = 0.5;  // mm, raio de canto do perfil (mata concentração de tensão)
joint_clear = 0.35; // mm, folga por lado em TODO o contorno do encaixe
joint_lead  = 5;    // mm, comprimento do chanfro de entrada na ponta do trilho
lead_drop   = 0.6;  // mm, quanto o perfil afina em Z na ponta de entrada

/* [Colmeia do prato] */
hex_plate      = true; // false = prato maciço
hex_flats      = 11;   // mm, entre-faces do hexágono
hex_web        = 4;    // mm, teia entre hexágonos
hex_round      = 1.2;  // mm, raio de canto
hex_band_x     = 16;   // mm, faixa maciça em cada lado em X (protege a emenda)
hex_band_back  = 14;   // mm, faixa maciça junto à parede
hex_band_front = 10;   // mm, faixa maciça na borda da frente
hex_band_rib   = 6;    // mm, folga mínima do hexágono ao eixo de cada mão francesa

/* [Prova de encaixe] */
fit_dx = 0; // mm, desvio em X do vizinho (0 = passo perfeito de mod_w)
fit_dy = 0; // mm, recuo do vizinho ao longo do curso de montagem (0 = fim do curso)
fit_dz = 0; // mm, degrau em Z do vizinho

/* [Chapa de impressão] */
gap = 6; // mm, vão entre peças na chapa

/* [Peça] */
part = "modulo"; // modulo | plate | plate-1 | uso | par | fit

/* [Qualidade] */
$fn = 48;

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
eps = 0.01;
ef  = 0.6;  // alívio de pé de elefante nas arestas de emenda da 1a camada

deck_z0 = aba_down;              // barriga do prato
deck_z1 = deck_z0 + deck_t;      // topo do prato (superfície de uso)
leg_h   = deck_z1 + aba_up;      // altura total da aba = altura da 1a camada
seam_z0 = deck_z1 - seam_t;      // barriga da banda reforçada
joint_cz = deck_z1 - seam_t / 2; // eixo do trilho em T

screw_hole_d = screw_d + 2 * screw_slack;       // 4.6 mm
cone_run = (screw_cone_d - screw_hole_d) / 2;   // 2.2 mm (cone de 90°)
boss_y   = aba_t + boss_t;                      // material no ponto do parafuso
boss_R   = boss_flats / sqrt(3);

rail_len = neck_l + head_l;                     // saliência do trilho
footprint_x = mod_w + (with_rail ? rail_len : 0);
lead_scale  = (head_h - 2 * lead_drop) / head_h;

// alavanca: momento do prato x braço do parafuso de cima até o pé da aba
lever_screw = screw_top_z;
T_por_P = depth / lever_screw;                  // tração no par de parafusos por N de carga
T_v1    = depth / 21;                           // como era sem mão francesa (aba de 30)

// mão francesa
rib_angle = atan(deck_z0 / rib_reach);
rib_r_in  = (deck_z0 + rib_reach - sqrt(deck_z0 * deck_z0 + rib_reach * rib_reach)) / 2;
rib_hex_R = rib_hex / sqrt(3);

// colmeia do prato
hex_s  = hex_flats + hex_web;
hex_dy = hex_s * sqrt(3) / 2;
hex_R  = hex_flats / sqrt(3);
hx0 = hex_band_x;        hx1 = mod_w - hex_band_x;
hy0 = hex_band_back;     hy1 = depth - hex_band_front;
hex_W = hx1 - hx0;       hex_H = hy1 - hy0;
hex_nx = floor((hex_W - hex_flats - hex_s / 2) / hex_s) + 1;
hex_ny = floor((hex_H - 2 * hex_R) / hex_dy) + 1;
hex_fw = (hex_nx - 1) * hex_s + hex_s / 2 + hex_flats;
hex_fh = (hex_ny - 1) * hex_dy + 2 * hex_R;
hex_cx0 = hx0 + (hex_W - hex_fw) / 2 + hex_flats / 2;
hex_cy0 = hy0 + (hex_H - hex_fh) / 2 + hex_R;
function hex_ok(cx) = min([for (rx = rib_x) abs(cx - rx)]) >= hex_flats / 2 + hex_band_rib;
hex_n = !hex_plate ? 0 :
        len([for (j = [0 : hex_ny - 1], i = [0 : hex_nx - 1])
             if (hex_ok(hex_cx0 + i * hex_s + (j % 2) * hex_s / 2)) 1]);

// ---------------------------------------------------------------------
// 2D
// ---------------------------------------------------------------------

// Hexágono com cantos arredondados. rot = 90 -> ponta pra +v; rot = 0 -> ponta pra +u.
module hex2d(flats, round_r, rot = 90) {
    r0 = (flats - 2 * round_r) / sqrt(3);
    rotate(rot) offset(r = round_r, $fn = 24) circle(r = r0, $fn = 6);
}

// Perfil do trilho em T, no plano (u = x, v = z relativo ao eixo do trilho).
// A raiz entra 1 mm no prato pra soldar sem face coincidente.
module rail2d() {
    offset(r = -joint_round, $fn = 16)
    offset(r = 2 * joint_round, $fn = 16)
    offset(r = -joint_round, $fn = 16)
    union() {
        translate([mod_w - 1, -neck_h / 2]) square([1 + neck_l, neck_h]);
        translate([mod_w + neck_l, -head_h / 2]) square([head_l, head_h]);
    }
}

// Extruda um perfil (u = x, v = z) ao longo de +y, de y0 até y0+len.
module along_y(y0, len, z, sc = 1) {
    translate([0, y0, z]) rotate([-90, 0, 0]) mirror([0, 1, 0])
        linear_extrude(height = len, scale = [1, sc]) children();
}

// ---------------------------------------------------------------------
// Sólidos (frame de USO: y = 0 na parede, z = 0 no pé da aba)
// ---------------------------------------------------------------------

module prato() {
    translate([0, 0, deck_z0]) cube([mod_w, depth, deck_t]);           // chapa
    translate([0, 0, seam_z0]) cube([seam_w, depth, seam_t]);          // banda esquerda
    translate([mod_w - seam_w, 0, seam_z0]) cube([seam_w, depth, seam_t]); // banda direita
}

module trilho() {
    along_y(0, depth - joint_lead, joint_cz) rail2d();
    along_y(depth - joint_lead, joint_lead, joint_cz, lead_scale) rail2d();
}

module rasgo() {
    translate([-mod_w, 0, 0])
        along_y(-1, depth + 2, joint_cz) offset(r = joint_clear, $fn = 16) rail2d();
}

module aba() {
    cube([mod_w, aba_t, leg_h]);
    for (x = rib_x) boss(x, screw_top_z);
    boss(screw_bot_x, screw_bot_z);
}

module boss(x, z) {
    intersection() {
        translate([x, boss_y, z]) rotate([90, 0, 0])
            linear_extrude(boss_y) hex2d(boss_flats, 0.8, 90);
        translate([0, 0, 0]) cube([mod_w, boss_y, leg_h]);
    }
}

module maos_francesas() {
    for (x = rib_x)
        translate([x - rib_t / 2, 0, 0]) rotate([0, 0, 0])
            difference() {
                translate([0, aba_t, 0]) rotate([90, 0, 90]) linear_extrude(rib_t)
                    polygon([[0, 0], [0, deck_z0], [rib_reach, deck_z0]]);
                if (rib_hex > 0)
                    translate([-1, aba_t + rib_r_in, deck_z0 - rib_r_in])
                        rotate([0, 90, 0]) linear_extrude(rib_t + 2)
                            hex2d(rib_hex, 1.5, 90);
            }
}

module furos_parafuso() {
    for (p = [[rib_x[0], screw_top_z], [rib_x[1], screw_top_z], [screw_bot_x, screw_bot_z]]) {
        translate([p[0], -1, p[1]]) rotate([-90, 0, 0])
            cylinder(h = boss_y + 2, d = screw_hole_d);
        translate([p[0], boss_y - cone_run, p[1]]) rotate([-90, 0, 0])
            cylinder(h = cone_run + 1, d1 = screw_hole_d,
                     d2 = screw_hole_d + 2 * (cone_run + 1));
    }
}

module colmeia() {
    if (hex_plate)
        for (j = [0 : hex_ny - 1], i = [0 : hex_nx - 1]) {
            cx = hex_cx0 + i * hex_s + (j % 2) * hex_s / 2;
            if (hex_ok(cx))
                translate([cx, hex_cy0 + j * hex_dy, deck_z0 - 1])
                    linear_extrude(deck_t + 2) hex2d(hex_flats, hex_round, 90);
        }
}

// Alívio de pé de elefante nas DUAS arestas verticais de emenda: elas nascem
// na primeira camada (a aba encosta na cama) e o inchaço de base afastaria os
// módulos vizinhos justo na emenda.
module alivio_emenda() {
    translate([0, 0, -1]) linear_extrude(leg_h + 2)
        polygon([[ef, 0], [0, ef], [-200, ef], [-200, -200], [ef, -200]]);
    translate([0, 0, -1]) linear_extrude(leg_h + 2)
        polygon([[mod_w - ef, 0], [mod_w, ef], [mod_w + 200, ef],
                 [mod_w + 200, -200], [mod_w - ef, -200]]);
}

module modulo_uso() {
    difference() {
        union() {
            prato();
            aba();
            maos_francesas();
            if (with_rail) trilho();
        }
        rasgo();
        furos_parafuso();
        colmeia();
        alivio_emenda();
    }
}

// Orientação de IMPRESSÃO: de costas, aba na cama, profundidade virando altura.
module modulo() {
    translate([0, leg_h, 0]) rotate([90, 0, 0]) modulo_uso();
}

module chapa(n) {
    for (i = [0 : n - 1]) translate([0, i * (leg_h + gap), 0]) modulo();
}

// ---------------------------------------------------------------------
// Peças
// ---------------------------------------------------------------------
if      (part == "modulo")  modulo();
else if (part == "plate")   chapa(2);
else if (part == "plate-1") chapa(1);
else if (part == "uso")     modulo_uso();
else if (part == "par")     { modulo_uso(); translate([mod_w, 0, 0]) modulo_uso(); }
else if (part == "fit")
    intersection() {
        modulo_uso();
        translate([mod_w + fit_dx, fit_dy, fit_dz]) modulo_uso();
    }
else modulo();

// ---------------------------------------------------------------------
// ECHO de derivados (conferir SEMPRE depois de exportar com -D)
// ---------------------------------------------------------------------
echo(str("part = ", part));
echo(str("passo = ", mod_w, " mm | prato ", mod_w, " x ", depth, " x ", deck_t,
         " (profundidade e ASSUNCAO, nao medida)"));
echo(str("aba: ", leg_h, " mm de altura total = ", aba_down, " abaixo + ", deck_t,
         " do prato + ", aba_up, " acima | espessura ", aba_t));
echo(str("prato: barriga em z=", deck_z0, ", topo em z=", deck_z1));
echo(str("mao francesa: ", len(rib_x), " em x=", rib_x, ", ", rib_t,
         " mm de espessura, alcance ", rib_reach, " de ", depth, " mm (",
         100 * rib_reach / depth, "% da profundidade), diagonal a ", rib_angle,
         " graus | hexagono vazado ", rib_hex, " (raio inscrito do triangulo ",
         rib_r_in, ")"));
echo(str("footprint impresso = ", footprint_x, " x ", leg_h, " x ", depth,
         " mm (x = 200 + trilho de ", rail_len, "; a profundidade vira ALTURA)"));
echo(str("parafuso: haste D", screw_d, " -> furo D", screw_hole_d, " (folga ",
         screw_slack, "/lado) | cone 90 de boca D", screw_cone_d, " x ", cone_run,
         " | material no furo ", boss_y, " mm | ressalto hex ", boss_flats,
         " (z ", screw_top_z - boss_R, " a ", screw_top_z + boss_R, ")"));
echo(str("parafusos: 2 em cima em x=", rib_x, ", z=", screw_top_z,
         " (obrigatorios) + 1 embaixo em x=", screw_bot_x, ", z=", screw_bot_z,
         " (recomendado)"));
echo(str("alavanca: tracao no par de cima = ", T_por_P,
         " x a carga (era ", T_v1, " x sem mao francesa, com aba de 30) -> alivio de ",
         T_v1 / T_por_P, " vezes"));
echo(str("encaixe: trilho em T de ", rail_len, " mm de saliencia (pescoco ",
         neck_l, " x ", neck_h, ", cabeca ", head_l, " x ", head_h,
         ") correndo os ", depth, " mm de profundidade"));
echo(str("encaixe: batente de arranque = ", (head_h - (neck_h + 2 * joint_clear)) / 2,
         " mm por lado (a cabeca de ", head_h, " nao passa pela boca de ",
         neck_h + 2 * joint_clear, ")"));
echo(str("encaixe: folga ", joint_clear, "/lado em todo o contorno | degrau maximo em Z entre modulos = ",
         2 * joint_clear, " | chanfro de entrada ", joint_lead, " mm afinando ",
         lead_drop, " (escala ", lead_scale, ")"));
echo(str("banda reforcada da emenda: ", seam_w, " mm de largura x ", seam_t,
         " de espessura (z ", seam_z0, " a ", deck_z1, "), eixo do T em z=", joint_cz,
         " | parede acima da cabeca = ", deck_z1 - (joint_cz + head_h / 2 + joint_clear),
         ", abaixo = ", (joint_cz - head_h / 2 - joint_clear) - seam_z0));
echo(str("colmeia: ", hex_n, " hexagonos de ", hex_flats, " entre-faces, teia ",
         hex_web, ", canto r", hex_round, " | grade ", hex_nx, " x ", hex_ny,
         " menos as faixas macicas sobre as maos francesas"));
echo(str("colmeia: campo x ", hex_cx0 - hex_flats / 2, " a ",
         hex_cx0 + (hex_nx - 1) * hex_s + hex_s / 2 + hex_flats / 2,
         " | y ", hex_cy0 - hex_R, " a ", hex_cy0 + (hex_ny - 1) * hex_dy + hex_R));
echo(str("colmeia: area vazada ", hex_n * 3 * sqrt(3) / 2 * hex_R * hex_R,
         " mm2 de ", mod_w * depth, " mm2 = ",
         100 * hex_n * 3 * sqrt(3) / 2 * hex_R * hex_R / (mod_w * depth), "%"));
echo(str("chapa: 2 modulos = ", footprint_x, " x ", 2 * leg_h + gap, " x ", depth,
         " mm (vao ", gap, ")"));
if (seam_t < head_h + 2 * joint_clear + 2)
    echo("AVISO: banda da emenda fina demais pra cabeca do T — subir seam_t");
if (screw_top_z + boss_R > leg_h - 1)
    echo("AVISO: ressalto do parafuso de cima passa do topo da aba");
if (deck_z1 + 4 > screw_top_z - boss_R)
    echo("AVISO: ressalto do parafuso de cima muito perto do prato — sem espaço pra chave");
