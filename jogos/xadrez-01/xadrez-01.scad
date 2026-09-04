// xadrez-01.scad
// Xadrez compacto completo para a FlashForge AD5X (220 x 220 x 220 mm).
//
// COMO O USUARIO MANUSEIA: sao 33 objetos soltos. O tabuleiro sai da cama
// como uma laje unica de 168 mm que ele pega pelas bordas e apoia na mesa; as
// 32 pecas ele pega pelo corpo, com o polegar e o indicador acima da base, e
// planta a base chapada na casa de 20 mm. Nada encaixa, nada monta, nada
// precisa de cola: o "encaixe" e a gravidade.
//
// SAO TRES JOBS DE IMPRESSAO:
//   job 1  tabuleiro BICOLOR, deitado  (laje clara + 32 casas escuras)
//   job 2  16 pecas CLARAS em pe, arranjo 4 x 4
//   job 3  16 pecas ESCURAS em pe, arranjo 4 x 4  (mesma geometria do job 2)
//
// As pecas sairam do job bicolor unico em 2026-08-28: as 16 claras e as 16
// escuras sao solidos disjuntos, entao nao existe motivo geometrico pra elas
// dividirem chapa — e dividir chapa custava ~320 mm3 de purga em cada uma das
// 230 camadas (~89 g de purga pra ~44 g de peca), com as ultimas 43 camadas
// trocando de cor so pra imprimir as duas cruzes dos reis. O tabuleiro
// continua bicolor porque ali as casas PRECISAM nascer alinhadas com a laje.
//
// Export canonico (usar caminhos absolutos nesta maquina):
//   flatpak run org.openscad.OpenSCAD -o stl/xadrez-01-tabuleiro-claro.stl \
//     -D 'part="board_light"' xadrez-01.scad
//   flatpak run org.openscad.OpenSCAD -o stl/xadrez-01-tabuleiro-escuro.stl \
//     -D 'part="board_dark"' xadrez-01.scad
//   flatpak run org.openscad.OpenSCAD -o stl/xadrez-01-exercito.stl \
//     -D 'part="army"' xadrez-01.scad
//   python3 make_3mf.py
//
// PNG de conferencia (o flatpak precisa de X11 pra render offscreen; use
// --preview, porque --render passa pelo CGAL e descarta as cores):
//   flatpak run --env=DISPLAY=:0 --socket=x11 org.openscad.OpenSCAD \
//     -o <abs>/xadrez-01-preview.png --preview --camera=0,0,20,62,0,32,640 \
//     --imgsize=1600,1000 -D 'part="preview"' <abs>/xadrez-01.scad
//
// Valores de part:
//   preview      as tres chapas lado a lado, so pra olhar (NAO e job)
//   board_plate  job 1 colorido; army_plate  job 2/3 colorido
//   board_light, board_dark, army                (o que vira STL)
//   pawn, rook, knight, bishop, queen, king      (reposicao avulsa)

part = "preview";

/* [Tabuleiro] */
square_size = 20;       // mm, lado de cada casa jogavel
frame_w = 4;            // mm, moldura em volta das 8 x 8 casas
board_h = 3.6;          // mm, espessura total acabada da laje
dark_layer_h = 0.6;     // mm, insert escuro no topo (tres camadas a 0.20)
dark_square_gap = 0.4;  // mm, filete claro entre casas (largura de um bico)
board_corner_r = 3;     // mm, raio dos cantos da laje

/* [Base das pecas] */
// Cada peca assenta num flare conico. O chanfro e sempre a 45 graus da
// vertical (dr = dz), porque a 56 graus da versao anterior cada cordao das
// quatro primeiras camadas apoiava em so 29% da propria largura e caia.
pawn_foot_r = 5.7;      // mm, raio do disco que toca a cama (peao)
pawn_base_r = 6.8;      // mm, raio no topo do flare (peao)
major_foot_r = 6.8;     // mm, idem torre e cavalo
major_base_r = 8.0;     // mm
bishop_foot_r = 6.7;    // mm, idem bispo
bishop_base_r = 7.9;    // mm
royal_foot_r = 6.9;     // mm, idem dama e rei
royal_base_r = 8.1;     // mm

/* [Alturas de referencia] */
// Hierarquia Staunton: rei > dama > bispo > cavalo > torre > peao.
queen_h = 41.0;         // mm, topo da joia da dama
queen_jewel_r = 1.9;    // mm, raio da joia no centro da coroa
king_h = 46.0;          // mm, topo da cruz do rei

/* [Disposicao nas chapas] */
piece_pitch = 20;       // mm, centro a centro em X no arranjo 4 x 4
piece_row_pitch = 20;   // mm, centro a centro em Y no arranjo 4 x 4
min_base_gap = 3.8;     // mm, vao livre minimo exigido entre duas bases

/* [Qualidade] */
round_fn = 48;
detail_fn = 28;
preview_light = "#F2E8D5";
preview_dark = "#202124";
$fn = round_fn;

// --------------------------------------------------------------------------
// Derivados
// --------------------------------------------------------------------------

