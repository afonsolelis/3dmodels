// ring-01.scad
// Anel de tapete de jogo (playmat): abraça o tapete enrolado pra ele não
// desenrolar na mochila. Liso por DENTRO (desliza no tapete sem raspar) e
// com textura de colmeia em relevo por FORA — a mesma identidade hexagonal
// das deckboxes. As células são rebaixadas até a parede lisa; as linhas da
// colmeia ficam em relevo por cima dela, então a parede estrutural segue
// com os 3mm cheios.
//
// Imprimir em pé, como exportado — sem suporte (hexágonos de ponta pra
// cima imprimem limpos na parede vertical). Peça única:
//   openscad -o 3mf/ring-01-plate.3mf  ring-01.scad
//   openscad -o stl/ring-01.stl        ring-01.scad

/* [Anel] */
inner_d = 50; // mm, diâmetro interno (o tapete enrolado passa por aqui)
height  = 50; // mm, altura do anel
wall    = 3;  // mm, espessura da parede (sem contar o relevo da textura)

/* [Textura de colmeia - relevo externo] */
relief    = 1.2; // mm, profundidade das células (altura do relevo)
hex_cols  = 18;  // nº de colunas de células ao redor (fecha exato os 360°)
hex_web   = 2.4; // mm, largura das linhas da colmeia entre células
edge_band = 6;   // mm, faixa lisa mínima em cada borda do anel

/* [Qualidade] */
$fn = 120;

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
outer_d = inner_d + 2 * wall;
outer_r = outer_d / 2;

// ---------------------------------------------------------------------
// Corpo: tubo liso (o furo interno é o Ø que o tapete usa)
// ---------------------------------------------------------------------
module ring_body() {
    difference() {
        cylinder(h = height, d = outer_d);
        translate([0, 0, -0.1])
            cylinder(h = height + 0.2, d = inner_d);
    }
}

// ---------------------------------------------------------------------
// Textura: uma casca fina por fora do corpo, perfurada por prismas
// hexagonais radiais em arranjo de colmeia — o que sobra é a teia em
// relevo. As células são cortadas até DENTRO da casca (0.5mm além), mas o
// corpo é outro sólido, então a parede lisa fica intacta como fundo.
// ---------------------------------------------------------------------
module hex_texture() {
    pitch_a = 360 / hex_cols;            // passo angular entre colunas
    arc     = PI * outer_d / hex_cols;   // passo em arco na superfície
    hex_f   = arc - hex_web;             // entre-faces de cada célula
    hex_r   = hex_f / sqrt(3);           // circunraio (centro -> ponta)
    sy      = arc * sqrt(3) / 2;         // passo vertical entre fileiras

    usable = height - 2 * edge_band;
    nrows  = floor((usable - 2 * hex_r) / sy) + 1;
    field  = (nrows - 1) * sy + 2 * hex_r;
    z0     = (height - field) / 2 + hex_r; // campo centralizado na altura

    difference() {
        cylinder(h = height, d = outer_d + 2 * relief);
        translate([0, 0, -0.1])
            cylinder(h = height + 0.2, d = outer_d); // oca a casca

        for (j = [0 : nrows - 1], i = [0 : hex_cols - 1])
            rotate([0, 0, i * pitch_a + (j % 2) * pitch_a / 2]) // fileiras ímpares giram meio passo
                translate([outer_r - 0.5, 0, z0 + j * sy])
                    rotate([0, 90, 0]) // hexágono de ponta pra cima, prisma radial
                        cylinder(h = relief + 1, r = hex_r, $fn = 6);
    }
}

ring_body();
hex_texture();
