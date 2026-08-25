// pokemon-coin-binder-01.scad
// Insert em formato de carta para guardar uma moeda Pokemon grande em uma
// pagina plastica 3x3 de fichario. A moeda e o insert ficam lado a lado no
// mesmo plano: a folha plastica segura as duas faces, e o aro apenas centra a
// moeda e preenche o restante do bolso.
//
// Medida real fornecida pelo usuario em 2026-08-23:
//   moeda = diametro 51.4 mm x espessura 2.7 mm
//
// Exports canonicos (usar caminhos absolutos nesta maquina):
//   flatpak run org.openscad.OpenSCAD -o stl/pokemon-coin-binder-01.stl \
//     -D 'part="holder"' pokemon-coin-binder-01.scad
//   flatpak run org.openscad.OpenSCAD -o 3mf/pokemon-coin-binder-01.3mf \
//     -D 'part="holder"' pokemon-coin-binder-01.scad
//   flatpak run org.openscad.OpenSCAD -o 3mf/pokemon-coin-binder-01-x3.3mf \
//     -D 'part="plate3"' pokemon-coin-binder-01.scad

/* [Peca a renderizar] */
part = "holder"; // "holder" (1 insert) | "plate3" (3 inserts na A1 mini)

/* [Moeda - medida real] */
coin_d = 51.4;       // mm, diametro medido pelo usuario
coin_t = 2.7;        // mm, documentacao; nao soma na altura do insert
radial_clear = 0.20; // mm por lado: abertura central = 51.8 mm

/* [Insert formato carta Pokemon] */
card_w = 63;       // mm
card_h = 88;       // mm
holder_t = 2.0;    // mm; a moeda sobressai 0.35 mm de cada face
corner_r = 4.0;    // mm

/* [Acabamento da abertura] */
edge_chamfer = 0.5; // mm em cada face, facilita alinhar moeda + insert na folha

/* [Chapa de impressao] */
plate_gap = 2.0; // mm entre inserts; plate3 = 153 x 128 mm

/* [Qualidade] */
$fn = 128;
eps = 0.02;

// --------------------------------------------------------------------------
// Derivados e guardas
// --------------------------------------------------------------------------
opening_d = coin_d + 2 * radial_clear;
surface_opening_d = opening_d + 2 * edge_chamfer;
rim_min = min(card_w, card_h) / 2 - surface_opening_d / 2;

plate_w = card_w + plate_gap + card_h;
plate_h = 2 * card_w + plate_gap;

assert(holder_t > 2 * edge_chamfer,
       "holder_t precisa ser maior que duas vezes edge_chamfer");
assert(corner_r > 0 && corner_r <= min(card_w, card_h) / 2,
       "corner_r invalido");
assert(rim_min >= 4.5,
       "Aro lateral ficou estreito demais para uma pagina de fichario");

echo(str("pokemon-coin-binder-01: moeda Ø", coin_d, " x ", coin_t, " mm"));
echo(str("  insert ", card_w, " x ", card_h, " x ", holder_t,
         " mm | abertura Ø", opening_d, " mm | folga radial ", radial_clear, " mm"));
echo(str("  aro minimo ", rim_min, " mm | plate3 ", plate_w, " x ", plate_h,
         " x ", holder_t, " mm"));

// --------------------------------------------------------------------------
// Geometria
// --------------------------------------------------------------------------
module rounded_card_2d() {
    offset(r = corner_r)
        square([card_w - 2 * corner_r, card_h - 2 * corner_r], center = true);
}

// A garganta cilindrica tem Ø51.8. Os 0.5 mm de cada face abrem em 45 graus
// ate Ø52.8 para eliminar aresta viva e guiar a moeda. A abertura e maior que
// a moeda de proposito: este NAO e um snap-fit; a pagina plastica e que retem.
module coin_opening() {
    union() {
        translate([0, 0, -eps])
            cylinder(h = edge_chamfer + eps,
                     d1 = surface_opening_d + 2 * eps,
                     d2 = opening_d);

        translate([0, 0, edge_chamfer - eps])
            cylinder(h = holder_t - 2 * edge_chamfer + 2 * eps,
                     d = opening_d);

        translate([0, 0, holder_t - edge_chamfer])
            cylinder(h = edge_chamfer + eps,
                     d1 = opening_d,
                     d2 = surface_opening_d + 2 * eps);
    }
}

module holder() {
    difference() {
        linear_extrude(height = holder_t)
            rounded_card_2d();
        coin_opening();
    }
}

// Packing assimetrico para manter tudo dentro do limite confortavel de
// 170x170 da A1 mini: um insert retrato a esquerda e dois paisagem a direita.
module plate3() {
    translate([-plate_w / 2, -plate_h / 2, 0]) {
        translate([card_w / 2, plate_h / 2, 0])
            holder();

        for (y = [card_w / 2, card_w + plate_gap + card_w / 2])
            translate([card_w + plate_gap + card_h / 2, y, 0])
                rotate([0, 0, 90])
                    holder();
    }
}

if (part == "holder")
    holder();
else if (part == "plate3")
    plate3();
else
    assert(false, str("part desconhecido: ", part));
