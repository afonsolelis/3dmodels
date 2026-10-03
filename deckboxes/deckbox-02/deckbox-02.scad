// deckbox-02.scad
// Versão de UM deck do deckbox-01 (deck real com sleeve 93x68x45, medido
// com régua) com compartimento de dados fundo (64mm) e SEM ímãs. A bandeja
// fica presa na capa por dois ressaltos laterais rampados (na bandeja) que
// assentam em dois rebaixos cegos (pockets) na face interna da capa.
//
// Histórico da trava (teste físico):
//  - v1: ressaltos + LINGUETAS soltas por dois rasgos compridos (1.2mm x
//    32mm) em cada parede da capa -> ABRIA SOZINHA (~4N pra abrir).
//  - v2 (esta): mesmos ressaltos/pockets, parede lateral CONTÍNUA (sem
//    rasgos), reforço EXTERNO de 0.6mm/lado nos 36mm junto da boca (parede
//    1.6 -> 2.2mm; pele atrás do pocket 1.4mm). A parede inteira flexiona
//    0.5mm pro ressalto passar, mas só na ABA de 1.8mm logo depois do pocket:
//    dali até a boca um CANAL raso (0.4mm) deixa só 0.1mm de interferência.
//    Estimativa (placa Ritz e viga do print-review, PLA E=3GPa, k~26-30N/mm
//    por lado): abrir 14-23N com atrito 0.3, 20-33N com atrito 0.5; empeno
//    da capa pra dentro soma, até ~40N no pior caso. Fechar ~16-25N (rampa
//    da aba). Tensão <=~18MPa (PLA ~50MPa).
//
// Manuseio: fechar empurrando a traseira da bandeja com a palma até o
// "clique" (os ressaltos caem nos pockets nos últimos ~5mm do curso).
// Abrir: segurar a capa e empurrar a bandeja pelo furo de 22mm do fundo por
// ~5mm (clique + aba, dedo ~10mm dentro do furo). A partir daí a parede
// devolve a bandeja pela rampa e sobra um arrasto leve (~2-3N) até a boca,
// com a traseira da bandeja ~5mm pra fora pra puxar com os dedos.
//
// Só a CAPA mudou da trava v1 pra v2: cavidade, pockets, boca e posição
// dos ressaltos são os mesmos; a bandeja da v1 continua valendo.
// Recomendado brim de 3-5mm no job da capa (tubo alto em pé).
//
// Histórico da cestinha (teste físico):
//  - v1 (= deckbox-01): 97.4x72.4, 0.3/lado no compartimento de 98x73,
//    cantos vivos, sem chanfro, hex 8mm/web 2 nas paredes (~60% de furo),
//    U de 40mm -> ruim de entrar/sair (deslize vertical de ~50mm) e molenga.
//  - v2 (2026-09-30, esta; capa v2 e trava aprovadas no mesmo teste):
//    97.0x72.0x49.6 (0.5/lado no MESMO compartimento - bandeja e capa
//    idênticas), parede 1.6 (4 voltas de bico, engrossada pra DENTRO a
//    pedido do usuário), chanfro 1mm/45 graus na borda de baixo, cantos r=2
//    por fora com filete interno r=1 (canto 1.85mm na diagonal; passa a
//    0.15mm de um canto vivo 93x68), paredes com hex 6mm/web 3 e faixa
//    sólida ~5mm em cima e embaixo, U 32mm até o chão. Deck 93x68 fica
//    JUSTO: 0.4/lado dentro (93.8x68.8). Manuseio igual: o dedo
//    empurra o chão pelo furo de 16mm da bandeja, pega pela borda e tira.
//  - pilares (variante, 2026-09-30): mesmo externo/chão/chanfro/cantos da
//    v2, SEM paredes - 4 pilares em L de 1.6 nos cantos, pernas afuniladas
//    de 20 (base) a 10mm (topo), miolo do canto com filete r=2.5, pé com
//    concordância r=4, chanfro de entrada no topo, chão com quadro sólido de
//    6mm. Lados abertos do chão ao topo: vão 57->77 (comprido), 32->52mm
//    (curto). 5N na ponta: flexão ~0.08mm (X/Y), ~0.11 (diagonal), contra
//    ~10mm de uma perna isolada; torção pior caso ~0.55mm (dedo na borda da
//    perna; pra dentro o deck segura a 0.4). (Uma variante com aro
//    e janelas foi feita e recusada pelo usuário no mesmo dia.)
//
// Exports canônicos (flatpak, caminhos ABSOLUTOS; -D só em variável final):
// Job da capa - em pé sobre a ponta fechada (capa v2 já impressa e aprovada):
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/3mf/deckbox-02-sleeve.3mf -D 'part="sleeve"' -D 'sleeve_print=true' /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/deckbox-02.scad
// Job da cestinha v2 - chão na mesa, boca pra cima (o que reimprimir agora):
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/3mf/deckbox-02-basket.3mf -D 'part="basket"' /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/deckbox-02.scad
// Job da cestinha de PILARES (variante: só pilares em L nos cantos) - chão na mesa:
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/3mf/deckbox-02-basket-pillars.3mf -D 'part="basket"' -D 'basket_style="pillars"' /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/deckbox-02.scad
//   (STL: mesmo comando com -o .../stl/deckbox-02-basket-pillars.stl)
// Job completo - bandeja + cestinha + capa em pé numa chapa:
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/3mf/deckbox-02-plate.3mf -D 'part="plate"' /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/deckbox-02.scad
// Cupom de teste do clique - os 45mm da boca, de boca pra cima:
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/3mf/deckbox-02-coupon.3mf -D 'part="sleeve"' -D 'sleeve_coupon=true' /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/deckbox-02.scad
// STLs de referência (posição de uso), <part> = tray | sleeve | basket:
//   flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/stl/deckbox-02-<part>.stl -D 'part="<part>"' /home/afonsolelis/repos/3dmodels/deckboxes/deckbox-02/deckbox-02.scad