field_size = 8 * square_size;              // area jogavel 8 x 8
board_size = field_size + 2 * frame_w;     // laje acabada
dark_z = board_h - dark_layer_h;           // cota onde o insert escuro comeca

// Chanfro de base a 45 graus: o avanco radial e igual ao avanco em z.
function flare_z(foot_r, base_r) = base_r - foot_r;

// Codigos usados na grade do exercito.
PAWN = 0; ROOK = 1; KNIGHT = 2; BISHOP = 3; QUEEN = 4; KING = 5;

// Raio ocupado por cada tipo (sempre o topo do flare: nenhuma peca e mais
// larga que a propria base). Substitui a constante 8.1 escrita a mao.
function piece_r(kind) =
      kind == PAWN                  ? pawn_base_r
    : kind == BISHOP                ? bishop_base_r
    : (kind == QUEEN || kind == KING) ? royal_base_r
    :                                 major_base_r;

// Grade 4 x 4 de um exercito: peoes nas duas bordas em Y, figuras no miolo.
army_grid = [
    [PAWN,  PAWN,   PAWN,   PAWN ],
    [ROOK,  KNIGHT, BISHOP, QUEEN],
    [KING,  BISHOP, KNIGHT, ROOK ],
    [PAWN,  PAWN,   PAWN,   PAWN ]
];

function grid_col_r(c) = max([for (r = [0 : 3]) piece_r(army_grid[r][c])]);
function grid_row_r(r) = max([for (c = [0 : 3]) piece_r(army_grid[r][c])]);

// Envelope REAL do arranjo: quem ocupa a ponta e a peca daquela ponta, nao a
// mais larga da chapa. (Ate 2026-08-28 os echos usavam 8.1 nas quatro pontas
// e erravam 1.3 mm contra o bbox do STL.)
army_job_x = 3 * piece_pitch + grid_col_r(0) + grid_col_r(3);
army_job_y = 3 * piece_row_pitch + grid_row_r(0) + grid_row_r(3);
army_job_z = king_h;

// Vao livre entre bases vizinhas, par a par, nos dois eixos.
gaps_x = [for (r = [0 : 3], c = [0 : 2])
          piece_pitch - piece_r(army_grid[r][c]) - piece_r(army_grid[r][c + 1])];
gaps_y = [for (c = [0 : 3], r = [0 : 2])
          piece_row_pitch - piece_r(army_grid[r][c]) - piece_r(army_grid[r + 1][c])];

assert(dark_layer_h > 0 && dark_layer_h < board_h,
       "O insert escuro tem que caber dentro da espessura da laje");
assert(dark_square_gap > 0 && dark_square_gap < square_size / 2,
       "O filete claro entre casas ficou invalido");
assert(board_corner_r >= 0 && board_corner_r <= frame_w,
       "O raio de canto nao pode comer a moldura");
assert(board_size <= 210 && army_job_x <= 210 && army_job_y <= 210,
       "Um job ultrapassou o alvo confortavel de 210mm da AD5X");
assert(min(gaps_x) >= min_base_gap,
       "Duas bases vizinhas ficaram perto demais no eixo X");
assert(min(gaps_y) >= min_base_gap,
       "Duas bases vizinhas ficaram perto demais no eixo Y");
assert(king_h > queen_h && queen_h > 37.5,
       "A hierarquia Staunton exige rei > dama > bispo");

echo(str("BOARD_JOB_MM=", board_size, "x", board_size, "x", board_h));
echo(str("ARMY_JOB_MM=", army_job_x, "x", army_job_y, "x", army_job_z));
echo(str("MIN_BASE_GAP_MM=", min(min(gaps_x), min(gaps_y))));
echo(str("BASE_FLARE_DZ_MM=", flare_z(royal_foot_r, royal_base_r),
         " (45 graus)"));
echo("CONTENTS=job 1 tabuleiro bicolor; job 2 16 claras; job 3 16 escuras; COLORS=2");

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
// As bases comecam sempre com [foot_r, 0] -> [base_r, flare_z] = 45 graus.
// --------------------------------------------------------------------------

