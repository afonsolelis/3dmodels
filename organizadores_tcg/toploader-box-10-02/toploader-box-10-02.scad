// Caixa de transporte para 10 top loaders, com tampa de encaixe
// Espaco interno: 103 x 80 x 20 mm. Todas as medidas em mm.

/* [O que mostrar] */
parte = "tudo"; // [tudo, impressao, corpo, tampa, montado]
espaco_pecas = 10;     // distancia entre corpo e tampa no modo impressao
mostrar_cards = false;

/* [Espaco interno] */
int_larg = 103;
int_prof = 80;
int_alt  = 20;
int_raio = 1.0;        // cantos internos

/* [Paredes e encaixe] */
margem = 4.0;          // parede externa (parte de baixo)
piso = 2.0;
degrau_h = 10.0;       // altura do encaixe da tampa
tampa_parede = 2.0;
tampa_topo = 2.0;
folga_tampa = 0.3;
raio = 3.0;            // cantos externos

/* [Recorte para os dedos] */
usar_recorte = true;
recorte_larg = 26;
recorte_prof = 8;      // menor que degrau_h para a tampa cobrir tudo

/* [Furo no fundo (empurrar os top loaders para cima)] */
furo_fundo_d = 20;     // 0 = sem furo
furo_fundo_x = 0;      // posicao a partir do centro
furo_fundo_y = 0;

/* [Gravacao na tampa] */
texto = "";            // ex.: "TOP LOADERS" (vazio = sem gravacao)
texto_tamanho = 12;
texto_profundidade = 0.6;
texto_fonte = "Liberation Sans:style=Bold";

$fn = 64;

// ---------- Valores calculados ----------
W = int_larg + 2 * margem;
D = int_prof + 2 * margem;
corpo_h = piso + int_alt;
base_h = corpo_h - degrau_h;
inset = tampa_parede + folga_tampa;
tampa_h = degrau_h + tampa_topo;

echo(str("Caixa: ", W, " x ", D, " mm | corpo ", corpo_h, " mm | tampa ", tampa_h,
         " mm | fechada ", base_h + tampa_h, " mm | parede no encaixe ", margem - inset, " mm"));

// ---------- Blocos ----------
module retangulo_arredondado(w, d, r) {
    offset(r = r) square([w - 2 * r, d - 2 * r], center = true);
}

module bloco(w, d, h, r) {
    linear_extrude(h) retangulo_arredondado(w, d, max(r, 0.01));
}

// ---------- Corpo ----------
module corpo() {
    difference() {
        union() {
            bloco(W, D, base_h, raio);
            bloco(W - 2 * inset, D - 2 * inset, corpo_h, raio - inset);
        }
        // espaco interno
        translate([0, 0, piso]) bloco(int_larg, int_prof, corpo_h, int_raio);
        // furo no fundo
        if (furo_fundo_d > 0)
            translate([furo_fundo_x, furo_fundo_y, -1]) cylinder(d = furo_fundo_d, h = piso + 2);
        // recortes em U nas laterais compridas
        if (usar_recorte)
            for (s = [-1, 1])
                // fundo do U fica recorte_prof abaixo do topo; corta so a parede
                translate([0, s * D / 2, corpo_h - recorte_prof + recorte_larg / 2])
                    rotate([90, 0, 0])
                        linear_extrude(margem * 3, center = true)
                            hull() {
                                circle(d = recorte_larg);
                                translate([-recorte_larg / 2, 0]) square([recorte_larg, recorte_prof + 1]);
                            }
    }
}

// ---------- Tampa (de cabeca para baixo, pronta para imprimir) ----------
module tampa() {
    difference() {
        bloco(W, D, tampa_h, raio);
        translate([0, 0, tampa_topo])
            bloco(W - 2 * tampa_parede, D - 2 * tampa_parede, tampa_h, raio - tampa_parede);
        if (texto != "")
            translate([0, 0, -0.01])
                linear_extrude(texto_profundidade + 0.01)
                    mirror([1, 0, 0])
                        text(texto, size = texto_tamanho, font = texto_fonte,
                             halign = "center", valign = "center");
    }
}

// top loaders de referencia (aprox. 101 x 77 x 1.5 mm cada)
module cards() {
    color("white", 0.6)
        for (i = [0 : 9])
            translate([0, 0, piso + i * 2 + 0.25])
                linear_extrude(1.5) retangulo_arredondado(101, 77, 2);
}

// ---------- Saida ----------
if (parte == "impressao") {
    translate([0, -(D + espaco_pecas) / 2, 0]) corpo();
    translate([0,  (D + espaco_pecas) / 2, 0]) tampa();
} else if (parte == "corpo") {
    corpo();
} else if (parte == "tampa") {
    tampa();
} else if (parte == "montado") {
    color("SteelBlue") corpo();
    color("LightSteelBlue", 0.5)
        translate([0, 0, base_h + tampa_h]) rotate([0, 180, 0]) tampa();
    if (mostrar_cards) cards();
} else {
    color("SteelBlue") corpo();
    if (mostrar_cards) cards();
    color("LightSteelBlue") translate([0, D + 10, 0]) tampa();
}
