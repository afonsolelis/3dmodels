// deckbox-01.scad
// Deckbox estilo caixa de fósforo (matchbox), com 3 compartimentos na
// bandeja: dois lado a lado pra decks de 60 cartas (sleeved) DEITADAS
// (empilhadas horizontalmente, não em pé), e um terceiro abaixo dos dois
// (ocupando toda a largura) pra dados/moedas. Cada compartimento de deck
// tem um elevador — uma plataforma solta com uma aba — pra levantar o
// deck inteiro pra fora, até a última carta.
//
// A bandeja desliza dentro de uma capa fechada em UMA ponta (a outra fica
// aberta, por onde a bandeja entra). Fechamento por 4 ímãs (um em cada
// canto) na ponta da bandeja, espelhados por outros 4 na tampa da capa —
// quando a bandeja é empurrada até o fim, os ímãs se encostam e travam por
// atração. Um furo passante no fundo da capa deixa empurrar a bandeja de
// volta pra fora com o dedo.
//
// Peças: "tray" (bandeja), "sleeve" (capa) e "lifter" (elevador — imprimir
// 2, um por compartimento de deck; a mesma peça serve nos dois lados, é só
// virar 180°). Exportar separado:
//   openscad -o stl/deckbox-01-tray.stl    -D 'part="tray"'    deckbox-01.scad
//   openscad -o stl/deckbox-01-sleeve.stl  -D 'part="sleeve"'  deckbox-01.scad
//   openscad -o stl/deckbox-01-lifter.stl  -D 'part="lifter"'  deckbox-01.scad

/* [Peça a renderizar] */
part = "both"; // "tray" | "sleeve" | "lifter" | "both" (preview lado a lado, não montado)

/* [Cartas - deitadas, empilhadas na vertical] */
card_width             = 63; // mm, largura da carta (standard TCG)
card_height             = 88; // mm, altura da carta (standard TCG) — vira a profundidade do compartimento
card_count              = 60; // cartas por deck (com sleeve) — um compartimento por deck
sleeved_card_thickness  = 0.8; // mm por carta já com sleeve — confirmar com a sleeve real

/* [Compartimento de dados/moedas] */
dice_length = 30; // mm, profundidade do compartimento (largura = a dos dois decks juntos)

/* [Elevador do deck - plataforma solta com aba] */
lifter_thickness = 1.6; // mm, espessura da plataforma e da aba
lifter_gap       = 0.3; // mm, folga ao redor da plataforma pra subir livre, sem travar
tab_width        = 12;  // mm, largura da aba (por onde você puxa)
tab_length       = 8;   // mm, quanto a aba sai pra fora da parede lateral
notch_w          = tab_width + 2; // mm, largura do vão na parede por onde a aba passa
notch_h          = 10;  // mm, altura do vão a partir do chão (espaço pro dedo pegar a aba)

/* [Folgas] */
card_gap      = 2;    // folga extra em largura/profundidade pra carta não ficar apertada
deck_slack    = 6;    // espaço extra na altura da pilha (Z) pra facilitar tirar/guardar as cartas
fit_tolerance = 0.25; // folga por lado entre bandeja e caixa, pra deslizar sem travar

/* [Paredes] */
wall      = 1.6; // paredes externas (laterais/fundo/tubo)
end_wall  = 4;   // parede da ponta com ímã — mais grossa que wall, só o suficiente pro rebaixo do ímã
back_wall = 2;  // parede de trás da bandeja (sólida) — é a aba que sempre fica pra fora da capa, pra puxar
divider   = 1.6; // parede interna entre os 3 compartimentos

/* [Ímãs 4x2mm - discos, um em cada canto] */
magnet_d      = 4;    // mm, diâmetro
magnet_h      = 2;    // mm, espessura
magnet_fit    = 0.15; // mm, folga de encaixe pressionado (press-fit; se ficar frouxo, um pingo de cola resolve)
magnet_margin = 10;   // mm, distância do centro de cada ímã até as bordas da ponta