module pawn() {
    union() {
        lathe([
            [0, 0], [pawn_foot_r, 0],
            [pawn_base_r, flare_z(pawn_foot_r, pawn_base_r)],
            [pawn_base_r, 1.8],
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
            [0, 0], [major_foot_r, 0],
            [major_base_r, flare_z(major_foot_r, major_base_r)],
            [major_base_r, 2.0],
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
                    [0, 0], [major_foot_r, 0],
                    [major_base_r, flare_z(major_foot_r, major_base_r)],
                    [major_base_r, 2.0],
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
                [0, 0], [bishop_foot_r, 0],
                [bishop_base_r, flare_z(bishop_foot_r, bishop_base_r)],
                [bishop_base_r, 2.0],
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

// Dama: 41.0 mm de topo, entre o rei (46.0) e o bispo (37.5). Ate 2026-08-28
// ela media 37.09 e ficava MAIS BAIXA que o bispo. O ganho de 3.9 mm foi todo
// no pescoco (+2.5) e na coroa (+1.4); a base nao mudou.
queen_neck_top = 30.8;      // mm, topo do torneado (colar sob a coroa)
queen_crown_z = 30.4;       // mm, base da coroa (0.4 de sobreposicao)
queen_crown_h = 8.2;        // mm, altura da coroa
queen_merlon_h = 4.0;       // mm, profundidade dos seis recortes verticais
queen_crown_top = queen_crown_z + queen_crown_h;

module queen() {
    union() {
        lathe([
            [0, 0], [royal_foot_r, 0],
            [royal_base_r, flare_z(royal_foot_r, royal_base_r)],
            [royal_base_r, 2.0],
            [7.3, 3.2], [5.8, 4.8], [3.8, 6.5], [3.0, 22.5],
            [4.6, 25.5], [5.5, 27.5], [5.5, queen_neck_top],
            [0, queen_neck_top]
        ]);

        difference() {
            translate([0, 0, queen_crown_z])
                cylinder(h = queen_crown_h, r1 = 5.5, r2 = 4.7,
                         $fn = detail_fn);

            // Seis recortes verticais: coroa legivel, sem pontas frageis.
            // O cubo tem 5 mm e o piso do recorte fica em queen_merlon_h
            // abaixo do topo, entao ele sempre sai por cima.
            for (a = [0 : 60 : 300])
                rotate([0, 0, a])
                    translate([3.8, 0,
                               queen_crown_top - queen_merlon_h + 2.5])
                        cube([4.0, 1.8, 5.0], center = true);
        }

        // Joia central apoiada no nucleo continuo da coroa. O topo dela e a
        // altura total da peca.
        translate([0, 0, queen_h - queen_jewel_r])
            sphere(r = queen_jewel_r, $fn = detail_fn);
    }
}

module king() {
    union() {
        lathe([
            [0, 0], [royal_foot_r, 0],
            [royal_base_r, flare_z(royal_foot_r, royal_base_r)],
            [royal_base_r, 2.0],
            [7.3, 3.2], [5.8, 4.8], [3.8, 6.5], [3.0, 21.0],
            [4.6, 24.0], [5.2, 26.0], [5.2, 29.0],
            [3.3, 31.2], [0, 31.2]
        ]);
        translate([0, 0, 33.2]) sphere(r = 2.7, $fn = detail_fn);

        // Cruz extrudada em Y. Os bracos vencem apenas 2.9 mm por lado, sem
        // chanfro: decisao do usuario em 2026-08-28, fica como risco conhecido
        // pro teste fisico.
        xz_plate([
            [-1.6, 35.2], [1.6, 35.2], [1.6, 39.2],
            [4.5, 39.2], [4.5, 42.2], [1.6, 42.2],
            [1.6, king_h], [-1.6, king_h], [-1.6, 42.2],
            [-4.5, 42.2], [-4.5, 39.2], [-1.6, 39.2]
        ], 3.8);
    }
}

module piece_of_kind(kind, mirrored_knight = false) {
    if (kind == PAWN) pawn();
    else if (kind == ROOK) rook();
    else if (kind == KNIGHT) knight(mirrored_knight);
    else if (kind == BISHOP) bishop();
    else if (kind == QUEEN) queen();
    else if (kind == KING) king();
}

// --------------------------------------------------------------------------
// Chapa de UM exercito: 16 pecas em pe, base na cama, arranjo 4 x 4.
// Sao 16 solidos disjuntos e nao ha uma unica face virada pra baixo fora do
// apoio na cama, entao o job roda sem suporte.
// --------------------------------------------------------------------------

module army() {
    for (r = [0 : 3])
        for (c = [0 : 3])
            translate([(c - 1.5) * piece_pitch,
                       (1.5 - r) * piece_row_pitch, 0])
                piece_of_kind(army_grid[r][c], r == 2);
}

module board_plate() {
    color(preview_light) board_light();
    color(preview_dark) board_dark();
}

module army_plate(tone = "light") {
    color(tone == "light" ? preview_light : preview_dark) army();
}

// So pra olhar: os tres jobs lado a lado. NAO exportar como chapa.
module preview_all() {
    gap = 14;
    translate([-board_size / 2 - gap - army_job_x / 2, 0, 0])
        army_plate("light");
    board_plate();
    translate([board_size / 2 + gap + army_job_x / 2, 0, 0])
        army_plate("dark");
}

// --------------------------------------------------------------------------
// Seletor de export
// --------------------------------------------------------------------------

if (part == "preview") preview_all();
else if (part == "board_plate") board_plate();
else if (part == "army_plate") army_plate();
else if (part == "board_light") board_light();
else if (part == "board_dark") board_dark();
else if (part == "army") army();
else if (part == "pawn") pawn();
else if (part == "rook") rook();
else if (part == "knight") knight();
else if (part == "bishop") bishop();
else if (part == "queen") queen();
else if (part == "king") king();
else assert(false, str("part desconhecido: ", part));
