// deckbox-03.scad
// Deckbox CILÍNDRICA de tampa ROSCADA. O deck de 60 cartas com sleeve fica
// EM PÉ no bolso retangular do meio (as cartas ficam na vertical, os 93mm
// viram altura); os quatro segmentos de círculo que sobram entre o bolso
// retangular e a parede redonda são os compartimentos de dados, moedas e
// contadores — é isso que faz o formato redondo ganhar função em vez de ser
// só capricho.
//
// COMO SE MANUSEIA: pega a caixa com as duas mãos, gira a tampa ~2/3 de
// volta (rosca de 3 entradas) e tira. O topo do deck fica RENTE à boca da
// caixa e sobra ~15,8mm acima das paredes do bolso: dá pra enfiar polegar e
// indicador pelos lados do gargalo (sobram ~28mm de folga de cada lado) e
// puxar o deck inteiro pinçando pelas faces grandes. Os dados ficam nos
// quatro poços em volta — os dois LARGOS (28,9mm de profundidade) tomam d6
// de até 16mm à vontade; os dois ESTREITOS (17,4mm) tomam contadores de
// dano, moedas em pé e dados pequenos. Pra fechar, a tampa encosta num
// BATENTE (a saia bate no ressalto do corpo) e para sempre na mesma
// posição, com o lado de fora liso e contínuo entre corpo e tampa.
//
// LISO DE PROPÓSITO — NÃO BOTAR COLMEIA AQUI. A regra 5 do CLAUDE.md manda
// usar hexágonos "quando couber"; neste modelo o usuário pediu explicitamente
// "todo liso por fora e por dentro" (2026-08-08). Sem colmeia, sem textura,
// sem relevo: por fora é acabamento, e por dentro é função — parede lisa
// deixa a carta com sleeve deslizar e não enroscar na hora de tirar o deck.
//
// STL (peças individuais, já na ORIENTAÇÃO DE IMPRESSÃO):
//   openscad -o stl/deckbox-03-box.stl       -D 'part="box"'       deckbox-03.scad
//   openscad -o stl/deckbox-03-lid.stl       -D 'part="lid"'       deckbox-03.scad
//   openscad -o stl/deckbox-03-test-neck.stl -D 'part="test_neck"' deckbox-03.scad
//   openscad -o stl/deckbox-03-test-ring.stl -D 'part="test_ring"' deckbox-03.scad
// 3MF (jobs de impressão — cada peça é um job; ver NOTA DE CAMA abaixo):
//   openscad -o 3mf/deckbox-03-box.3mf -D 'part="box"' deckbox-03.scad
//   openscad -o 3mf/deckbox-03-lid.3mf -D 'part="lid"' deckbox-03.scad
//   python3 .claude/skills/plates/plates.py \
//       deckboxes/deckbox-03/3mf/deckbox-03-teste-rosca.3mf \
//       --plate "1 - gargalo (macho)"      deckboxes/deckbox-03/stl/deckbox-03-test-neck.stl \
//       --plate "2 - anel da tampa (femea)" deckboxes/deckbox-03/stl/deckbox-03-test-ring.stl
//
// NOTA DE CAMA (por que não existe part="plate" com tudo junto): duas
// circunferências de diâmetro D só cabem juntas num quadrado de lado S se
// D <= S*(2-sqrt(2)) = 0.586*S — ou seja, 105,4mm na cama de 180 e 99,6mm no
// alvo confortável de 170. Corpo e tampa têm 114mm de diâmetro cada, então
// NUNCA cabem na mesma chapa; o mesmo vale pro par do cupom de rosca. Cada
// peça é um job, e é isso mesmo.
//
// IMPRIMIR O CUPOM DE ROSCA PRIMEIRO (3mf/deckbox-03-teste-rosca.3mf, 2
// plates de 15mm de altura, 18,1 + 15,4 cm³ de sólido = ~42g de PLA): é um
// pedaço do gargalo de verdade + o anel da tampa, no diâmetro REAL e na
// MESMA orientação de impressão das peças grandes. Rosca em FDM é exatamente
// o tipo de coisa que só o teste na mão valida — e o corpo sozinho tem
// 161,6cm³ de sólido (~200g). Se travar, aumentar a folga; se bambear,
// diminuir — por override, sem mexer no modelo:
//   openscad -o anel.stl -D 'thread_clear_override=0.45' -D 'part="test_ring"' deckbox-03.scad
// (no anel do cupom vale ligar brim: a base dele encosta na cama só por uma
// coroa de ~2,4mm de largura)
//
// CONFERIDO NA MALHA (part="fit_check", ver embaixo): com a tampa assentada
// a interseção macho x fêmea é ZERO — só sobra a face plana do batente em
// z=84. Levantando a tampa 1,0mm sem girar, a interseção vira 320mm³
// espalhados pelos 12mm de rosca: ou seja, a rosca ENGATA de verdade e a
// tampa não sai puxando. O par do cupom dá exatamente o mesmo resultado.
//
// ORIENTAÇÃO DE IMPRESSÃO (nenhuma peça pede suporte):
//   corpo  — chão na cama, boca pra cima. Rosca externa com flanco de 50°
//            (39,8° de balanço + 3,1° de hélice = 43° no pior ponto),
//            transição interna da câmara pro gargalo em cone de 45°.
//   tampa  — TOPO na cama, boca pra cima. Assim a rosca interna imprime com
//            os mesmos 43° de balanço e a primeira camada é o disco inteiro.
//            O part="lid" já sai virado; não girar no slicer.