/* [Variante: 1 deck, sem ímãs, trava por ressaltos] */
snap_override = true;     // liga ressaltos (bandeja) + pockets (capa) do deckbox-01
magnets_override = false; // pontas sólidas, sem alojamento de ímã
deck_lanes = 1;           // um compartimento de deck
dice_depth = 64;          // mm, profundidade do compartimento de dados (deckbox-01 usa 30)
sleeve_tray_reveal = 0;   // mm, traseira da bandeja alinhada com a boca da capa quando fechada
sleeve_finger_hole_d = 22; // mm, furo no fundo da capa pra empurrar a bandeja com o dedo (fundo 58 alto, cavidade 54.8)
include <../deckbox-01/deckbox-01.scad>

/* [Reforço externo da capa - exclusivo do deckbox-02] */
sleeve_reinforce = 0.6;        // mm/lado, acréscimo EXTERNO nas paredes laterais (cavidade intacta); 0.8 passava de ~40N com atrito alto
sleeve_reinforce_length = 36;  // mm, faixa a partir da boca; o ressalto trabalha só nos 10.6mm finais
sleeve_reinforce_ramp = 4;     // mm, transição em X (em pé: 11 graus da vertical, sem suporte)
sleeve_print = false;          // true = capa em pé sobre a ponta fechada (job da capa)

/* [Canal de alívio: clique curto, arrasto leve até a boca] */
// Depois do pocket, do lado da boca, a parede fica cheia por snap_tab (é a
// aba que dá o clique, com a flexão total); daí uma rampa leva a um canal
// raso até a boca, onde o ressalto passa só com a interferência residual.
snap_tab = 1.8;              // mm, aba cheia entre a borda do pocket e o início da rampa
snap_channel_lead = 1.6;     // mm, rampa aba -> canal (inclinação 0.4/1.6 = rampa de fechar)
snap_channel_depth = 0.4;    // mm, profundidade do canal na face interna; residual = 0.5 - isto
snap_channel_band = 6.6;     // mm, largura do canal em Z (= base do ressalto 6 + 2x0.3 do pocket)

/* [Cupom de teste do clique] */
sleeve_coupon = false;       // true (com part="sleeve") = só a ponta da boca, de boca pra cima
sleeve_coupon_length = 45;   // mm, trecho final da capa: boca + pocket + canal + rampa do reforço

// Derivados
reinforce_start = sleeve_outer_l - sleeve_reinforce_length; // mm, X onde começa a rampa
reinforced_wall = wall + sleeve_reinforce;                  // mm, parede lateral na faixa
reinforced_pocket_skin = reinforced_wall - snap_pocket_depth; // mm, pele atrás do pocket
snap_travel = sleeve_outer_l - snap_sleeve_x;               // mm, curso com a parede flexionada
ramp_clear = (snap_sleeve_x - snap_length/2 - snap_pocket_clear)
           - (reinforce_start + sleeve_reinforce_ramp); // mm, fim da rampa -> borda do pocket (negativo = sobrepõe)
