// xadrez-01.scad
// Xadrez compacto completo, desenhado para sair em UMA unica placa da
// Creality K2 (260 x 260 mm): tabuleiro central + 32 pecas em quatro fileiras.
// A geometria e dividida em apenas dois corpos de cor:
//   COR 1 = tabuleiro claro + 16 pecas claras
//   COR 2 = 32 casas escuras + 16 pecas escuras
//
// O arquivo 3MF final e montado a partir dos dois STLs de cor, preservando os
// dois materiais como objetos separados. As pecas individuais tambem podem
// ser exportadas para reposicao.
//
// Export canonico (usar caminhos absolutos nesta maquina):
//   flatpak run org.openscad.OpenSCAD -o stl/xadrez-01-cor-1-clara.stl \
//     -D 'part="light"' xadrez-01.scad
//   flatpak run org.openscad.OpenSCAD -o stl/xadrez-01-cor-2-escura.stl \
//     -D 'part="dark"' xadrez-01.scad
//   python3 make_3mf.py
//
// Valores de part: plate, light, dark, board_light, board_dark,
// pawn, rook, knight, bishop, queen, king.

part = "plate";

/* [Tabuleiro] */
square_size = 20;       // lado de cada casa
frame_w = 4;            // moldura em volta das 8 x 8 casas
board_h = 3.6;          // espessura total acabada
dark_layer_h = 0.6;     // tres camadas a 0.20 mm
dark_square_gap = 0.4;  // filete claro entre casas, largura de um bico 0.4
board_corner_r = 3;

/* [Disposicao na placa] */
pawn_row_y = 95;
major_row_y = 116;
piece_pitch = 20;

/* [Qualidade] */
round_fn = 48;
detail_fn = 28;
preview_light = "#F2E8D5";
preview_dark = "#202124";
$fn = round_fn;

field_size = 8 * square_size;
board_size = field_size + 2 * frame_w;
dark_z = board_h - dark_layer_h;
max_piece_r = 8.1;
plate_x = board_size;
plate_y = 2 * (major_row_y + max_piece_r);
plate_z = 46;

assert(board_size == 168, "A grade deve continuar com 168 mm no total");
assert(plate_x <= 250 && plate_y <= 250,
       "A chapa ultrapassou o envelope seguro de 250 x 250 mm da K2");
assert(pawn_row_y - 6.8 > board_size / 2 + 4,
       "Os peoes ficaram perto demais do tabuleiro");
assert(major_row_y - pawn_row_y > 2 * max_piece_r + 3,
       "As fileiras de pecas ficaram perto demais");

echo(str("BOARD_MM=", board_size, "x", board_size, "x", board_h));
echo(str("PLATE_MM=", plate_x, "x", plate_y, "x", plate_z));
echo("CONTENTS=tabuleiro + 16 claras + 16 escuras; COLORS=2");

// --------------------------------------------------------------------------
// Utilitarios
// --------------------------------------------------------------------------

module rounded_square_2d(size, r) {
    offset(r = r)
        square([size - 2 * r, size - 2 * r], center = true);
}

module lathe(points, facets = round_fn) {
    rotate_extrude($fn = facets, convexity = 10)
        polygon(points = points);
}

// Extruda um perfil desenhado em XZ na espessura Y.
module xz_plate(points, thickness) {
    rotate([90, 0, 0])
        linear_extrude(height = thickness, center = true, convexity = 10)
            polygon(points = points);
}

module ellipsoid(p, radii, facets = detail_fn) {
    translate(p)
        scale(radii)
            sphere(r = 1, $fn = facets);
}

// --------------------------------------------------------------------------
// Tabuleiro: a cor clara e uma laje continua; a cor escura ocupa somente
// os 0.6 mm de cima. Isso deixa o tabuleiro rigido e limita as trocas de cor.
// --------------------------------------------------------------------------