/* [Peça a renderizar] */
part = "both"; // "box" | "lid" | "test_neck" | "test_ring" | "both" (preview lado a lado) | "section" (montado, cortado ao meio) | "fit_check" (diagnóstico da rosca) | "none" (nada, pra dar include daqui)

/* [Deck com sleeve - medidas do deck REAL, tiradas com régua] */
// Medido em 2026-08-08: deck completo de 60 cartas COM sleeve = 93 x 68 x 45 mm.
// Aqui o deck fica EM PÉ: 93 é altura, 68 é largura da carta, 45 é a pilha.
deck_h = 93; // mm, altura da carta com sleeve (Z — o deck fica em pé)
deck_w = 68; // mm, largura da carta com sleeve (X)
deck_t = 45; // mm, espessura da pilha das 60 cartas (Y)

/* [Corpo] */
outer_d    = 114; // mm, diâmetro externo do conjunto (corpo e tampa têm o MESMO — fica liso na junta)
body_wall  = 2.6; // mm, parede externa do corpo
floor_t    = 3.0; // mm, chão do corpo (é a primeira camada, um disco inteiro)
pocket_wall = 2.0; // mm, parede do tubo central que segura o deck
rib_t      = 2.0; // mm, nervura radial em cada canto do bolso — separa os 4 poços laterais e amarra o tubo central na parede
head_clear = 3.0; // mm, ar entre o topo do deck e o teto da tampa fechada

/* [Tampa] */
lid_wall   = 2.4; // mm, parede da saia da tampa (fica por fora do gargalo)
lid_top    = 3.0; // mm, teto da tampa (é a primeira camada dela, disco inteiro)
rim_gap    = 3.0; // mm, ar entre a boca do corpo e o teto da tampa — garante que o BATENTE seja a saia no ressalto, não o topo do gargalo
rim_chamfer = 0.8; // mm, chanfro na boca da tampa, pra rosca pegar fácil

/* [Rosca - trapezoidal, 3 entradas, mão direita] */
// Perfil trapezoidal (NUNCA V agudo: em FDM o V lasca e imprime mal).
// Flanco de 50° com a horizontal = 39,8° de balanço; somado aos 3,1° de
// hélice dá 43° no pior ponto, dentro do que a A1 mini faz sem suporte.
thread_starts = 3;   // entradas: com 3, a tampa abre em 2/3 de volta em vez de 2 voltas
thread_pitch  = 6.0; // mm, passo de UMA entrada (o avanço por volta é passo x entradas = 18mm)
thread_depth  = 1.2; // mm, altura radial do dente
thread_flank  = 1.0; // mm, avanço axial do flanco (dente sobe 1.2 enquanto anda 1.0 -> flanco de 50°)
neck_h        = 12;  // mm, altura do gargalo roscado = 2 passos cheios; abre/fecha em 240°
neck_wall     = 2.4; // mm, material do gargalo entre o fundo do dente e o furo interno
thread_lead_in = 1.2; // mm, chanfro no topo do gargalo (os dentes somem em rampa, a tampa entra sem catar)
// Folga RADIAL macho/fêmea. O padrão de deslize do repo é 0.25/lado, mas
// rosca em Ø108 acumula erro de circunferência e o flanco de 50° só enxerga
// 0.77 x da folga radial na perpendicular: começamos em 0.35. É ESTE número
// que o cupom de rosca testa; trocar por override em vez de editar o modelo.
thread_clear = is_undef(thread_clear_override) ? 0.35 : thread_clear_override; // mm