plate_sleeve_shift = snap_projection + sleeve_reinforce;    // mm, mantém o gap da chapa medido do ressalto ao reforço
pocket_rim_x = snap_sleeve_x + snap_length/2 + snap_pocket_clear; // mm, borda do pocket do lado da boca
channel_x0 = pocket_rim_x + snap_tab;                       // mm, fim da aba cheia / início da rampa
channel_x1 = channel_x0 + snap_channel_lead;                // mm, canal na profundidade total daqui até a boca
channel_residual = snap_deflection - snap_channel_depth;    // mm/lado, interferência no canal
channel_skin = reinforced_wall - snap_channel_depth;        // mm, parede atrás do canal
assert(sleeve_reinforce >= 0 && fit_tolerance >= 0.5);
assert(ramp_clear > 0, "o pocket tem que ficar inteiro na faixa reforçada");
assert(reinforced_pocket_skin >= 1.2);
assert(channel_residual >= 0 && channel_residual <= 0.2, "canal: residual entre 0 e 0.2");
assert(snap_tab >= 1.5 && channel_x1 < sleeve_outer_l - mouth_lead, "aba e rampa antes do chanfro da boca");
assert(sleeve_coupon_length > sleeve_reinforce_length, "cupom tem que incluir a rampa do reforço");
echo(magnet_enabled=magnet_enabled, snap_enabled=snap_enabled, fit_per_side=fit_tolerance,
     long_slots=false, reinforced_wall_mm=reinforced_wall,
     pocket_skin_mm=reinforced_pocket_skin, required_deflection_mm=snap_deflection,
     snap_travel_mm=snap_travel, pocket_to_ramp_mm=ramp_clear, sleeve_print=sleeve_print,
     sleeve_coupon=sleeve_coupon, finger_hole_mm=finger_hole_d_eff, tab_mm=snap_tab,
     channel_x_mm=[channel_x0, channel_x1, sleeve_outer_l], channel_residual_mm=channel_residual,
     channel_skin_mm=channel_skin,
     tray_mm=[tray_outer_l, tray_outer_w + 2*snap_projection, tray_outer_h],
     sleeve_mm=[sleeve_outer_l, sleeve_outer_w + 2*sleeve_reinforce, sleeve_outer_h],
     basket_mm=[bk_l, bk_w, basket_h], basket_wall_mm=basket_wall_v2);

// Sobrescreve a capa (e, mais abaixo, a cestinha) neste include; o
// deckbox-01 continua intacto.
// - sleeve_print: capa em pé, ponta fechada na mesa, boca pra cima.
// - part="plate": a chapa do deckbox-01 põe a capa a plate_gap da bandeja
//   SEM contar ressalto nem reforço; o deslocamento devolve os 6mm.
module sleeve() {
    if (sleeve_coupon)
        translate([sleeve_outer_h, sleeve_reinforce, 0]) rotate([0, -90, 0])
            translate([-(sleeve_outer_l - sleeve_coupon_length), 0, 0])
                intersection() {
                    reinforced_sleeve();
                    translate([sleeve_outer_l - sleeve_coupon_length, -5, -1])
                        cube([sleeve_coupon_length + 1, sleeve_outer_w + 10, sleeve_outer_h + 2]);
                }
    else if (sleeve_print)
        translate([sleeve_outer_h, sleeve_reinforce, 0]) rotate([0, -90, 0]) reinforced_sleeve();
    else if (part == "plate")
        translate([0, plate_sleeve_shift, 0]) reinforced_sleeve();
    else
        reinforced_sleeve();
}

module reinforced_sleeve() {
    difference() {
        union() {
            cube([sleeve_outer_l, sleeve_outer_w, sleeve_outer_h]);
            for (side = [0, 1])
                translate([0, side * sleeve_outer_w, 0])
                    scale([1, side == 0 ? -1 : 1, 1])
                        hull() {
                            translate([reinforce_start, -0.02, 0]) cube([0.02, 0.04, sleeve_outer_h]);
                            translate([reinforce_start + sleeve_reinforce_ramp, -0.02, 0])
                                cube([sleeve_reinforce_length - sleeve_reinforce_ramp,
                                      sleeve_reinforce + 0.02, sleeve_outer_h]);
                        }
        }
        translate([end_wall, wall, wall]) cube([sleeve_outer_l, sleeve_cavity_w, sleeve_cavity_h]);
        mouth_lead_in();
        finger_hole();
        // Só os pockets: NÃO chamar snap_sleeve_cuts(), que também abriria
        // os rasgos compridos da v1 (reprovada: abria sozinha).
        translate([snap_sleeve_x, wall, snap_sleeve_z]) mirror([0, 1, 0]) snap_pocket();
        translate([snap_sleeve_x, sleeve_outer_w - wall, snap_sleeve_z]) snap_pocket();
        translate([0, wall, snap_sleeve_z]) mirror([0, 1, 0]) snap_channel();
        translate([0, sleeve_outer_w - wall, snap_sleeve_z]) snap_channel();
    }
}

