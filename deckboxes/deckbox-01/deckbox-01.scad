// deckbox-01.scad
// Deckbox estilo caixa de fósforo (matchbox), com 3 compartimentos na
// bandeja: dois lado a lado pra decks de 60 cartas (sleeved) DEITADAS
// (empilhadas horizontalmente, não em pé), e um terceiro abaixo dos dois
// (ocupando toda a largura) pra dados/moedas. Sulcos nas laterais dos
// compartimentos de deck pra pinçar e tirar o deck com facilidade.
//
// A bandeja desliza dentro de uma caixa externa fechada em UMA ponta (a
// outra fica aberta, por onde a bandeja entra) — como uma gaveta na capa.
// Fechamento por 4 ímãs (um em cada canto) na ponta da bandeja, espelhados
// por outros 4 na tampa da caixa — quando a bandeja é empurrada até o fim,
// os ímãs se encostam e travam por atração. Um furo passante no fundo da
// capa deixa empurrar a bandeja de volta pra fora com o dedo.
//
// Peças: "tray" (bandeja) e "sleeve" (caixa externa). Exportar separado:
//   openscad -o stl/deckbox-01-tray.stl   -D 'part="tray"'   deckbox-01.scad
//   openscad -o stl/deckbox-01-sleeve.stl -D 'part="sleeve"' deckbox-01.scad

/* [Peça a renderizar] */
part = "both"; // "tray" | "sleeve" | "both" (preview lado a lado, não montado)

/* [Cartas - deitadas, empilhadas na vertical] */
card_width             = 63; // mm, largura da carta (standard TCG)
card_height             = 88; // mm, altura da carta (standard TCG) — vira a profundidade do compartimento
card_count              = 60; // cartas por deck (com sleeve) — um compartimento por deck
sleeved_card_thickness  = 0.8; // mm por carta já com sleeve — confirmar com a sleeve real

/* [Compartimento de dados/moedas] */
dice_length = 30; // mm, profundidade do compartimento (largura = a dos dois decks juntos)

/* [Sulco pra pegar o deck] */
notch_radius = 10; // mm, raio do entalhe nas laterais de cada compartimento de deck

/* [Folgas] */
card_gap      = 2;    // folga extra em largura/profundidade pra carta não ficar apertada
deck_slack    = 6;    // espaço extra na altura da pilha (Z) pra facilitar tirar/guardar as cartas
fit_tolerance = 0.25; // folga por lado entre bandeja e caixa, pra deslizar sem travar
pull_tab      = 15;   // mm da bandeja que fica pra fora da caixa quando fechada, pra puxar

/* [Paredes] */
wall     = 1.6; // paredes externas (laterais/fundo/tubo)
end_wall = 3;   // paredes das pontas fechadas, onde ficam os ímãs — mais grossa que wall
divider  = 1.6; // parede interna entre os 3 compartimentos

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
tray_inner_h = deck_stack_height + deck_slack; // Z: altura da pilha de cartas deitadas + folga
// comprimento interno total: compartimento de dados + divisória + zona dos decks
tray_inner_l = dice_length + divider + lane_inner_l;

tray_outer_w = tray_inner_w + 2 * wall;
tray_outer_h = tray_inner_h + 2 * wall;
tray_outer_l = tray_inner_l + 2 * end_wall; // fechada nas duas pontas, aberta só em cima

sleeve_cavity_w = tray_outer_w + 2 * fit_tolerance;
sleeve_cavity_h = tray_outer_h + 2 * fit_tolerance;
sleeve_cavity_l = tray_outer_l - pull_tab; // profundidade da caixa externa

sleeve_outer_w = sleeve_cavity_w + 2 * wall;
sleeve_outer_h = sleeve_cavity_h + 2 * wall;
sleeve_outer_l = sleeve_cavity_l + end_wall; // + a ponta fechada (tampa)

// ---------------------------------------------------------------------
// Bandeja (tray): fundo + 4 paredes fechadas, aberta só em cima, com 3
// compartimentos internos.
// A ponta em x=0 é a que entra primeiro na caixa e carrega os 4 ímãs de
// canto. Nessa ponta fica o compartimento de dados/moedas (mais fundo, só
// aparece quando a bandeja é puxada quase até o fim); os dois
// compartimentos de deck ficam do lado do pull_tab (aparecem primeiro ao
// puxar a bandeja), cada um com um sulco de cada lado pra pinçar e tirar
// o deck (as cartas ficam deitadas, empilhadas de baixo pra cima).
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

        // sulcos pra pegar o deck com facilidade (um de cada lado de cada compartimento;
        // o do meio fica na divisória, então serve os dois compartimentos de uma vez)
        thumb_notch(notch_x, 0, wall);                      // parede externa esquerda
        thumb_notch(notch_x, wall + lane_inner_w, divider);  // divisória entre os dois decks
        thumb_notch(notch_x, tray_outer_w - wall, wall);     // parede externa direita

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

// Sulco arredondado no topo de uma parede (em x, começando em y0, ao longo de
// `thickness`), pra abrir espaço pro dedo pinçar o deck por baixo do topo.
module thumb_notch(x, y0, thickness) {
    translate([x, y0 - 0.1, tray_outer_h])
        rotate([-90, 0, 0])
            cylinder(r = notch_radius, h = thickness + 0.2);
}

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
if (part == "tray") {
    tray();
} else if (part == "sleeve") {
    sleeve();
} else {
    // preview lado a lado (não montado), só pra visualizar as duas peças
    tray();
    translate([0, tray_outer_w + 20, 0])
        sleeve();
}