/* [Folgas] */
content_clear  = 1.0; // mm por lado entre o deck e a parede do bolso (padrão do repo pra conteúdo)
pocket_chamfer = 1.2; // mm, funil de entrada no topo do bolso, pra guiar o deck na hora de guardar

/* [Posição na cama] */
// O modelo é construído em volta do eixo Z (x,y = 0), então cru ele cairia
// com 3/4 pra fora da cama no Bambu Studio. As peças de EXPORT saem
// centradas na cama; os previews ficam no eixo mesmo.
bed_mm = 180; // mm, cama da A1 mini

/* [Qualidade] */
$fn = 160;          // facetas dos cilindros: em Ø114 dá corda de 2.2mm (flecha 0.01mm)
thread_astep = 2;   // graus entre pontos do perfil 2D da rosca (180 pontos)
thread_slice = 2;   // graus de torção por fatia do linear_extrude
// thread_astep x thread_slice é o que decide o custo no CGAL: 2 e 2 dão
// ~22k quads no gargalo e ~28k no corte da tampa — renderiza em segundos.
// Baixar os dois pra 1 QUADRUPLICA a malha sem ganho visível.

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
R_out = outer_d / 2;
R_in  = R_out - body_wall;            // raio interno da câmara

// bolso do deck: medida real + folga de conteúdo; o tubo em volta é a parede
pocket_x  = deck_w + 2 * content_clear;   // 70
pocket_y  = deck_t + 2 * content_clear;   // 47
pocket_ox = pocket_x + 2 * pocket_wall;   // 74  (face externa do tubo)
pocket_oy = pocket_y + 2 * pocket_wall;   // 51
pocket_diag  = norm([pocket_x, pocket_y]);   // diagonal do vão — o deck só passa por furo maior que isso
corner_r     = norm([pocket_ox, pocket_oy]) / 2; // raio do canto do tubo
rib_angle    = atan2(pocket_oy, pocket_ox);      // direção da nervura de canto

// rosca: raios saem do lado de fora pra dentro, pra tampa e corpo terem o MESMO diâmetro externo
lead       = thread_starts * thread_pitch;  // avanço por volta (mm)
deg_per_mm = 360 / lead;                    // conversão eixo -> ângulo no perfil 2D
R_maj  = R_out - lid_wall - thread_clear;   // crista do macho
R_root = R_maj - thread_depth;              // fundo do macho
R_bore = R_root - neck_wall;                // furo interno do gargalo
period    = 360 / thread_starts;            // ângulo de um passo no perfil 2D
flank_deg = thread_flank * deg_per_mm;
crest_deg = (thread_pitch - 2 * thread_flank) / 2 * deg_per_mm;
root_deg  = period - 2 * flank_deg - crest_deg;
helix_deg = atan(lead / (2 * PI * R_maj));  // hélice: soma no balanço do flanco
flank_over = 90 - atan(thread_depth / thread_flank); // balanço do flanco (0 = parede vertical)

// pilha vertical (z=0 é a cama, com o corpo apoiado no chão)
cone_h      = R_in - R_bore;                 // cone de 45° da câmara pro gargalo
lid_inner_h = neck_h + rim_gap;              // profundidade interna da tampa
deck_top    = floor_t + deck_h;              // topo do deck guardado
z_ledge     = deck_top + head_clear - lid_inner_h; // ressalto onde a saia da tampa bate (BATENTE)
z_ct        = z_ledge - cone_h;              // topo da câmara reta = topo do tubo do bolso e das nervuras
box_h       = z_ledge + neck_h;              // altura do corpo (boca)
lid_h       = lid_inner_h + lid_top;         // altura da tampa
assembled_h = z_ledge + lid_inner_h + lid_top;
comp_h      = z_ct - floor_t;                // altura útil dos 4 poços laterais
deck_grip   = deck_top - z_ct;               // quanto o deck sobra acima do tubo (é por aqui que a mão pega)
open_turn   = 360 * neck_h / lead;           // graus pra abrir/fechar

