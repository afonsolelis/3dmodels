// cardholder-01.scad
// Porta-cartas aberto pra pilha de cartas de TCG: chapa de fundo vazada em
// colmeia + 4 cantoneiras em L que abraçam os cantos da pilha. A carta entra
// e sai por cima; as cantoneiras deixam a pilha à vista pelas laterais.
//
// POR QUE ESTE MODELO EXISTE: o `cardholders/card_holder_with_feet.3mf`
// (Don Julio, MakerWorld, Standard Digital File License — arquivo de
// terceiro, sem fonte) foi impresso e ficou FRACO. Motivo medido no mesh
// dele: 4 cantoneiras de 2mm de parede com 56mm de balanço, soldadas numa
// chapa de 2mm por uma junta de só 2x10mm — cada poste é um balanço solto,
// o quadro racka e os postes abrem. Aqui a geometria útil é a mesma
// (bolso 66x90, parede 2mm, braços de 10mm, 56mm de curso de pilha), mas
// com TRÊS reforços que não engrossam nenhuma parede:
//
//   1. CINTA DO MEIO e CINTA DO TOPO — dois anéis fechados de 2x6mm que
//      amarram as 4 cantoneiras nos dois eixos. É o que transforma 4
//      balanços independentes num quadro fechado. A abertura interna dos
//      anéis é o próprio bolso (66x90), então a pilha continua entrando e
//      saindo por cima sem encostar.
//   2. CINTA DE BAIXO (pé integrado) — anel de 2mm x 4mm de altura por
//      baixo da chapa, recuado da borda. Substitui os 4 pezinhos soltos do
//      original (4 peças à parte, pressionadas nos rebaixos Ø10 dos cantos)
//      e de quebra vira nervura: a chapa de 2mm deixa de ser uma placa
//      solta e vira seção em caixa.
//   3. FILETES DE RAIZ — gussets a 45° por BAIXO da chapa, na raiz de cada
//      braço de cantoneira. Espalham o momento do poste na chapa em vez de
//      concentrar tudo na junta de 2mm. Ficam abaixo do plano da carta, não
//      encostam na pilha, e imprimem autossustentados.
//
// BOLSO: 66 x 90 mm, herdado do original — dimensionado pra carta NUA
// (63 x 88). Sleeve penny (66 x 91) NÃO entra. Pra versão com sleeve,
// mexer em pocket_w/pocket_l (ver comentário lá embaixo).
//
// Peça única, sem montagem, sem suporte. Exports canônicos:
//   openscad -o stl/cardholder-01.stl     -D 'part="holder"' cardholder-01.scad
//   openscad -o 3mf/cardholder-01.3mf     -D 'part="holder"' cardholder-01.scad
//   openscad -o 3mf/cardholder-01-x2.3mf  -D 'part="plate2"' cardholder-01.scad
// A pasta 3mf/ tem 2 jobs: uma unidade (70x94mm, pra testar) e a chapa de
// duas unidades lado a lado (146x94mm) — a cama da A1 mini comporta as duas
// numa tacada só.

/* [Peça a renderizar] */
part = "holder"; // "holder" (uma unidade) | "plate2" (chapa com 2 unidades)

/* [Bolso das cartas - medida real da carta] */
// Carta de Pokémon TCG NUA = 63 x 88 mm (medida de catálogo, confere com o
// original impresso). O bolso abaixo é o mesmo do modelo que já foi pra
// mesa, de propósito: assim as unidades novas e a velha empilham juntas.
// Pra outros conteúdos, trocar aqui (padrão do repo = ~1mm de folga/lado):
//   sleeve penny  (66 x 91) -> pocket_w = 68; pocket_l = 93;
//   double sleeve (67 x 92) -> pocket_w = 69; pocket_l = 94;
pocket_w = 66; // mm, largura interna livre (carta nua 63 + 1.5/lado)
pocket_l = 90; // mm, comprimento interno livre (carta nua 88 + 1.0/lado)

