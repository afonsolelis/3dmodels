// Caixa de transporte REFORCADA para top loaders (5 ou 10)
// Espaco interno exato: 103 x 80 mm (10 mm de altura para 5, 20 mm para 10).
// Paredes grossas com trelica interna (vazios fechados) para amortecer impactos.
// Todas as medidas em mm.

/* [O que mostrar] */
parte = "tudo"; // [tudo, impressao, corpo, tampa, montado, corte]
quantidade = 10; // [5, 10]
espaco_pecas = 10;
mostrar_cards = false;

/* [Top loaders] */
cards_larg = 103;
cards_prof = 80;
alt_por_5 = 10;            // altura de 5 top loaders

/* [Paredes (reforcadas)] */
margem = 9.0;              // espessura total da parede
piso = 3.0;
tampa_parede = 2.5;
tampa_topo = 3.0;
folga_tampa = 0.3;
raio = 5.0;                // cantos externos
int_raio = 1.0;            // cantos internos

/* [Trelica dentro da parede] */
usar_trelica = true;
pele = 1.2;                // parede solida de cada lado da trelica
nervura = 1.2;             // espessura das nervuras diagonais
passo_trelica = 7.0;       // distancia entre nervuras
tampa_trelica = 1.5;       // parede solida que fecha a trelica em cima

/* [Recorte para os dedos] */
usar_recorte = true;
recorte_larg = 26;

/* [Furo no fundo] */
furo_fundo_d = 20;         // 0 = sem furo

/* [Gravacao na tampa] */
texto = "";
texto_tamanho = 12;
texto_profundidade = 0.6;
texto_fonte = "Liberation Sans:style=Bold";

$fn = 64;

// ---------- Valores calculados ----------
cards_alt = alt_por_5 * quantidade / 5;
W = cards_larg + 2 * margem;
D = cards_prof + 2 * margem;
corpo_h = piso + cards_alt;
degrau_h = quantidade <= 5 ? 8 : 10;
recorte_prof = degrau_h - 2;          // a tampa cobre o recorte
base_h = corpo_h - degrau_h;
inset = tampa_parede + folga_tampa;
tampa_h = degrau_h + tampa_topo;

// faixa da trelica (medida a partir da borda interna), dentro da parede do encaixe
trelica_ini = pele;
trelica_fim = margem - inset - pele;

echo(str("Caixa ", quantidade, " top loaders: ", W, " x ", D, " mm | fechada ", base_h + tampa_h,
         " mm | interno ", cards_larg, " x ", cards_prof, " x ", cards_alt,
         " | trelica ", trelica_fim - trelica_ini, " mm de largura"));

// ---------- Blocos ----------
module retangulo_arredondado(w, d, r) {
    offset(r = r) square([w - 2 * r, d - 2 * r], center = true);
}

module bloco(w, d, h, r) {
    linear_extrude(h) retangulo_arredondado(w, d, max(r, 0.01));
}

module recortes(comprimento) {
    for (s = [-1, 1])
        translate([0, s * D / 2, corpo_h - recorte_prof + recorte_larg / 2])
            rotate([90, 0, 0])
                linear_extrude(comprimento, center = true)
                    hull() {
                        circle(d = recorte_larg);
                        translate([-recorte_larg / 2, 0]) square([recorte_larg, recorte_prof + 1]);
                    }
}

// ---------- Trelica (2D) ----------
module faixa_trelica() {
    difference() {
        retangulo_arredondado(cards_larg + 2 * trelica_fim, cards_prof + 2 * trelica_fim, int_raio + trelica_fim);
        retangulo_arredondado(cards_larg + 2 * trelica_ini, cards_prof + 2 * trelica_ini, int_raio + trelica_ini);
    }
}

module nervuras() {
    n = ceil((W + D) / passo_trelica);
    for (a = [45, -45]) rotate(a)
        for (i = [-n : n]) translate([i * passo_trelica, 0])
            square([nervura, 2 * (W + D)], center = true);
}

module vazios_trelica() {
    difference() {
        faixa_trelica();
        nervuras();
        // parede solida em volta dos recortes para nao abrir os vazios
        if (usar_recorte)
            for (s = [-1, 1])
                translate([0, s * D / 2]) square([recorte_larg + 2 * pele + 4, margem * 3], center = true);
    }
}

// ---------- Corpo ----------
module corpo() {
    difference() {
        union() {
            bloco(W, D, base_h, raio);
            bloco(W - 2 * inset, D - 2 * inset, corpo_h, raio - inset);
        }
        translate([0, 0, piso]) bloco(cards_larg, cards_prof, corpo_h, int_raio);
        if (usar_trelica)
            translate([0, 0, piso])
                linear_extrude(corpo_h - piso - tampa_trelica) vazios_trelica();
        if (usar_recorte) recortes(margem * 3);
        if (furo_fundo_d > 0)
            translate([0, 0, -1]) cylinder(d = furo_fundo_d, h = piso + 2);
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

module cards() {
    color("white", 0.6)
        for (i = [0 : quantidade - 1])
            translate([0, 0, piso + i * (cards_alt / quantidade) + 0.25])
                linear_extrude(1.5) retangulo_arredondado(cards_larg - 1, cards_prof - 1, 1);
}

// ---------- Saida ----------
if (parte == "impressao") {
    translate([0, -(D + espaco_pecas) / 2, 0]) corpo();
    translate([0,  (D + espaco_pecas) / 2, 0]) tampa();
} else if (parte == "corpo") {
    corpo();
} else if (parte == "tampa") {
    tampa();
} else if (parte == "corte") {
    // corpo cortado na metade da altura para ver a trelica
    intersection() {
        corpo();
        translate([-W, -D, 0]) cube([2 * W, 2 * D, piso + (corpo_h - piso) / 2]);
    }
} else if (parte == "montado") {
    color("SteelBlue") corpo();
    color("LightSteelBlue", 0.4)
        translate([0, 0, base_h + tampa_h]) rotate([0, 180, 0]) tampa();
    if (mostrar_cards) cards();
} else {
    color("SteelBlue") corpo();
    if (mostrar_cards) cards();
    color("LightSteelBlue") translate([0, D + 10, 0]) tampa();
}
