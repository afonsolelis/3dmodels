// ring-02.scad
// Anel de playmat "cristal torcido" — o irmão invocado do ring-01. Por
// dentro, o mesmo furo cilíndrico liso Ø50 (o tapete desliza sem raspar).
// Por fora, a identidade hexagonal do repo promovida de textura a SILHUETA:
// um prisma hexagonal com torção espelhada — a metade de baixo gira +30°,
// a de cima desfaz os +30° — formando uma cintura de 6 chevrons no meio,
// como um cristal lapidado. Com twist=30 os cantos da cintura caem exatos
// no meio das faces das bocas, e as duas bocas ficam alinhadas entre si
// (apoia em pé e empilha).
//
// Imprime em pé, como exportado, sem suporte: a trajetória helicoidal dos
// cantos inclina atan(vertex_r * twist_rad / half_h) ≈ 34° da vertical
// (< 45°; acima de twist ~45 começa a pedir suporte). Cantos de hexágono
// são rombudos (120°) — não rasgam o tecido da mochila. Chanfro de 45° nas
// duas bocas do furo pra guiar o tapete ao vestir. Peça única:
//   openscad -o 3mf/ring-02-plate.3mf  ring-02.scad
//   openscad -o stl/ring-02.stl        ring-02.scad

/* [Anel] */
inner_d = 50; // mm, diâmetro interno (o tapete enrolado passa por aqui)
height  = 50; // mm, altura do anel
wall    = 3;  // mm, parede mínima (do furo ao meio de cada face do hexágono)

/* [Torção] */
twist   = 30;  // graus por metade, espelhada no meio (~45 é o teto sem suporte)
chamfer = 1.2; // mm, chanfro 45° das duas bocas do furo

/* [Qualidade] */
$fn    = 120;
slices = 64; // fatias de cada metade torcida (suavidade da hélice)

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
apothem  = inner_d / 2 + wall; // centro -> meio da face (onde a parede é mínima)
vertex_r = apothem / cos(30);  // centro -> canto do hexágono
half_h   = height / 2;

module hex2d() circle(r = vertex_r, $fn = 6);

// ---------------------------------------------------------------------
// Prisma hexagonal com torção espelhada (ampulheta). linear_extrude com
// twist=t gira o perfil de -t ao longo da altura, então a metade de cima
// parte do perfil já girado de -twist e destorce de volta a 0° — as faces
// se encontram na cintura sem degrau.
// ---------------------------------------------------------------------
module crystal() {
    linear_extrude(half_h, twist = twist, slices = slices, convexity = 10)
        hex2d();
    translate([0, 0, half_h])
        linear_extrude(half_h, twist = -twist, slices = slices, convexity = 10)
            rotate(-twist)
                hex2d();
}

difference() {
    crystal();

    // furo liso do tapete
    translate([0, 0, -0.1])
        cylinder(h = height + 0.2, d = inner_d);

    // chanfros 45° das duas bocas (os 0.1 de folga booleana mantêm os 45°)
    translate([0, 0, -0.1])
        cylinder(h = chamfer + 0.1, d1 = inner_d + 2 * (chamfer + 0.1), d2 = inner_d);
    translate([0, 0, height - chamfer])
        cylinder(h = chamfer + 0.1, d1 = inner_d, d2 = inner_d + 2 * (chamfer + 0.1));
}
