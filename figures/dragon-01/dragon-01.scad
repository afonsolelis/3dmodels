// dragon-01.scad
// Dragão sentinela low-poly: figura decorativa de uma peça, agachada sobre
// uma base hexagonal com colmeia em baixo-relevo. As asas ficam dobradas para
// trás e descem até a base: além de deixarem a silhueta legível, os dois pontos
// de contato eliminam asas inteiras começando no ar. Pernas, cauda e asas se
// sobrepõem à base; o export final é um único sólido.
//
// Orientação canônica: como modelado, base na mesa e cabeça para +Y.
// Não escalar abaixo de 80%: membranas (2.8mm), garras e pontas ficariam
// finas demais para um bico de 0.4mm.
//
// Export canônico (nesta máquina usar o Flatpak e caminhos absolutos):
//   openscad -o stl/dragon-01.stl       dragon-01.scad
//   openscad -o 3mf/dragon-01-plate.3mf dragon-01.scad

/* [Base] */
base_radius = 54;       // mm, raio nos vértices do hexágono
base_y_scale = 1.08;    // alonga a base na direção cabeça/cauda
base_h = 5;             // mm
groove_depth = 0.65;    // mm, colmeia em baixo-relevo

/* [Asas] */
wing_t = 2.8;           // mm, membrana (7 linhas com bico de 0.4)
wing_root_x = 11.5;     // mm, entra no corpo
wing_sweep = 20;        // graus para trás e para fora
wing_bone_r = 1.9;      // mm, nervuras estruturais

/* [Estilo e qualidade] */
facet_fn = 14;          // facetado intencional, estilo low-poly
smooth_fn = 36;         // base e detalhes circulares
$fn = facet_fn;

// ---------------------------------------------------------------------
// Utilitários geométricos
// ---------------------------------------------------------------------
module ellipsoid(p, radii, facets = facet_fn) {
    translate(p)
        scale(radii)
            sphere(r = 1, $fn = facets);
}

// Segmento orgânico afilado. O hull das duas esferas evita quinas frágeis.
module capsule(p1, p2, r1, r2, facets = facet_fn) {
    hull() {
        translate(p1) sphere(r = r1, $fn = facets);
        translate(p2) sphere(r = r2, $fn = facets);
    }
}

// Cone/prisma orientado entre dois pontos, usado nas pontas e garras.
module cone_between(p1, p2, r1, r2 = 0.35, facets = 8) {
    v = p2 - p1;
    len = norm(v);
    planar = sqrt(v[0] * v[0] + v[1] * v[1]);

    if (planar < 0.001)
        translate(p1)
            if (v[2] >= 0)
                cylinder(h = len, r1 = r1, r2 = r2, $fn = facets);
            else
                rotate([180, 0, 0])
                    cylinder(h = len, r1 = r1, r2 = r2, $fn = facets);
    else
        translate(p1)
            rotate(a = acos(v[2] / len), v = [-v[1], v[0], 0])
                cylinder(h = len, r1 = r1, r2 = r2, $fn = facets);
}

// Extruda um polígono desenhado no plano local YZ na espessura local X.
module yz_plate(points, thickness) {
    multmatrix([
        [0, 0, 1, 0],
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 0, 1]
    ])
        linear_extrude(height = thickness, center = true, convexity = 10)
            polygon(points = points);
}

// ---------------------------------------------------------------------
// Base hexagonal chanfrada + identidade de colmeia
// ---------------------------------------------------------------------
module base_blank() {
    // Chanfros de 45°: nenhum beiral pede suporte.
    scale([1, base_y_scale, 1]) {
        cylinder(h = 1, r1 = base_radius - 1, r2 = base_radius,
                 $fn = 6);
        translate([0, 0, 1])
            cylinder(h = base_h - 2, r = base_radius, $fn = 6);
        translate([0, 0, base_h - 1])
            cylinder(h = 1, r1 = base_radius, r2 = base_radius - 1,
                     $fn = 6);
    }
}