/* [Cantoneiras] */
wall     = 2;  // mm, espessura de TUDO (cantoneiras, cintas, pé) — NÃO engrossar: o reforço vem da geometria, não da parede
post_arm = 10; // mm, quanto cada braço do L avança a partir do canto
post_h   = 56; // mm, altura livre de pilha acima da chapa (~220 cartas nuas)

/* [Cintas - as travas] */
band_h       = 6; // mm, altura de cada anel
band_top_gap = 4; // mm, quanto de cantoneira sobra acima da cinta do topo
                  // (0 = cinta rente ao topo, mais rígido; 4 = dá pra ver a
                  //  carta de cima e pinçar a pilha pelas pontas)

/* [Cinta de baixo - pé integrado, no lugar dos 4 pezinhos soltos] */
foot_h     = 4; // mm, altura do pé (era a espessura do pezinho solto do original)
foot_inset = 4; // mm, recuo do anel do pé pra dentro da borda da chapa.
                // Colocar 0.25 faz o pé virar espiga: uma unidade VAZIA
                // encaixa dentro do bolso da unidade de baixo e trava.

/* [Filetes de raiz do poste - por baixo da chapa] */
gusset     = 4;  // mm, cateto do filete a 45°
gusset_len = 14; // mm, comprimento do filete ao longo de cada braço

/* [Chapa de fundo e vazado hexagonal] */
plate_t    = 2;   // mm, espessura da chapa
hex_d      = 8;   // mm, tamanho de cada furo hexagonal (entre faces)
hex_web    = 2;   // mm, material entre furos vizinhos
hex_margin = 5;   // mm, borda sólida em volta do painel (é onde a chapa solda nos postes)

/* [Chapa de impressão] */
plate_gap = 6; // mm, folga entre as duas unidades em part="plate2"

/* [Qualidade] */
$fn = 48;

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
outer_w = pocket_w + 2 * wall; // 70 — as cantoneiras ficam POR FORA do bolso
outer_l = pocket_l + 2 * wall; // 94

plate_z0 = foot_h;                 // face de baixo da chapa (topo do pé)
plate_z1 = plate_z0 + plate_t;     // face de cima da chapa = onde a carta apoia
total_h  = plate_z1 + post_h;      // altura total da peça

// cinta do meio: centrada no curso livre entre a chapa e a cinta do topo
band_top_z0 = total_h - band_top_gap - band_h;
band_mid_z0 = plate_z1 + (band_top_z0 - plate_z1 - band_h) / 2;

echo(str("cardholder-01: externo ", outer_w, " x ", outer_l, " x ", total_h, " mm"));
echo(str("  bolso ", pocket_w, " x ", pocket_l, " mm | curso de pilha ", post_h, " mm"));
echo(str("  cinta meio z=", band_mid_z0, "..", band_mid_z0 + band_h,
         " | cinta topo z=", band_top_z0, "..", band_top_z0 + band_h));
echo(str("  vaos livres de cantoneira: ", band_mid_z0 - plate_z1, " / ",
         band_top_z0 - (band_mid_z0 + band_h), " / ", total_h - (band_top_z0 + band_h), " mm"));

// ---------------------------------------------------------------------
// Peça inteira
// ---------------------------------------------------------------------
module holder() {
    at_corners() corner_post();
    at_corners() corner_gusset();
    band(band_mid_z0);
    band(band_top_z0);
    base_plate();
    foot_rim();
}

// Coloca os filhos nos 4 cantos, cada um girado pro seu quadrante. O filho
// é desenhado no canto (0,0) abrindo pra +X e +Y.
module at_corners() {
    for (p = [[0, 0, 0], [outer_w, 0, 90], [outer_w, outer_l, 180], [0, outer_l, 270]])
        translate([p[0], p[1], 0])
            rotate([0, 0, p[2]])
                children();
}

// Cantoneira em L: dois braços de `post_arm`, parede `wall`, do chão ao topo.
module corner_post() {
    cube([wall, post_arm, total_h]);
    cube([post_arm, wall, total_h]);
}