// checagens que travam o modelo se alguém mexer num parâmetro e quebrar a função
assert(2 * R_bore > pocket_diag + 6,
       "furo do gargalo pequeno demais: o deck nao passa (precisa > diagonal do bolso)");
assert(R_bore > corner_r,
       "furo do gargalo menor que o canto do tubo: a boca do bolso ficaria tapada");
assert(R_in - corner_r > 6, "sobrou pouco espaco lateral pros compartimentos");
assert(neck_wall >= 2, "parede do gargalo fina demais pra rosca");
assert(deck_grip >= 12, "deck sobra pouco acima do tubo: nao da pra pegar com o dedo");

echo(str("=== deckbox-03 ==="));
echo(str("externo: D", outer_d, " x ", box_h, " (corpo) / tampa ", lid_h,
         " / montado ", assembled_h));
echo(str("camara: D", 2 * R_in, "  bolso ", pocket_x, "x", pocket_y,
         " (diag ", pocket_diag, ")  tubo externo ", pocket_ox, "x", pocket_oy));
echo(str("poco LARGO: prof ", R_in - pocket_oy / 2, " x corda ",
         2 * sqrt(R_in * R_in - pocket_oy * pocket_oy / 4), " x alt ", comp_h));
echo(str("poco ESTREITO: prof ", R_in - pocket_ox / 2, " x corda ",
         2 * sqrt(R_in * R_in - pocket_ox * pocket_ox / 4), " x alt ", comp_h));
echo(str("gargalo: furo D", 2 * R_bore, "  macho D", 2 * R_maj, "/D", 2 * R_root,
         "  parede ", neck_wall, "  ressalto z=", z_ledge));
echo(str("rosca: ", thread_starts, " entradas, passo ", thread_pitch,
         ", avanco ", lead, "/volta, folga ", thread_clear,
         " -> abre em ", open_turn, " graus"));
echo(str("perfil (graus): fundo ", root_deg, " + flanco ", flank_deg,
         " + crista ", crest_deg, " + flanco ", flank_deg, " = ", period));
echo(str("balanco do flanco ", flank_over, " + helice ", helix_deg,
         " = ", flank_over + helix_deg, " graus (teto 45)"));
echo(str("deck: topo em z=", deck_top, " (boca do corpo z=", box_h,
         "), sobra ", deck_grip, " acima do tubo"));

// ---------------------------------------------------------------------
// Rosca
// ---------------------------------------------------------------------
// Perfil 2D: o corte HORIZONTAL de uma rosca de n entradas é um disco com n
// dentes; girando esse disco enquanto sobe (linear_extrude twist) sai a
// hélice de verdade. Um passo axial vale `period` graus no perfil, então o
// dente trapezoidal do corte axial vira este trapézio angular:
//   fundo (root_deg) -> flanco subindo -> crista (crest_deg) -> flanco descendo
function thr_r(u, r_root, r_maj) =
      u < root_deg                         ? r_root
    : u < root_deg + flank_deg             ? r_root + (r_maj - r_root) * (u - root_deg) / flank_deg
    : u < root_deg + flank_deg + crest_deg ? r_maj
    : r_maj - (r_maj - r_root) * (u - root_deg - flank_deg - crest_deg) / flank_deg;

module thread_profile_2d(r_root, r_maj) {
    n = round(360 / thread_astep);
    polygon([for (i = [0 : n - 1])
             let (a = i * 360 / n, u = a - period * floor(a / period),
                  r = thr_r(u, r_root, r_maj))
             [r * cos(a), r * sin(a)]]);
}

// Haste roscada MACIÇA (o furo vem depois, por subtração). Torção negativa =
// o dente anda no sentido anti-horário visto de cima conforme sobe = rosca de
// MÃO DIREITA: fecha girando a tampa no sentido horário, como todo mundo espera.
module thread_rod(r_root, r_maj, h) {
    tw = -360 * h / lead;
    linear_extrude(height = h, twist = tw,
                   slices = max(2, ceil(abs(tw) / thread_slice)), convexity = 10)
        thread_profile_2d(r_root, r_maj);
}