module hex_groove(cell_r = 8.0, line_w = 0.9) {
    linear_extrude(height = groove_depth + 0.2)
        difference() {
            rotate(30) circle(r = cell_r, $fn = 6);
            rotate(30) circle(r = cell_r - line_w, $fn = 6);
        }
}

module honeycomb_grooves() {
    // 17 células visíveis (raio axial 2), ponta para cima. As duas que
    // cairiam exatamente sob as patas traseiras são omitidas: cobertas pelo
    // pé, virariam microcavidades de ar seladas. O passo usa raio 8.5, mas o
    // sulco usa 8.0: a faixa de 0.87mm entre vizinhas impede arestas
    // coincidentes/não-manifold no STL sem perder a leitura de colmeia.
    pitch_r = 8.5;
    groove_r = 8.0;
    for (q = [-2 : 2])
        for (r = [-2 : 2])
            if (abs(q + r) <= 2 && !(r == -2 && (q == 0 || q == 2)))
                translate([
                    sqrt(3) * pitch_r * (q + r / 2),
                    1.5 * pitch_r * r,
                    base_h - groove_depth
                ])
                    hex_groove(groove_r, 0.9);
}

module patterned_base() {
    difference() {
        base_blank();
        honeycomb_grooves();
    }
}

// ---------------------------------------------------------------------
// Asas dobradas: membrana vertical, pé no pedestal e nervuras salientes
// ---------------------------------------------------------------------
wing_outline = [
    [0, 38],
    [-6, 60],
    [-20, 99],
    [-34, 71],
    [-38, 4.2],
    [-29, 4.2],
    [-18, 34]
];

module wing_local() {
    union() {
        yz_plate(wing_outline, wing_t);

        // Bordas e raios: criam a leitura de asa e engrossam as linhas de carga.
        capsule([0, 0, 39], [0, -6, 60], wing_bone_r + 0.5,
                wing_bone_r + 0.25, 12);
        capsule([0, -6, 60], [0, -20, 98], wing_bone_r + 0.25,
                wing_bone_r, 12);
        capsule([0, -20, 98], [0, -34, 71], wing_bone_r,
                wing_bone_r, 12);
        capsule([0, -34, 71], [0, -37, 5], wing_bone_r,
                wing_bone_r + 0.3, 12);
        capsule([0, -1, 41], [0, -33, 70], wing_bone_r + 0.35,
                wing_bone_r, 12);
        capsule([0, -1, 40], [0, -30, 5], wing_bone_r + 0.35,
                wing_bone_r + 0.3, 12);
    }
}

module right_wing() {
    translate([wing_root_x, 0, 0])
        rotate([0, 0, wing_sweep])
            wing_local();
}

module wings() {
    right_wing();
    mirror([1, 0, 0]) right_wing();
}

// ---------------------------------------------------------------------
// Corpo, membros e cauda
// ---------------------------------------------------------------------
module body_core() {
    // Tronco, peito e garupa.
    ellipsoid([0, -6, 34], [18, 25, 21]);
    ellipsoid([0, 8, 42], [15, 18, 19]);
    ellipsoid([0, -20, 31], [17, 17, 17]);

    // Pernas traseiras, agachadas.
    for (side = [-1, 1]) {
        ellipsoid([side * 13, -15, 27], [10, 12, 13]);
        capsule([side * 14, -17, 24], [side * 18, -24, 10],
                7, 5.2);
        capsule([side * 18, -24, 8], [side * 18, -14, 6.5],
                5.2, 4.2);

        // Patas dianteiras descem quase verticais do peito.
        capsule([side * 12, 8, 40], [side * 15, 15, 25],
                6.2, 5.2);
        capsule([side * 15, 15, 25], [side * 17, 24, 10],
                5.2, 4.2);
        ellipsoid([side * 17, 26, 7], [6, 8, 4.2], 12);

        // Três garras dianteiras por pata, todas nascendo dentro do pé.
        for (dx = [-2.8, 0, 2.8])
            cone_between([side * 17 + dx, 29, 7.2],
                         [side * 17 + dx, 34, 5.6], 1.25, 0.3, 7);
    }
}