// Filete a 45° na raiz do poste, POR BAIXO da chapa (z de plate_z0 pra
// baixo). Fica fora do plano de apoio da carta e imprime autossustentado:
// cada camada é mais larga que a de baixo. Um por braço do L — o segundo
// sai do primeiro espelhado na diagonal x=y.
module corner_gusset() {
    root_gusset();
    mirror([1, -1, 0]) root_gusset();
}

module root_gusset() {
    translate([wall, gusset_len, plate_z0])
        rotate([90, 0, 0])
            linear_extrude(gusset_len)
                polygon([[0, 0], [gusset, 0], [0, -gusset]]);
}

// Cinta: anel fechado que amarra as 4 cantoneiras. A abertura interna é o
// próprio bolso, então a pilha passa livre por dentro.
// Imprimibilidade: a face de baixo de cada anel é uma ponte entre os postes
// (74mm no lado comprido, 50mm no curto). Como a seção do anel tem 2mm, ela
// sai inteira em perímetro — as extrusões correm AO LONGO do vão, ancoradas
// nos dois postes. Só a 1a camada da cinta enruga; as de cima fecham normal.
module band(z0) {
    translate([0, 0, z0])
        difference() {
            cube([outer_w, outer_l, band_h]);
            translate([wall, wall, -0.5])
                cube([pocket_w, pocket_l, band_h + 1]);
        }
}

// Chapa de fundo: é o piso onde a pilha apoia. Vazada em colmeia (mesmo
// painel do deckbox-01) com borda sólida — a borda é justamente onde a
// chapa solda nas cantoneiras e nos filetes.
module base_plate() {
    translate([wall, wall, plate_z0])
        difference() {
            cube([pocket_w, pocket_l, plate_t]);
            hex_panel(pocket_w, pocket_l, plate_t);
        }
}

// Cinta de baixo: anel recuado que levanta a peça da mesa (dá pra enfiar o
// dedo por baixo) e trabalha como nervura da chapa.
module foot_rim() {
    w = pocket_w - 2 * foot_inset;
    l = pocket_l - 2 * foot_inset;
    translate([wall + foot_inset, wall + foot_inset, 0])
        difference() {
            cube([w, l, foot_h]);
            translate([wall, wall, -0.5])
                cube([w - 2 * wall, l - 2 * wall, foot_h + 1]);
        }
}

// Painel de furos hexagonais (colmeia) cobrindo o retângulo a x b no plano
// XY, atravessando a espessura t em Z, com `hex_margin` de borda sólida em
// volta. Conta antes quantas colunas/fileiras cabem INTEIRAS na área útil e
// CENTRALIZA o bloco — nenhum hexágono cortado (sem lascas na borda) e sem
// sobra torta de um lado só. Hexágonos de ponta pra cima (identidade do repo).
module hex_panel(a, b, t) {
    f  = hex_d;            // entre-faces
    R  = f / sqrt(3);      // circunraio (centro -> ponta)
    sx = f + hex_web;      // passo entre colunas
    sy = sx * sqrt(3) / 2; // passo entre fileiras (ímpares deslocam sx/2)

    ua = a - 2 * hex_margin; // área útil
    ub = b - 2 * hex_margin;

    // as fileiras ímpares deslocam sx/2, então a largura ocupada por nc
    // colunas é (nc-1)*sx + f + sx/2
    nc = floor((ua - f - sx / 2) / sx) + 1;
    nr = floor((ub - 2 * R) / sy) + 1;

    if (nc >= 1 && nr >= 1) {
        ox = hex_margin + (ua - ((nc - 1) * sx + f + sx / 2)) / 2;
        oy = hex_margin + (ub - ((nr - 1) * sy + 2 * R)) / 2;
        for (j = [0 : nr - 1], i = [0 : nc - 1])
            translate([ox + f / 2 + i * sx + (j % 2) * sx / 2, oy + R + j * sy, -0.1])
                rotate([0, 0, 30])
                    cylinder(h = t + 0.2, r = R, $fn = 6);
    }
}

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
if (part == "plate2") {
    // 2 unidades lado a lado — 146 x 94mm, folgado na cama da A1 mini
    holder();
    translate([outer_w + plate_gap, 0, 0]) holder();
} else {
    holder();
}