// Canal raso na face interna (lado +Y a partir do plano da cavidade), na
// faixa Z do ressalto, da aba até além da boca. Rampa na ponta da aba. Em pé
// as paredes do canal ficam verticais e a rampa só afina a parede conforme
// sobe: sem balanço. Na boca ele some dentro do chanfro de entrada (0.8 > 0.4).
module snap_channel() {
    hull() {
        translate([channel_x0, -0.1, -snap_channel_band/2]) cube([0.01, 0.11, snap_channel_band]);
        translate([channel_x1, -0.1, -snap_channel_band/2])
            cube([sleeve_outer_l + 1 - channel_x1, snap_channel_depth + 0.1, snap_channel_band]);
    }
}

// ---------------------------------------------------------------------
// Cestinha v2 - exclusiva do deckbox-02 (sobrescreve basket() do include)
// ---------------------------------------------------------------------
// Teste físico da v1: ruim de entrar/sair do compartimento (0.3/lado, 50mm
// de deslize vertical, sem chanfro, cantos vivos) e molenga (parede 1.2 com
// ~60% de furo, U de 40mm, topo sem reforço). O COMPARTIMENTO da bandeja
// (lane_inner_l/w, que vem do basket_clear=0.3 do deckbox-01) NÃO muda: só a
// cestinha encolhe por fora. NUNCA reatribuir basket_clear aqui - a última
// atribuição vale pro arquivo todo e mudaria a bandeja e a capa.

/* [Cestinha v2 - encaixe no compartimento] */
basket_clear_v2  = 0.5; // mm/lado, folga cestinha <-> compartimento (era 0.3; deslize de ~50mm)
basket_chamfer   = 1.0; // mm, chanfro 45 graus na borda de baixo por fora (pé de elefante + guia de entrada)
basket_corner_r  = 2.0; // mm, raio dos cantos verticais por fora
basket_fillet_r  = 1.0; // mm, raio dos cantos verticais por dentro (canto mais grosso que a parede); <=1.36 pra não invadir o deck 93x68 com 0.4/lado

/* [Cestinha v2 - paredes] */
basket_wall_v2 = 1.6; // mm, parede (4 voltas de bico 0.4); engrossa pra DENTRO, externo fixo. NÃO é o basket_wall do deckbox-01 (1.2), que define o compartimento da bandeja
wall_hex_d     = 6;   // mm, furo hexagonal das paredes, entre faces (chão segue com hex_d = 8)
wall_hex_web   = 3;   // mm, material entre furos vizinhos da parede
wall_band      = 4.9; // mm, faixa sólida mínima no topo e na base (acima do chão) de cada parede; ~5 (com 4.9 entram 5 fileiras)
wall_corner_m  = 4.5; // mm, faixa sólida vertical junto de cada canto, medida da face externa
wall_u_m       = 3;   // mm, faixa sólida mínima entre o furo e a borda do U (sem lascas, regra 4)
cutout_w_v2    = 32;  // mm, largura do recorte em U (era 40), desce até o chão
cutout_r_v2    = 6;   // mm, raio dos cantos de baixo do U

// Derivados
bk_l   = lane_inner_l - 2 * basket_clear_v2;  // mm, comprimento externo (X)
bk_w   = lane_inner_w - 2 * basket_clear_v2;  // mm, largura externa (Y)
bk_in_l = bk_l - 2 * basket_wall_v2;             // mm, cavidade X
bk_in_w = bk_w - 2 * basket_wall_v2;             // mm, cavidade Y
bk_deck_side = (bk_in_l - deck_length) / 2;   // mm/lado, folga do deck no comprimento
bk_deck_side_w = (bk_in_w - deck_width) / 2;  // mm/lado, folga do deck na largura
// canto: espessura na diagonal (arco externo r_o -> arco interno r_i)
bk_corner_diag = (basket_wall_v2 + basket_fillet_r * (1 - 1/sqrt(2))
                  - basket_corner_r * (1 - 1/sqrt(2))) * sqrt(2);