module curled_tail() {
    capsule([0, -22, 31], [5, -33, 22], 9, 7.2);
    capsule([5, -33, 22], [20, -41, 12], 7.2, 5.2);
    capsule([20, -41, 12], [34, -36, 7.8], 5.2, 3.8);
    capsule([34, -36, 7.8], [42, -23, 6.8], 3.8, 2.8);
    capsule([42, -23, 6.8], [43, -9, 6.2], 2.8, 1.4);

    // Pequenas cristas acompanham o começo da cauda.
    cone_between([2, -27, 37], [3, -30, 45], 2.8, 0.35, 7);
    cone_between([8, -35, 27], [10, -38, 34], 2.4, 0.35, 7);
}

// ---------------------------------------------------------------------
// Pescoço e cabeça
// ---------------------------------------------------------------------
module neck() {
    capsule([0, 6, 46], [0, 16, 56], 11, 9.5);
    capsule([0, 16, 56], [0, 27, 65], 9.5, 8.2);
    capsule([0, 27, 65], [0, 35, 71], 8.2, 7.8);
}

module head_without_details() {
    difference() {
        union() {
            ellipsoid([0, 38, 72], [11, 14, 10], 16);
            ellipsoid([0, 49, 69], [9, 11, 7], 14);
            ellipsoid([0, 48, 65.5], [8.5, 10, 5.5], 14);
        }

        // Narinas rasas: leem bem mesmo em impressão monocromática.
        for (side = [-1, 1])
            translate([side * 3.4, 58.0, 71.0])
                sphere(r = 1.35, $fn = 12);
    }
}

module head_details() {
    // Olhos e sobrancelhas em relevo.
    for (side = [-1, 1]) {
        ellipsoid([side * 9.1, 42, 75], [2.2, 2.7, 2.0], 12);
        capsule([side * 7.1, 39.5, 77], [side * 9.8, 43, 76],
                1.55, 1.15, 10);

        // Chifres principais e espigões laterais, inclinados >=45°.
        cone_between([side * 5.2, 31, 78],
                     [side * 7.4, 21, 91], 2.5, 0.45, 9);
        cone_between([side * 7.2, 34, 75],
                     [side * 12.5, 28, 83], 2.1, 0.4, 8);
    }
}

module dorsal_spikes() {
    cone_between([0, -15, 49], [0, -18, 60], 4.1, 0.45, 8);
    cone_between([0, -5, 53], [0, -8, 65], 4.0, 0.45, 8);
    cone_between([0, 5, 56], [0, 1, 68], 3.8, 0.45, 8);
    cone_between([0, 15, 62], [0, 9, 73], 3.3, 0.4, 8);
    cone_between([0, 24, 68], [0, 17, 78], 2.8, 0.4, 8);
}

module chest_scales() {
    // Quatro placas hexagonais, ponta para cima, repetem a linguagem do repo.
    translate([0, 18.6, 30])
        rotate([90, 0, 0]) cylinder(h = 2.2, r = 4.8, center = true, $fn = 6);
    for (side = [-1, 1])
        translate([side * 4.5, 17.5, 39])
            rotate([90, 0, 0]) cylinder(h = 2.2, r = 4.6, center = true, $fn = 6);
    translate([0, 15.0, 47])
        rotate([90, 0, 0]) cylinder(h = 2.2, r = 4.4, center = true, $fn = 6);
}

module dragon() {
    union() {
        body_core();
        curled_tail();
        wings();
        neck();
        head_without_details();
        head_details();
        dorsal_spikes();
        chest_scales();
    }
}

// A base é unida por último. Onde pés/asas cruzam a colmeia, a figura
// preenche os sulcos e mantém uma junta estrutural larga.
union() {
    patterned_base();
    dragon();
}