module dark_cells(extra_h = 0) {
    cell = square_size - dark_square_gap;
    for (rank = [0 : 7])
        for (file = [0 : 7])
            if ((rank + file) % 2 == 0)
                translate([
                    -field_size / 2 + (file + 0.5) * square_size,
                    -field_size / 2 + (rank + 0.5) * square_size,
                    dark_z
                ])
                    linear_extrude(height = dark_layer_h + extra_h)
                        square([cell, cell], center = true);
}

module board_light() {
    difference() {
        linear_extrude(height = board_h)
            rounded_square_2d(board_size, board_corner_r);

        // +0.02 no alto evita pele coincidente depois do booleano. O fundo
        // permanece exatamente em dark_z, onde o insert escuro comeca.
        dark_cells(0.02);
    }
}

module board_dark() {
    dark_cells();
}

// --------------------------------------------------------------------------
// Pecas: familia Staunton simplificada. Todos os balancos planos ficam em
// ate 3 mm (coroa/cruz); o cavalo e um perfil autoportante de 6 mm.
// --------------------------------------------------------------------------

module pawn() {
    union() {
        lathe([
            [0, 0], [5.7, 0], [6.8, 0.8], [6.8, 1.8],
            [6.2, 2.8], [5.4, 4.2], [3.2, 5.4], [2.6, 11.7],
            [3.8, 14.0], [3.8, 15.3], [2.8, 17.2], [0, 17.2]
        ]);
        translate([0, 0, 20.5])
            sphere(r = 4.0, $fn = detail_fn);
    }
}

module rook() {
    difference() {
        lathe([
            [0, 0], [6.8, 0], [8.0, 0.8], [8.0, 2.0],
            [7.2, 3.2], [5.8, 4.7], [4.4, 6.0], [3.7, 18.8],
            [4.4, 21.0], [5.8, 22.0], [5.8, 28.8], [0, 28.8]
        ]);

        // Duas ranhuras cruzadas formam quatro merloes largos e resistentes.
        translate([0, 0, 26.4]) cube([3.0, 14, 5.0], center = true);
        translate([0, 0, 26.4]) cube([14, 3.0, 5.0], center = true);
    }
}

module knight(mirrored = false) {
    module horse() {
        difference() {
            union() {
                lathe([
                    [0, 0], [6.8, 0], [8.0, 0.8], [8.0, 2.0],
                    [7.2, 3.2], [5.7, 4.8], [5.2, 7.0], [5.4, 8.8],
                    [0, 8.8]
                ]);

                xz_plate([
                    [-4.5, 8.0], [4.5, 8.0], [3.7, 12.0],
                    [2.5, 16.0], [1.8, 20.0], [3.0, 23.0],
                    [5.2, 25.5], [5.5, 28.0], [3.4, 29.5],
                    [0.8, 30.0], [-0.2, 33.5], [-1.5, 31.5],
                    [-3.5, 31.0], [-4.8, 28.0], [-3.2, 25.0],
                    [-4.5, 21.0], [-5.0, 15.0]
                ], 6.0);
            }

            // Olho passante pequeno: fecha como ponte curta de 1.5 mm.
            translate([2.5, 0, 28.2])
                rotate([90, 0, 0])
                    cylinder(h = 7.0, r = 0.75, center = true,
                             $fn = 16);
        }
    }

    if (mirrored)
        mirror([1, 0, 0]) horse();
    else
        horse();
}

module bishop() {
    difference() {
        union() {
            lathe([
                [0, 0], [6.7, 0], [7.9, 0.8], [7.9, 2.0],
                [7.1, 3.2], [5.7, 4.7], [3.9, 6.4], [3.0, 18.5],
                [4.4, 21.5], [4.5, 23.0], [3.2, 25.4], [0, 25.4]
            ]);
            ellipsoid([0, 0, 29.6], [4.7, 4.7, 5.2]);
            translate([0, 0, 33.0])
                cylinder(h = 4.5, r1 = 2.4, r2 = 0.5,
                         $fn = detail_fn);
        }

        // Mitra diagonal, assinatura visual do bispo.
        translate([0, 0, 31.3])
            rotate([0, 35, 0])
                cube([1.45, 12, 10], center = true);
    }
}