// folga do canto VIVO do deck (pior caso, carta sem canto arredondado) até o filete
bk_fillet_deck_gap = basket_fillet_r - sqrt(2) * (basket_fillet_r - min(bk_deck_side, bk_deck_side_w));
wh_R  = wall_hex_d / sqrt(3);            // mm, circunraio do furo da parede
wh_sx = wall_hex_d + wall_hex_web;       // mm, passo horizontal
wh_sy = wh_sx * sqrt(3) / 2;             // mm, passo entre fileiras
wh_z0 = basket_floor + wall_band;        // mm, início da zona furada
wh_z1 = basket_h - wall_band;            // mm, fim da zona furada
wh_rows = floor((wh_z1 - wh_z0 - 2 * wh_R) / wh_sy) + 1;
wh_band_real = (wh_z1 - wh_z0 - (2 * wh_R + (wh_rows - 1) * wh_sy)) / 2 + wall_band; // mm, faixa real
u_x0 = bk_l / 2 - cutout_w_v2 / 2;       // mm, borda esquerda do U
u_x1 = bk_l / 2 + cutout_w_v2 / 2;       // mm, borda direita do U
long_segs  = [[wall_corner_m, u_x0 - wall_u_m], [u_x1 + wall_u_m, bk_l - wall_corner_m]];
short_segs = [[wall_corner_m, bk_w - wall_corner_m]];
plate_basket_shift = basket_clear_v2 - basket_clear; // mm, centra a cestinha menor no lugar da v1 na chapa
assert(bk_fillet_deck_gap > 0, "filete interno invade o deck");
assert(min(bk_deck_side, bk_deck_side_w) >= 0.3, "deck justo demais");
assert(bk_corner_diag >= basket_wall_v2, "canto tem que ser mais grosso que a parede");
assert(basket_chamfer < basket_floor && basket_chamfer < basket_corner_r);
assert(cutout_w_v2 >= 2 * cutout_r_v2);
echo(basket_v2_mm=[bk_l, bk_w, basket_h], lane_mm=[lane_inner_l, lane_inner_w],
     basket_clear_per_side=basket_clear_v2, basket_cavity_mm=[bk_in_l, bk_in_w],
     deck_per_side_mm=[bk_deck_side, bk_deck_side_w], corner_diag_mm=bk_corner_diag,
     fillet_to_deck_corner_mm=bk_fillet_deck_gap, wall_hex_rows=wh_rows,
     wall_band_real_mm=wh_band_real, u_mm=[u_x0, u_x1], long_segs=long_segs,
     lane_depth_mm=tray_outer_h - wall, basket_top_below_rim_mm=tray_outer_h - wall - basket_h);

module rrect(l, w, r) {
    translate([r, r]) offset(r = r) square([l - 2 * r, w - 2 * r]);
}

module basket() {
    if (basket_style == "pillars")
        basket_pillars();
    else
        translate(part == "plate" ? [plate_basket_shift, plate_basket_shift, 0] : [0, 0, 0])
            basket_v2();
}

module basket_v2() {
    c = basket_chamfer;
    difference() {
        // casca externa: cantos r=2, chanfro 45 graus embaixo
        hull() {
            translate([c, c, 0]) linear_extrude(0.01) rrect(bk_l - 2 * c, bk_w - 2 * c, basket_corner_r - c);
            translate([0, 0, c]) linear_extrude(basket_h - c) rrect(bk_l, bk_w, basket_corner_r);
        }
        // cavidade com filete interno nos cantos
        translate([basket_wall_v2, basket_wall_v2, basket_floor])
            linear_extrude(basket_h) rrect(bk_in_l, bk_in_w, basket_fillet_r);
        // recortes em U nas laterais compridas
        u_cutout_v2(0);
        u_cutout_v2(bk_w - basket_wall_v2);
        // chão: colmeia de 8mm do deckbox-01
        translate([basket_wall_v2, basket_wall_v2, 0])
            hex_panel(bk_in_l, bk_in_w, basket_floor);
        // paredes compridas
        for (y = [basket_wall_v2, bk_w])
            translate([0, y, 0]) rotate([90, 0, 0]) wall_hexes(long_segs, basket_wall_v2);
        // paredes curtas
        for (x = [0, bk_l - basket_wall_v2])
            translate([x, 0, 0]) rotate([90, 0, 90]) wall_hexes(short_segs, basket_wall_v2);
    }
}