/* [Furo pra empurrar a bandeja] */
finger_hole_d = 12; // mm, diâmetro do furo passante no fundo da capa

/* [Qualidade] */
$fn = 48;

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
deck_stack_height = card_count * sleeved_card_thickness; // altura da pilha de UM deck deitado (60 cartas)

lane_inner_w = card_width + card_gap;   // Y: largura interna de cada compartimento de deck
lane_inner_l = card_height + card_gap;  // X: profundidade de cada compartimento (altura da carta, deitada)

// largura interna total: os dois compartimentos de deck lado a lado + a divisória entre eles
tray_inner_w = 2 * lane_inner_w + divider;
// Z: elevador embaixo + altura da pilha de cartas deitadas + folga
tray_inner_h = lifter_thickness + deck_stack_height + deck_slack;
// comprimento interno total: compartimento de dados + divisória + zona dos decks
tray_inner_l = dice_length + divider + lane_inner_l;

tray_outer_w = tray_inner_w + 2 * wall;
tray_outer_h = tray_inner_h + 2 * wall;
tray_outer_l = tray_inner_l + end_wall + back_wall; // ponta do ímã de um lado, aba de puxar sólida do outro

sleeve_cavity_w = tray_outer_w + 2 * fit_tolerance;
sleeve_cavity_h = tray_outer_h + 2 * fit_tolerance;
// a capa cobre TUDO até o começo da parede de trás da bandeja (nada de compartimento
// fica exposto quando fechada — só a parede sólida `back_wall` fica de fora)
sleeve_cavity_l = tray_inner_l + end_wall;

sleeve_outer_w = sleeve_cavity_w + 2 * wall;
sleeve_outer_h = sleeve_cavity_h + 2 * wall;
sleeve_outer_l = sleeve_cavity_l + end_wall; // + a ponta fechada (tampa)

// ---------------------------------------------------------------------
// Bandeja (tray): fundo + 4 paredes fechadas, aberta só em cima, com 3
// compartimentos internos.
// A ponta em x=0 é a que entra primeiro na caixa e carrega os 4 ímãs de
// canto. Nessa ponta fica o compartimento de dados/moedas (mais fundo, só
// aparece quando a bandeja é puxada quase até o fim); os dois
// compartimentos de deck ficam do lado da parede de trás — `back_wall` —
// (aparecem primeiro ao puxar a bandeja). Cada compartimento de deck tem
// um vão pequeno perto do chão, na parede externa, por onde passa a aba
// do elevador (as cartas ficam deitadas, empilhadas em cima do elevador).
// ---------------------------------------------------------------------
module tray() {
    lanes_x = end_wall + dice_length + divider;
    notch_x = lanes_x + lane_inner_l / 2; // centralizado no comprimento de cada compartimento de deck

    difference() {
        cube([tray_outer_l, tray_outer_w, tray_outer_h]);

        // compartimento de dados/moedas — ocupa toda a largura
        translate([end_wall, wall, wall])
            cube([dice_length, tray_inner_w, tray_outer_h]); // sobe além do topo -> topo aberto

        // dois compartimentos de deck, lado a lado, separados por `divider`
        translate([lanes_x, wall, wall])
            cube([lane_inner_l, lane_inner_w, tray_outer_h]);
        translate([lanes_x, wall + lane_inner_w + divider, wall])
            cube([lane_inner_l, lane_inner_w, tray_outer_h]);

        // vão pequeno em cada parede externa, por onde passa a aba do elevador
        grab_notch(notch_x, 0, wall);                  // parede externa esquerda
        grab_notch(notch_x, tray_outer_w - wall, wall); // parede externa direita

        // 4 ímãs de canto na ponta (precisa estar dentro do difference() pra CAVAR, não somar)
        magnet_corners(x = 0, w = tray_outer_w, h = tray_outer_h, dir = 1);
    }
}