// Chanfro de 45° na ponta do gargalo: os dentes somem em rampa nos últimos
// `thread_lead_in` mm, então a tampa entra sem precisar catar a entrada.
module neck_top_chamfer(z_top) {
    translate([0, 0, z_top - thread_lead_in])
        difference() {
            cylinder(h = thread_lead_in + 1, r = R_out + 5);
            cylinder(h = thread_lead_in, r1 = R_maj + 0.01, r2 = R_maj - thread_lead_in);
        }
}

// ---------------------------------------------------------------------
// Corpo (box): cilindro com chão, bolso central do deck, 4 poços laterais
// separados por nervuras de canto, e o gargalo roscado no topo. O ressalto
// em z_ledge (o degrau de lid_wall + folga) é onde a saia da tampa bate.
// ---------------------------------------------------------------------
module box() {
    difference() {
        union() {
            cylinder(h = z_ledge, r = R_out);
            translate([0, 0, z_ledge]) thread_rod(R_root, R_maj, neck_h);
        }
        interior_cut();
        neck_top_chamfer(box_h);
        // chanfro na borda do furo, pra boca não ficar em fio de faca
        translate([0, 0, box_h - 0.8])
            cylinder(h = 0.9, r1 = R_bore, r2 = R_bore + 0.8);
    }
}

// Tudo o que é vazio dentro do corpo.
module interior_cut() {
    translate([0, 0, floor_t]) {
        // 4 poços laterais = a coroa entre o tubo do bolso e a parede,
        // cortada em quatro pelas nervuras de canto
        difference() {
            cylinder(h = comp_h, r = R_in);
            translate([-pocket_ox / 2, -pocket_oy / 2, -1])
                cube([pocket_ox, pocket_oy, comp_h + 2]);
            corner_ribs(comp_h + 2);
        }
        // bolso do deck
        translate([-pocket_x / 2, -pocket_y / 2, 0])
            cube([pocket_x, pocket_y, comp_h]);
    }
    // funil de 45° na boca do bolso (guia o deck na hora de guardar);
    // sobra parede plana no topo do tubo, sem virar fio de faca
    hull() {
        translate([0, 0, z_ct - pocket_chamfer]) plate(pocket_x, pocket_y);
        translate([0, 0, z_ct]) plate(pocket_x + 2 * pocket_chamfer,
                                      pocket_y + 2 * pocket_chamfer);
    }
    // cone de 45° da câmara pro gargalo: fecha o vão de 3.75mm sem balanço
    translate([0, 0, z_ct]) cylinder(h = cone_h, r1 = R_in, r2 = R_bore);
    // furo do gargalo
    translate([0, 0, z_ledge]) cylinder(h = neck_h + 1, r = R_bore);
}

// Barras radiais nos 4 cantos do bolso. Só o trecho fora do tubo sobra como
// nervura (o resto cai no corte do bolso), e é ele que separa os poços.
module corner_ribs(h) {
    for (a = [rib_angle, -rib_angle, 180 - rib_angle, 180 + rib_angle])
        rotate([0, 0, a])
            translate([0, -rib_t / 2, 0])
                cube([R_in + 1, rib_t, h]);
}

module plate(a, b) { translate([-a / 2, -b / 2, 0]) cube([a, b, 0.01]); }

// ---------------------------------------------------------------------
// Tampa (lid): copo de rosca interna. Modelada na posição MONTADA (boca em
// z=0, teto em cima); part="lid" já entrega ela virada pra imprimir.
// A fêmea é o mesmo perfil do macho com os raios somados de thread_clear —
// isso dá folga radial `thread_clear` e 2 x thread_clear de folga axial.
// ---------------------------------------------------------------------
module lid_assembled() {
    over = 0.6; // corte começa abaixo da boca, pra rosca já nascer na borda
    difference() {
        cylinder(h = lid_h, r = R_out);
        // o rotate compensa a FASE que o translate introduz (cada mm de
        // descida gira o perfil 360/lead graus): sem ele a fêmea nasceria
        // 12° fora do macho e a peça montada do preview mentiria
        translate([0, 0, -over]) rotate([0, 0, -360 * over / lead])
            thread_rod(R_root + thread_clear, R_maj + thread_clear, lid_inner_h + over);
        translate([0, 0, -0.01])
            cylinder(h = rim_chamfer + 0.01,
                     r1 = R_maj + thread_clear + rim_chamfer,
                     r2 = R_maj + thread_clear);
    }
}

