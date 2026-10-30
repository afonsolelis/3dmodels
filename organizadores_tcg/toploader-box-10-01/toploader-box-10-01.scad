// Caixa de transporte para 10 toploaders deitados em pilha, com tampa deslizante.
// Mesmo padrão de tampa da caixa de envio original: trilhos nas paredes laterais
// e tampa plana que desliza por eles.
//
// Medidas:
//   toploader: 77 x 102 mm, espessura 2 mm (medida pelo usuário)
//   pilha: 10 toploaders = 20 mm de altura
//
// Export (uma peça por arquivo, e a chapa com as duas na cama):
//   openscad -o <abs>/toploader-box-10-01-caixa.stl -D 'part="caixa"' <abs>/toploader-box-10-01.scad
//   openscad -o <abs>/toploader-box-10-01-tampa.stl -D 'part="tampa"' <abs>/toploader-box-10-01.scad
//   openscad -o <abs>/toploader-box-10-01-chapa.stl -D 'part="chapa"' <abs>/toploader-box-10-01.scad

part = "montado"; // "caixa" | "tampa" | "chapa" (as duas na cama) | "montado" (preview)

// --- toploader ---
tl_w = 77;           // mm
tl_h = 102;          // mm
tl_t = 2;            // mm, espessura medida
n    = 10;           // quantidade na pilha
clr  = 0.5;          // mm por lado, folga do toploader no interior

// --- caixa ---
wall      = 3;       // mm, parede
floor_t   = 3;       // mm, fundo
top_gap   = 2;       // mm, folga entre a pilha e o topo da caixa
gdepth    = 1.5;     // mm, profundidade do trilho na parede
gh        = 3.5;     // mm, altura do trilho (a tampa tem 3, com folga)

// --- tampa ---
lid_t    = 3;        // mm, espessura da tampa
lid_clr  = 0.25;     // mm, folga da tampa no trilho (em Z)
lid_gap  = 0.5;      // mm, folga da tampa no trilho (em X) e nas pontas (em Y)

// --- derivados ---
inner_w = tl_w + 2*clr;          // 78
inner_l = tl_h + 2*clr;          // 103
stack   = n * tl_t;              // 20
inner_h = stack + top_gap;       // 22
Xo = inner_w + 2*wall;           // 84
Yo = inner_l + 2*wall;           // 109
Zo = floor_t + inner_h;          // 25

// trilho: largura em X vai da face externa do trilho até a face interna da parede
rail_x0 = wall - gdepth;         // 1.5 (face externa do trilho, esquerda)
lid_x0  = rail_x0 + lid_gap;     // 2.0 (borda da tampa, esquerda)
lid_w   = Xo - 2*lid_x0;         // 80
lid_l   = Yo - 2*lid_gap;        // 108
lid_z0  = Zo - gh + lid_clr;     // 21.75 (base da tampa montada)

echo(str("interior ", inner_w, " x ", inner_l, " x ", inner_h));
echo(str("caixa ", Xo, " x ", Yo, " x ", Zo));
echo(str("tampa ", lid_w, " x ", lid_l, " x ", lid_t));

module caixa() {
    difference() {
        cube([Xo, Yo, Zo]);

        // interior: pilha de toploaders
        translate([wall, wall, floor_t])
            cube([inner_w, inner_l, inner_h + 1]);

        // trilhos nas duas paredes laterais, abertos nas pontas (a tampa entra por elas)
        translate([rail_x0, -1, Zo - gh])
            cube([gdepth + 0.001, Yo + 2, gh + 1]);
        translate([Xo - wall - 0.001, -1, Zo - gh])
            cube([gdepth + 0.001, Yo + 2, gh + 1]);
    }
}

module tampa_montada() {
    translate([lid_x0, lid_gap, lid_z0])
        cube([lid_w, lid_l, lid_t]);
}

// tampa deitada na cama, para impressão
module tampa_print(x_off) {
    translate([x_off, lid_gap, 0])
        cube([lid_w, lid_l, lid_t]);
}

if (part == "caixa") {
    caixa();
} else if (part == "tampa") {
    tampa_print(0);
} else if (part == "chapa") {
    caixa();
    tampa_print(Xo + 10);
} else {
    caixa();
    tampa_montada();
}