// ---------------------------------------------------------------------
// Caixa externa (sleeve): tubo com a ponta em x=0 fechada e a outra aberta,
// por onde a bandeja entra. 4 ímãs de canto na ponta fechada, virados pra
// dentro (espelhando os da bandeja), e um furo passante no meio pra
// empurrar a bandeja de volta com o dedo.
// ---------------------------------------------------------------------
module sleeve() {
    difference() {
        cube([sleeve_outer_l, sleeve_outer_w, sleeve_outer_h]);
        translate([end_wall, wall, wall])
            cube([sleeve_outer_l, sleeve_cavity_w, sleeve_cavity_h]); // sobe além da frente -> frente aberta
        finger_hole();

        // 4 ímãs de canto na tampa (precisa estar dentro do difference() pra CAVAR, não somar)
        magnet_corners(x = end_wall, w = sleeve_outer_w, h = sleeve_outer_h, dir = -1);
    }
}

// Rebaixo cilíndrico pra UM ímã, em (x, y, z).
// dir = 1  -> cava a partir de x pra dentro (+X)  [usado na bandeja]
// dir = -1 -> cava a partir de x pra fora (-X)     [usado na caixa]
module magnet_hole(x, y, z, dir) {
    translate([x, y, z])
        rotate([0, dir * 90, 0])
            cylinder(h = magnet_h + 0.01, d = magnet_d + magnet_fit);
}

// 4 ímãs, um em cada canto de uma parede de ponta (w x h), a `magnet_margin`
// das bordas.
module magnet_corners(x, w, h, dir) {
    for (yy = [magnet_margin, w - magnet_margin])
        for (zz = [magnet_margin, h - magnet_margin])
            magnet_hole(x, yy, zz, dir);
}

// Furo passante centralizado no fundo da capa (sleeve), pra empurrar a
// bandeja de volta pra fora com o dedo.
module finger_hole() {
    translate([-0.1, sleeve_outer_w / 2, sleeve_outer_h / 2])
        rotate([0, 90, 0])
            cylinder(h = end_wall + 0.2, d = finger_hole_d);
}

// Vão pequeno numa parede (em x, começando em y0, ao longo de `thickness`),
// rente ao chão da bandeja — só o suficiente pra aba do elevador passar e
// pro dedo alcançar e puxar.
module grab_notch(x, y0, thickness) {
    translate([x - notch_w / 2, y0 - 0.1, wall])
        cube([notch_w, thickness + 0.2, notch_h]);
}

// ---------------------------------------------------------------------
// Elevador (lifter): plataforma solta que fica no chão de um compartimento
// de deck, embaixo das cartas, com uma aba que sai pela parede (pelo
// grab_notch) pra você puxar e levantar o deck inteiro de uma vez, até a
// última carta. A mesma peça serve nos dois compartimentos — só virar 180°.
// Aba sai pelo lado y=0 (visto de cima).
// ---------------------------------------------------------------------
module lifter() {
    platform_l = lane_inner_l - 2 * lifter_gap;
    platform_w = lane_inner_w - 2 * lifter_gap;

    // plataforma
    translate([lifter_gap, lifter_gap, 0])
        cube([platform_l, platform_w, lifter_thickness]);

    // aba, centralizada no comprimento, saindo pelo lado y=0 (sobrepõe um
    // pouco a plataforma, em vez de só encostar, pra garantir união sólida)
    translate([lane_inner_l / 2 - tab_width / 2, -tab_length, 0])
        cube([tab_width, tab_length + lifter_gap + 0.2, lifter_thickness]);
}

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
if (part == "tray") {
    tray();
} else if (part == "sleeve") {
    sleeve();
} else if (part == "lifter") {
    lifter();
} else {
    // preview lado a lado (não montado), só pra visualizar as três peças
    tray();
    translate([0, tray_outer_w + 20, 0])
        sleeve();
    translate([0, tray_outer_w + sleeve_outer_w + 40, 0])
        lifter();
}
