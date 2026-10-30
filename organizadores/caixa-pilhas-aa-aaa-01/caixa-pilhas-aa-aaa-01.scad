// Caixa combinada: 20 pilhas AA + 20 pilhas AAA, com uma tampa de encaixe
// Todas as medidas em mm.

/* [O que mostrar] */
parte = "tudo"; // [tudo, impressao, corpo, tampa, montado]
espaco_pecas = 10;    // distancia entre corpo e tampa no modo impressao
mostrar_pilhas = false;

/* [Pilhas AA] */
aa_d = 14.0;        // medido com paquimetro
aa_h = 50.5;
aa_colunas = 5;
aa_linhas = 4;

/* [Pilhas AAA] */
aaa_d = 12.0;
aaa_h = 44.5;
aaa_colunas = 4;
aaa_linhas = 5;

/* [Medidas da caixa] */
folga_furo = 0.5;     // furo = pilha + folga (AA 14.5 / AAA 12.5)
parede_entre = 1.8;   // parede entre furos do mesmo grupo
divisoria = 3.0;      // parede entre o grupo AA e o grupo AAA
margem = 4.0;         // parede externa
piso = 2.0;           // piso embaixo das AA
corpo_h = 40.0;
degrau_h = 10.0;      // altura do encaixe da tampa
tampa_parede = 2.0;
folga_tampa = 0.3;
raio = 3.0;
sobra_topo = 1.5;     // espaco entre a pilha e o teto da tampa

/* [Gravacao na tampa] */
texto = "PILHAS";
texto_tamanho = 18;
texto_profundidade = 0.6;   // a tampa tem 2 mm de espessura no topo
texto_fonte = "Liberation Sans:style=Bold";

$fn = 64;

// ---------- Valores calculados ----------
aa_furo  = aa_d + folga_furo;
aaa_furo = aaa_d + folga_furo;
aa_passo  = aa_furo + parede_entre;
aaa_passo = aaa_furo + parede_entre;

aa_larg  = (aa_colunas - 1) * aa_passo + aa_furo;
aa_prof  = (aa_linhas - 1) * aa_passo + aa_furo;
aaa_larg = (aaa_colunas - 1) * aaa_passo + aaa_furo;
aaa_prof = (aaa_linhas - 1) * aaa_passo + aaa_furo;

W = aa_larg + divisoria + aaa_larg + 2 * margem;
D = max(aa_prof, aaa_prof) + 2 * margem;

aa_x  = -W / 2 + margem + aa_larg / 2;    // centro do grupo AA
aaa_x =  W / 2 - margem - aaa_larg / 2;   // centro do grupo AAA

// piso mais alto no lado AAA para os topos das pilhas ficarem alinhados
piso_aaa = piso + (aa_h - aaa_h);

inset = tampa_parede + folga_tampa;
base_h = corpo_h - degrau_h;
topo_pilhas = max(piso + aa_h, piso_aaa + aaa_h);
tampa_h = (topo_pilhas + sobra_topo) - base_h + tampa_parede;

echo(str("Caixa: ", W, " x ", D, " mm | corpo ", corpo_h, " mm | tampa ", tampa_h,
         " mm | fechada ", base_h + tampa_h, " mm | furo AA ", aa_furo, " | furo AAA ", aaa_furo));

// ---------- Blocos ----------
module retangulo_arredondado(w, d, r) {
    offset(r = r) square([w - 2 * r, d - 2 * r], center = true);
}

module bloco(w, d, h, r) {
    linear_extrude(h) retangulo_arredondado(w, d, max(r, 0.01));
}

module grade(colunas, linhas, passo) {
    for (c = [0 : colunas - 1], l = [0 : linhas - 1])
        translate([(c - (colunas - 1) / 2) * passo,
                   (l - (linhas - 1) / 2) * passo, 0])
            children();
}

module furos_aa()  { translate([aa_x, 0, piso])     grade(aa_colunas, aa_linhas, aa_passo)    cylinder(d = aa_furo,  h = corpo_h); }
module furos_aaa() { translate([aaa_x, 0, piso_aaa]) grade(aaa_colunas, aaa_linhas, aaa_passo) cylinder(d = aaa_furo, h = corpo_h); }

// ---------- Corpo ----------
module corpo() {
    difference() {
        union() {
            bloco(W, D, base_h, raio);
            bloco(W - 2 * inset, D - 2 * inset, corpo_h, raio - inset);
        }
        furos_aa();
        furos_aaa();
    }
}

// ---------- Tampa (de cabeca para baixo, pronta para imprimir) ----------
module tampa() {
    difference() {
        bloco(W, D, tampa_h, raio);
        translate([0, 0, tampa_parede])
            bloco(W - 2 * tampa_parede, D - 2 * tampa_parede, tampa_h, raio - tampa_parede);
        // gravacao no topo (que fica na mesa ao imprimir): espelhado para ler certo depois de virar
        if (texto != "")
            translate([0, 0, -0.01])
                linear_extrude(texto_profundidade + 0.01)
                    mirror([1, 0, 0])
                        text(texto, size = texto_tamanho, font = texto_fonte,
                             halign = "center", valign = "center");
    }
}

module pilhas() {
    color("orange")
        translate([aa_x, 0, piso]) grade(aa_colunas, aa_linhas, aa_passo) cylinder(d = aa_d, h = aa_h);
    color("gold")
        translate([aaa_x, 0, piso_aaa]) grade(aaa_colunas, aaa_linhas, aaa_passo) cylinder(d = aaa_d, h = aaa_h);
}

// ---------- Saida ----------
if (parte == "impressao") {
    // corpo e tampa lado a lado, centralizados juntos na mesa
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
    if (mostrar_pilhas) pilhas();
} else {
    color("SteelBlue") corpo();
    if (mostrar_pilhas) pilhas();
    color("LightSteelBlue") translate([0, D + 10, 0]) tampa();
}