module queen() {
    union() {
        lathe([
            [0, 0], [6.9, 0], [8.1, 0.8], [8.1, 2.0],
            [7.3, 3.2], [5.8, 4.8], [3.8, 6.5], [3.0, 20.0],
            [4.6, 23.0], [5.5, 25.0], [5.5, 28.3], [0, 28.3]
        ]);

        difference() {
            translate([0, 0, 27.9])
                cylinder(h = 6.8, r1 = 5.5, r2 = 4.7, $fn = detail_fn);

            // Seis recortes verticais: coroa legivel, sem pontas frageis.
            for (a = [0 : 60 : 300])
                rotate([0, 0, a])
                    translate([3.8, 0, 34.0])
                        cube([4.0, 1.8, 5.0], center = true);
        }

        // Joia central apoiada no fundo continuo da coroa.
        translate([0, 0, 35.2]) sphere(r = 1.9, $fn = detail_fn);
    }
}

module king() {
    union() {
        lathe([
            [0, 0], [6.9, 0], [8.1, 0.8], [8.1, 2.0],
            [7.3, 3.2], [5.8, 4.8], [3.8, 6.5], [3.0, 21.0],
            [4.6, 24.0], [5.2, 26.0], [5.2, 29.0],
            [3.3, 31.2], [0, 31.2]
        ]);
        translate([0, 0, 33.2]) sphere(r = 2.7, $fn = detail_fn);

        // Cruz extrudada em Y. Os bracos vencem apenas 2.9 mm por lado.
        xz_plate([
            [-1.6, 35.2], [1.6, 35.2], [1.6, 39.2],
            [4.5, 39.2], [4.5, 42.2], [1.6, 42.2],
            [1.6, 46.0], [-1.6, 46.0], [-1.6, 42.2],
            [-4.5, 42.2], [-4.5, 39.2], [-1.6, 39.2]
        ], 3.8);
    }
}

module major_piece(kind, mirrored_knight = false) {
    if (kind == 1) rook();
    else if (kind == 2) knight(mirrored_knight);
    else if (kind == 3) bishop();
    else if (kind == 4) queen();
    else if (kind == 5) king();
}

// As claras ficam em +Y e as escuras em -Y. Nesta vista fixa a ordem e
// torre, cavalo, bispo, rei, dama, bispo, cavalo, torre: assim as duas damas
// caem na mesma coluna e cada uma fica na casa da propria cor.
major_order = [1, 2, 3, 5, 4, 3, 2, 1];

module army(side = 1) {
    for (i = [0 : 7]) {
        x = (i - 3.5) * piece_pitch;

        translate([x, side * pawn_row_y, 0])
            rotate([0, 0, side < 0 ? 180 : 0])
                pawn();

        translate([x, side * major_row_y, 0])
            rotate([0, 0, side < 0 ? 180 : 0])
                major_piece(major_order[i], i == 6);
    }
}

module light_geometry() {
    board_light();
    army(1);
}

module dark_geometry() {
    board_dark();
    army(-1);
}

module plate_preview() {
    color(preview_light) light_geometry();
    color(preview_dark) dark_geometry();
}

// --------------------------------------------------------------------------
// Seletor de export
// --------------------------------------------------------------------------

if (part == "plate") plate_preview();
else if (part == "light") light_geometry();
else if (part == "dark") dark_geometry();
else if (part == "board_light") board_light();
else if (part == "board_dark") board_dark();
else if (part == "pawn") pawn();
else if (part == "rook") rook();
else if (part == "knight") knight();
else if (part == "bishop") bishop();
else if (part == "queen") queen();
else if (part == "king") king();
else assert(false, str("part desconhecido: ", part));
