// deckbox-01.scad
// Deckbox paramétrica — placeholder inicial, dimensões ainda a definir.
//
// Renderizar/exportar:
//   openscad -o stl/deckbox-01.stl deckbox-01.scad

/* [Cartas] */
card_width      = 63;   // mm, largura da carta (63mm = standard TCG)
card_height     = 88;   // mm, altura da carta
card_count      = 60;   // quantidade de cartas que a caixa precisa comportar
card_thickness  = 0.5;  // mm, espessura média por carta (com sleeve costuma ser ~0.6-0.7)

/* [Parede e tolerância] */
wall            = 2.0;  // mm, espessura da parede
fit_tolerance   = 0.3;  // mm, folga de encaixe (tampa/gaveta)

/* [Derivados] */
deck_length = card_count * card_thickness;

box_width  = card_width  + 2 * wall;
box_height = card_height + 2 * wall;
box_length = deck_length + 2 * wall;

// Placeholder: bandeja simples (fundo fechado, topo aberto), sem tampa ainda.
// Vamos evoluir isso juntos: tampa, encaixe, tolerância, divisórias, etc.
module shell() {
    difference() {
        cube([box_length, box_width, box_height]);
        translate([wall, wall, wall])
            cube([box_length - 2 * wall, box_width - 2 * wall, box_height]); // sobe até passar do topo -> topo aberto
    }
}

shell();