// Furos hexagonais (ponta pra cima) no plano XY local (x = ao longo da
// parede, y = altura), atravessando t em Z. Em cada segmento [x0, x1] a
// colmeia é centrada; fileiras centradas entre wh_z0 e wh_z1. Só entra furo
// inteiro dentro do segmento.
module wall_hexes(segs, t) {
    ztop = wh_z0 + wh_band_real - wall_band; // centra as fileiras na zona
    for (s = segs) {
        c = (s[0] + s[1]) / 2;
        half = (s[1] - s[0]) / 2;
        for (j = [0 : wh_rows - 1], i = [-ceil(half / wh_sx) - 1 : ceil(half / wh_sx) + 1]) {
            cx = c + (i + (j % 2) * 0.5) * wh_sx;
            cy = ztop + wh_R + j * wh_sy;
            if (abs(cx - c) + wall_hex_d / 2 <= half + 1e-6)
                translate([cx, cy, -0.1]) rotate([0, 0, 30])
                    cylinder(h = t + 0.2, r = wh_R, $fn = 6);
        }
    }
}

// U de cantos redondos aberto no topo, atravessando a parede comprida que
// começa em y0; desce até o chão da cestinha (pinçar a última carta).
module u_cutout_v2(y0) {
    r = cutout_r_v2;
    translate([0, y0 - 0.1, 0]) {
        hull()
            for (xx = [u_x0 + r, u_x1 - r])
                translate([xx, 0, basket_floor + r]) rotate([-90, 0, 0])
                    cylinder(h = basket_wall_v2 + 0.2, r = r);
        translate([u_x0, 0, basket_floor + r]) cube([cutout_w_v2, basket_wall_v2 + 0.2, basket_h]);
    }
}

// ---------------------------------------------------------------------
// Cestinha de PILARES - variante da v2 (basket_style = "pillars", com part="basket")
// ---------------------------------------------------------------------
// Mesmo externo, folga, chão de colmeia, chanfro e cantos da v2, mas SEM
// paredes: só 4 pilares em L nos cantos, da altura toda, e os 4 lados
// abertos do chão ao topo (pinçar até a última carta). A perna tem 1.6 de
// espessura e não dá pra engrossar (externo limitado pela bandeja, interno
// pelo deck a 0.4/lado), então a rigidez vem da GEOMETRIA:
//  - seção em L com pernas longas: em flexão a L é ~100x mais rígida que
//    uma perna isolada de 1.6;
//  - pernas AFUNILADAS (20 na base -> 10 no topo): o ponto fraco de uma L
//    aberta é a TORÇÃO quando o dedo empurra a ponta de uma perna (braço =
//    comprimento da perna). Com perna reta de 20 a ponta gira ~1.5mm com 5N;
//    afunilada, ~0.55mm, e a base larga mantém a flexão baixa;
//  - miolo do canto preenchido por dentro (filete r=2.5) e pé do pilar com
//    concordância r=4 no chão, por fora;
//  - chão com quadro perimetral SÓLIDO de 6mm (segura os pilares entre si).
// Ponta de cada pilar com chanfro de entrada por dentro pra guiar o deck.
// Por que basket_style e não uma part nova: o render do deckbox-01 manda
// qualquer part desconhecida pro preview "both" (bandeja + capa + cestinha),
// e o deckbox-01 não pode mudar.

/* [Cestinha de pilares - variante] */
basket_style     = "v2"; // "v2" (colmeia, a padrão) | "pillars" (só pilares em L nos cantos)
pillar_leg_base  = 20;   // mm, perna da L no chão, medida pela face externa (lado curto fica com 72-2x20 = 32 aberto)
pillar_leg_top   = 10;   // mm, perna da L no topo (afunila: corta a torção na ponta)
pillar_fillet_r  = 2.5;  // mm, preenchimento interno do canto (filete vertical); ver pillar_sleeve_r_min
pillar_foot_r    = 4;    // mm, concordância pilar <-> chão, na face externa (sem canto vivo)
pillar_lead_w    = 0.8;  // mm, chanfro de entrada na ponta do pilar, por dentro (horizontal)
pillar_lead_h    = 2.5;  // mm, altura desse chanfro
floor_frame_w    = 6;    // mm, quadro sólido do chão medido da borda externa (sem hexágono)
pillar_test_force = 5;   // N, carga na ponta pra estimativa de deflexão
pla_E = 3000;            // MPa, módulo do PLA
pla_G = 1100;            // MPa, módulo de cisalhamento do PLA
sleeve_r_conservative = 2; // mm, raio de canto da sleeve assumido (carta ~3; conservador)

