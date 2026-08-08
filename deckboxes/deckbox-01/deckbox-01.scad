// deckbox-01.scad
// Deckbox estilo caixa de fósforo (matchbox): a bandeja com as cartas desliza
// dentro de uma caixa externa fechada em UMA ponta (a outra fica aberta, por
// onde a bandeja entra). Fechamento por ímã: um rebaixo na ponta da bandeja
// e outro na tampa da caixa, virados um pro outro — quando a bandeja é
// empurrada até o fim, os ímãs se encostam e travam por atração.
//
// Peças: "tray" (bandeja) e "sleeve" (caixa externa). Exportar separado:
//   openscad -o stl/deckbox-01-tray.stl   -D 'part="tray"'   deckbox-01.scad
//   openscad -o stl/deckbox-01-sleeve.stl -D 'part="sleeve"' deckbox-01.scad

/* [Peça a renderizar] */
part = "both"; // "tray" | "sleeve" | "both" (preview lado a lado, não montado)

/* [Cartas] */
card_width            = 63;  // mm, largura da carta (standard TCG)
card_height           = 88;  // mm, altura da carta (standard TCG)
card_count            = 80;  // quantidade de cartas — ajustar pro número exato do seu deck (~60-100)
sleeved_card_thickness = 0.8; // mm por carta já com sleeve — confirmar com a sleeve real

/* [Folgas] */
card_gap      = 2;    // folga extra em largura/altura pras cartas não ficarem apertadas
deck_slack    = 6;    // espaço extra no comprimento pra facilitar tirar/guardar as cartas
fit_tolerance = 0.25; // folga por lado entre bandeja e caixa, pra deslizar sem travar
pull_tab      = 15;   // mm da bandeja que fica pra fora da caixa quando fechada, pra puxar

/* [Paredes] */
wall     = 1.6; // paredes das laterais/fundo (tubo)
end_wall = 3;   // paredes das pontas fechadas, onde ficam os ímãs — mais grossa que wall

/* [Ímã 4x2mm - disco] */
magnet_d   = 4;    // mm, diâmetro
magnet_h   = 2;    // mm, espessura
magnet_fit = 0.15; // mm, folga de encaixe pressionado (press-fit; se ficar frouxo, um pingo de cola resolve)

/* [Qualidade] */
$fn = 48;

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
deck_length = card_count * sleeved_card_thickness;

tray_inner_w = card_width + card_gap;
tray_inner_h = card_height + card_gap;
tray_inner_l = deck_length + deck_slack;

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
// Bandeja (tray): fundo + 4 paredes fechadas, aberta só em cima.
// A ponta em x=0 é a que entra primeiro na caixa e carrega o ímã.
// ---------------------------------------------------------------------
module tray() {
    difference() {
        cube([tray_outer_l, tray_outer_w, tray_outer_h]);
        translate([end_wall, wall, wall])
            cube([tray_inner_l, tray_inner_w, tray_outer_h]); // sobe além do topo -> topo aberto
    }
    magnet_pocket(x = 0, w = tray_outer_w, h = tray_outer_h, dir = 1);
}

// ---------------------------------------------------------------------
// Caixa externa (sleeve): tubo com a ponta em x=0 fechada e a outra aberta,
// por onde a bandeja entra. Ímã na ponta fechada, virado pra dentro.
// ---------------------------------------------------------------------
module sleeve() {
    difference() {
        cube([sleeve_outer_l, sleeve_outer_w, sleeve_outer_h]);
        translate([end_wall, wall, wall])
            cube([sleeve_outer_l, sleeve_cavity_w, sleeve_cavity_h]); // sobe além da frente -> frente aberta
    }
    magnet_pocket(x = end_wall, w = sleeve_outer_w, h = sleeve_outer_h, dir = -1);
}

// Rebaixo cilíndrico pro ímã, centralizado numa parede de ponta (end_wall).
// dir = 1  -> cava a partir de x pra dentro (+X)  [usado na bandeja]
// dir = -1 -> cava a partir de x pra fora (-X)     [usado na caixa]
module magnet_pocket(x, w, h, dir) {
    translate([x, w / 2, h / 2])
        rotate([0, dir * 90, 0])
            cylinder(h = magnet_h + 0.01, d = magnet_d + magnet_fit);
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