// Orientação de impressão: TETO na cama. Assim a rosca interna sai com os
// mesmos 42,8° de balanço do macho e a 1ª camada é o disco cheio.
module lid_print() { translate([0, 0, lid_h]) rotate([180, 0, 0]) lid_assembled(); }

// ---------------------------------------------------------------------
// Cupom de rosca: um pedaço do gargalo de verdade + o anel da tampa, no
// diâmetro REAL e na MESMA orientação de impressão das peças grandes.
// Serve pra medir na mão se a folga está boa ANTES do print grande.
// ---------------------------------------------------------------------
test_base = 3; // mm, disco de base do cupom (faz o papel do ressalto/batente)

module test_neck() {
    difference() {
        union() {
            cylinder(h = test_base, r = R_out);
            translate([0, 0, test_base]) thread_rod(R_root, R_maj, neck_h);
        }
        translate([0, 0, -1]) cylinder(h = test_base + neck_h + 2, r = R_bore);
        neck_top_chamfer(test_base + neck_h);
    }
}

module test_ring_assembled() {
    over = 0.6;
    difference() {
        cylinder(h = lid_inner_h, r = R_out);
        translate([0, 0, -over]) rotate([0, 0, -360 * over / lead])
            thread_rod(R_root + thread_clear, R_maj + thread_clear, lid_inner_h + 2 * over);
        translate([0, 0, -0.01])
            cylinder(h = rim_chamfer + 0.01,
                     r1 = R_maj + thread_clear + rim_chamfer,
                     r2 = R_maj + thread_clear);
    }
}

// Mesma virada da tampa: o anel tem que imprimir com a boca pra CIMA, senão
// o teste não reproduz o balanço real da rosca interna.
module test_ring_print() {
    translate([0, 0, lid_inner_h]) rotate([180, 0, 0]) test_ring_assembled();
}

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
// Peça de export sai centrada na cama, pra chapa abrir pronta no slicer.
module on_bed() { translate([bed_mm / 2, bed_mm / 2, 0]) children(); }

if (part == "box") {
    on_bed() box();
} else if (part == "lid") {
    on_bed() lid_print();
} else if (part == "test_neck") {
    on_bed() test_neck();
} else if (part == "test_ring") {
    on_bed() test_ring_print();
} else if (part == "fit_check") {
    // DIAGNÓSTICO, não é peça: sobreposição entre o macho do gargalo e a
    // fêmea da tampa com a tampa ASSENTADA no batente. Tem que sair VAZIO
    // ("Top level object is empty" no sumário do CGAL) — se sair sólido, a
    // rosca trava e a folga precisa subir. Rodar sempre que mexer em
    // thread_clear / perfil / passo:
    //   openscad -o /var/home/afonsolelis/.cache/fit.stl -D 'part="fit_check"' deckbox-03.scad
    intersection() {
        box();
        translate([0, 0, z_ledge]) lid_assembled();
    }
} else if (part == "section") {
    // conjunto fechado, cortado ao meio: confere engate da rosca, batente,
    // folga do deck e altura dos poços
    difference() {
        union() {
            box();
            translate([0, 0, z_ledge]) lid_assembled();
            // deck fantasma, na posição de guardado (só no preview: o
            // modificador % some no --render, então a seção sai limpa)
            % translate([-deck_w / 2, -deck_t / 2, floor_t])
                cube([deck_w, deck_t, deck_h]);
        }
        translate([-R_out - 5, 0, -1]) cube([2 * R_out + 10, R_out + 5, assembled_h + 10]);
    }
} else if (part == "none") {
    // nada: deixa outro .scad de diagnóstico dar include neste arquivo e
    // usar os módulos/derivados sem herdar geometria junto
} else {
    // preview lado a lado, na orientação de impressão de cada uma
    box();
    translate([outer_d + 10, 0, 0]) lid_print();
}