// Derivados
pl_H  = basket_h - basket_floor;                         // mm, balanço do pilar acima do chão
pl_leg = function (z) pillar_leg_base + (pillar_leg_top - pillar_leg_base) * z / pl_H;
pl_span_long  = [bk_l - 2 * pillar_leg_base, bk_l - 2 * pillar_leg_top]; // mm, vão aberto [base, topo]
pl_span_short = [bk_w - 2 * pillar_leg_base, bk_w - 2 * pillar_leg_top];
pl_d = min(bk_deck_side, bk_deck_side_w);
pl_sleeve_r_min = max(0, pillar_fillet_r - pl_d * sqrt(2) / (sqrt(2) - 1)); // canto da sleeve mínimo
// folga do filete ao canto de uma sleeve de raio r_s (centros a sqrt2*(r_f - r_s - d))
pl_corner_gap = (pillar_fillet_r - sleeve_r_conservative)
              - sqrt(2) * max(0, pillar_fillet_r - sleeve_r_conservative - pl_d);
pl_corner_diag = (basket_wall_v2 + pillar_fillet_r * (1 - 1/sqrt(2))
                  - basket_corner_r * (1 - 1/sqrt(2))) * sqrt(2);
// Seção L (pernas a, espessura t): [Ix, Iy, Ixy] no centróide
function l_sec(a, t) = let(
    r = [[0, 0, a, t], [0, t, t, a - t]],
    A = r[0][2]*r[0][3] + r[1][2]*r[1][3],
    cx = (r[0][2]*r[0][3]*(r[0][0]+r[0][2]/2) + r[1][2]*r[1][3]*(r[1][0]+r[1][2]/2)) / A,
    cy = (r[0][2]*r[0][3]*(r[0][1]+r[0][3]/2) + r[1][2]*r[1][3]*(r[1][1]+r[1][3]/2)) / A,
    Ix = [for (q = r) q[2]*pow(q[3],3)/12 + q[2]*q[3]*pow(q[1]+q[3]/2-cy, 2)],
    Iy = [for (q = r) q[3]*pow(q[2],3)/12 + q[2]*q[3]*pow(q[0]+q[2]/2-cx, 2)],
    Ixy = [for (q = r) q[2]*q[3]*(q[0]+q[2]/2-cx)*(q[1]+q[3]/2-cy)]
  ) [Ix[0]+Ix[1], Iy[0]+Iy[1], Ixy[0]+Ixy[1]];
pl_n = 96;
// flexão (área de momentos, base engastada): carga na ponta em X (= Y, simétrico) e na diagonal fraca
pl_bend = [for (k = [0 : pl_n - 1]) let(
    z = (k + 0.5) * pl_H / pl_n, I = l_sec(pl_leg(z), basket_wall_v2),
    det = I[0]*I[1] - I[2]*I[2],
    Imin = (I[0]+I[1])/2 - sqrt(pow((I[0]-I[1])/2, 2) + I[2]*I[2]),
    m = pillar_test_force * pow(pl_H - z, 2) * (pl_H / pl_n) / pla_E)
    [m * sqrt(I[0]*I[0] + I[2]*I[2]) / det, m / Imin, m / (pl_leg(z) * pow(basket_wall_v2, 3) / 12)]];
pl_defl_xy    = sum_col(pl_bend, 0); // mm, ponta, carga 5N em X ou Y
pl_defl_diag  = sum_col(pl_bend, 1); // mm, ponta, carga 5N no eixo fraco (diagonal)
pl_defl_plate = sum_col(pl_bend, 2); // mm, mesma carga numa perna isolada de 1.6 (sem a L)
// torção: 5N na borda da perna a uma altura z (braço = perna - t/2 até o centro de cisalhamento)
pl_twist = [for (zi = [1 : 48]) let(z = zi * pl_H / 48,
    th = sum_v([for (k = [0 : 47]) let(zz = (k + 0.5) * z / 48)
         (z / 48) / (pla_G * (2 * pl_leg(zz) - basket_wall_v2) * pow(basket_wall_v2, 3) / 3)]),
    arm = pl_leg(z) - basket_wall_v2 / 2) pillar_test_force * arm * arm * th];
pl_twist_worst = max(pl_twist);
pl_twist_straight = let(a = pillar_leg_base - basket_wall_v2 / 2)
    pillar_test_force * a * a * pl_H / (pla_G * (2 * pillar_leg_base - basket_wall_v2) * pow(basket_wall_v2, 3) / 3);
function sum_v(v, i = 0) = i >= len(v) ? 0 : v[i] + sum_v(v, i + 1);
function sum_col(m, c) = sum_v([for (r = m) r[c]]);
pl_hex_off = floor_frame_w - hex_margin; // mm, recuo da colmeia do chão (hex_panel tem hex_margin interno)
assert(pl_span_short[0] >= 30, "vão do lado curto < 30mm: não cabem os dedos");
assert(pl_sleeve_r_min <= 1.5, "filete exige sleeve com canto redondo demais");
assert(pl_corner_gap > 0.1);
assert(pl_defl_xy <= 0.5 && pl_defl_diag <= 0.5, "pilar mole em flexão");
assert(pillar_leg_top > basket_wall_v2 + pillar_fillet_r + 2);
assert(floor_frame_w >= basket_wall_v2 + pillar_fillet_r + 1, "quadro do chão tem que cobrir o pé do pilar");
echo(basket_style=basket_style, pillars_mm=[bk_l, bk_w, basket_h], pillar_leg_mm=[pillar_leg_base, pillar_leg_top],
     open_span_long_mm=pl_span_long, open_span_short_mm=pl_span_short,
     deck_per_side_mm=[bk_deck_side, bk_deck_side_w], sleeve_corner_r_min_mm=pl_sleeve_r_min,
     corner_gap_mm_at_sleeve_r2=pl_corner_gap, corner_diag_mm=pl_corner_diag,
     defl_5N_xy_mm=pl_defl_xy, defl_5N_diag_mm=pl_defl_diag, defl_5N_single_leg_mm=pl_defl_plate,
     twist_5N_leg_edge_worst_mm=pl_twist_worst, twist_5N_straight_leg_mm=pl_twist_straight,
     floor_frame_mm=floor_frame_w);

// Perfil de uma lateral no plano da parede (u ao longo, v = altura):
// chão + dois pilares afunilados, concordância r=pillar_foot_r no pé.
module pillar_side_profile(len) {
    intersection() {
        offset(r = -pillar_foot_r) offset(delta = pillar_foot_r) union() {
            translate([-pillar_foot_r, -pillar_foot_r]) square([len + 2 * pillar_foot_r, basket_floor + pillar_foot_r]);
            for (m = [0, 1]) translate([m * len, 0]) mirror([m, 0])
                polygon([[-pillar_foot_r, -pillar_foot_r], [pillar_leg_base, -pillar_foot_r],
                         [pillar_leg_base, basket_floor], [pillar_leg_top, basket_h],
                         [pillar_leg_top, basket_h + pillar_foot_r],
                         [-pillar_foot_r, basket_h + pillar_foot_r]]);
        }
        square([len, basket_h]);
    }
}

module basket_pillars() {
    c = basket_chamfer;
    dep = basket_wall_v2 + pillar_fillet_r + 1.5; // mm, profundidade da faixa de cada lateral
    difference() {
        intersection() {
            hull() {
                translate([c, c, 0]) linear_extrude(0.01) rrect(bk_l - 2 * c, bk_w - 2 * c, basket_corner_r - c);
                translate([0, 0, c]) linear_extrude(basket_h - c) rrect(bk_l, bk_w, basket_corner_r);
            }
            union() {
                translate([-1, -1, -1]) cube([bk_l + 2, bk_w + 2, basket_floor + 1]);
                for (y = [dep, bk_w + 1])
                    translate([0, y, 0]) rotate([90, 0, 0]) linear_extrude(dep + 1) pillar_side_profile(bk_l);
                for (x = [-1, bk_l - dep])
                    translate([x, 0, 0]) rotate([90, 0, 90]) linear_extrude(dep + 1) pillar_side_profile(bk_w);
            }
        }
        // cavidade com o miolo do canto preenchido (filete)
        translate([basket_wall_v2, basket_wall_v2, basket_floor])
            linear_extrude(basket_h) rrect(bk_in_l, bk_in_w, pillar_fillet_r);
        // chanfro de entrada na ponta dos pilares, por dentro
        hull() {
            translate([basket_wall_v2, basket_wall_v2, basket_h - pillar_lead_h])
                linear_extrude(0.01) rrect(bk_in_l, bk_in_w, pillar_fillet_r);
            translate([basket_wall_v2 - pillar_lead_w, basket_wall_v2 - pillar_lead_w, basket_h])
                linear_extrude(0.01) rrect(bk_in_l + 2 * pillar_lead_w, bk_in_w + 2 * pillar_lead_w,
                                           pillar_fillet_r + pillar_lead_w);
        }
        // chão: colmeia de 8mm dentro do quadro sólido
        translate([pl_hex_off, pl_hex_off, 0])
            hex_panel(bk_l - 2 * pl_hex_off, bk_w - 2 * pl_hex_off, basket_floor);
    }
}
