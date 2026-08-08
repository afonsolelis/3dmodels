// pokemon-game.scad
// Plataforma de jogo pra Pokémon TCG: o campo de UM jogador, montado a
// partir de placas ("quadros") que se plugam por ímã, cada uma cabendo na
// cama da Bambu A1 mini. As zonas do jogo ficam em RELEVO — as cartas caem
// dentro de cavidades rasas e as paredes entre elas desenham o campo.
//
// Tamanho: playmat padrão de torneio é 610x356mm (24"x14"). Aqui o campo é
// 590 x 321mm — mais compacto, mas com folga pra jogar (dois tabuleiros
// impressos que serviram de referência têm 250 e 220 de profundidade).
//
// Zonas (jogador na borda de baixo, oponente em cima), conforme as regras:
//   - Banco: 5 cavidades na fileira de baixo, na frente do jogador
//   - Ativo: 1 cavidade centralizada acima do banco
//   - Prêmios: 6 numa GRADE 2x3 à ESQUERDA — a regra exige que fiquem do
//     lado OPOSTO ao deck/descarte. Cada carta tem seu bolso inteiro e sai
//     sem mexer nas vizinhas; é a terceira fileira de placas que permite
//     isso (com duas, uma carta de 93mm não cabia por fileira e os prêmios
//     precisavam se encavalar feito telha)
//   - Deck: rebaixo de 5mm no canto superior direito, onde a cestinha
//     encaixa (a cestinha é o deckbox no transporte)
//   - Descarte: rebaixo igual logo abaixo, pra cesta de descarte, que no
//     transporte guarda dados e contadores
//   - Lost Zone: cavidade na fileira do meio (a regra manda ficar fora do
//     mat, mas deck moderno usa direto — melhor ter o lugar)
//   - Estádio: cavidade na fileira de cima, alinhada com o ativo. Por regra
//     o estádio fica ENTRE os dois jogadores, e essa fileira é justamente a
//     que encosta no campo do oponente
//   - Bandeja de contadores e dish de moeda: os dois cantos da fileira de
//     cima que sobrariam vazios. Não são zonas de regra, são as duas coisas
//     que a mesa sempre precisa — onde despejar os contadores de dano e
//     onde jogar a moeda sem ela sair rolando pela mesa
//
// Construção da placa (7mm de espessura):
//   - pele de 2.4mm em cima, onde as cavidades de carta são escavadas
//   - miolo de colmeia hexagonal ABERTO POR BAIXO: a colmeia imprime a
//     partir da mesa e a pele fecha por cima em ponte curta, então não
//     precisa de suporte e a estrutura fica à vista por baixo
//   - moldura maciça na borda, onde moram os ímãs
// A espessura não é capricho: ímã 4x2 deitado na parede lateral exige
// 6.55mm no mínimo (4.15 do furo + 1.2 de material de cada lado).
//
// Encaixe entre placas: ímãs nas paredes LATERAIS, 2 por costura. Você
// encosta uma placa na outra e elas se plugam. Os furos são HEXAGONAIS de
// ponta pra cima — furo redondo na parede vertical imprimiria com o teto
// em balanço; o hexágono fecha em bico e sai limpo.
//
// POLARIDADE: em toda placa, os ímãs das faces DIREITA (+X) e de CIMA (+Y)
// entram com o mesmo polo pra fora (digamos, norte), e os das faces
// ESQUERDA (-X) e de BAIXO (-Y) com o polo oposto. Assim a direita de uma
// placa sempre atrai a esquerda da vizinha, em qualquer par do grid.
//
// IMPRIMIR SEM SUPORTE, com a face de jogo PRA CIMA (a colmeia aberta fica
// na mesa da impressora).
//
// Peças: 12 placas do campo (t<coluna>r<fileira>, 4 colunas x 3 fileiras).
// Cada placa é um job de impressão — não cabem duas na cama da A1 mini:
//   openscad -o 3mf/pokemon-game-t1r1.3mf -D 'part="t1r1"' pokemon-game.scad
//   ... idem t2r1..t4r1, t1r2..t4r2, t1r3..t4r3
// STLs individuais com os mesmos part=, em stl/.
// O case, a cestinha do deck e a cesta do descarte estão no arquivo irmão
// pokemon-game-case.scad; pokemon-game-overview.scad junta tudo numa
// grade, só pra ver o conjunto.

/* [Peça a renderizar] */
part = "field"; // "field" (campo montado, preview) | "t1r1".."t4r2"

/* [Carta com sleeve - medida real, régua do usuário em 2026-08-08] */
card_w   = 68; // mm, largura da carta com sleeve
card_h   = 93; // mm, altura da carta com sleeve
card_fit = 2;  // mm, folga total na cavidade (1mm por lado)

/* [Placa] */
plate_t  = 7.0; // mm, espessura total
skin_t   = 2.4; // mm, pele de cima (as cavidades são escavadas nela)
rail     = 2.4; // mm, moldura maciça na borda da placa
// Profundidade da cavidade de carta. 1.0 e não mais: uma carta com sleeve
// tem 0.75mm (45mm de pilha / 60 cartas), então numa cavidade de 1.5 ela
// afundava cercada por uma fresta de 1mm e não dava pra pegar sem unha.
// Com 1.0 a carta fica 0.25 abaixo do batente e sai arrastando com o dedo.
pocket_d = 1.0;

/* [Miolo de colmeia - aberto por baixo] */
core_af    = 9;   // mm, célula hexagonal entre faces (vão de ponte da pele)
core_rib   = 1.6; // mm, nervura entre células
core_inset = 6;   // mm, quanto a colmeia recua da borda (deixa a moldura maciça)

/* [Rebaixos do deck e do descarte] */
// Footprint dos contêineres — interface FIXA com pokemon-game-case.scad.
box_x     = 72.4; // mm, largura externa da cestinha/cesta
box_y     = 97.4; // mm, profundidade externa
box_fit   = 0.4;  // mm, folga por lado dentro do rebaixo
recess_d  = 5;    // mm, profundidade do rebaixo (sobram 2mm de fundo)

/* [Bandeja de contadores e dish de moeda] */
tray_w  = 100; // mm, bandeja de contadores de dano
tray_h  = 70;
tray_d  = 4;   // mm, profundidade (sobram 3mm de fundo)
coin_d  = 90;  // mm, diâmetro do dish onde a moeda é jogada
coin_dp = 4;   // mm, profundidade do dish

/* [Ímãs 4x2 nas paredes laterais] */
magnet_d     = 4;    // mm, diâmetro
magnet_h     = 2;    // mm, espessura
magnet_fit   = 0.15; // mm, folga de press-fit (padrão do repo)
magnet_sink  = 0.1;  // mm, quanto o ímã afunda abaixo da face
mag_at       = [0.3, 0.7]; // posição dos 2 ímãs ao longo de cada costura

/* [Textura hexagonal - faixa central gravada] */
hex_af   = 5;   // mm, hexágono entre faces
hex_web  = 1.6; // mm, material entre hexágonos
hex_deep = 0.5; // mm, profundidade da gravação

/* [Qualidade] */
$fn = 48;

// ---------------------------------------------------------------------
// Derivados — todo o mapa de zonas sai daqui
// ---------------------------------------------------------------------
well_w = card_w + card_fit; // 70, largura da cavidade de carta
well_h = card_h + card_fit; // 95, altura da cavidade de carta

rec_w = box_x + 2 * box_fit; // 73.2, rebaixo do contêiner
rec_h = box_y + 2 * box_fit; // 98.2

core_h  = plate_t - skin_t;          // 4.6, altura das nervuras
mag_af  = magnet_d + magnet_fit;     // 4.15, entre faces do furo hexagonal
mag_r   = mag_af / sqrt(3);
mag_dep = magnet_h + magnet_sink;    // 2.1, profundidade do furo

// X: prêmios (2 colunas) | banco (5) | deck/descarte.
// As bandas de 4mm são onde passam as costuras entre placas: cada lado
// fica com 2mm de parede inteira (costura no meio de uma parede de 2mm
// deixaria duas lascas de 1mm).
px1 = 2;                     // prêmio, coluna 1
px2 = px1 + well_w + 2;      // 74, coluna 2
bx1 = px2 + well_w + 4;      // 148, banco 1  (banda 144..148)
bx2 = bx1 + well_w + 2;      // 220, banco 2
bx3 = bx2 + well_w + 4;      // 294, banco 3 (banda 290..294)
bx4 = bx3 + well_w + 2;      // 366, banco 4
bx5 = bx4 + well_w + 4;      // 440, banco 5 (banda 436..440)
rec_x0 = bx5 + well_w + 2;   // 512, começo da zona de rebaixo
W = rec_x0 + rec_w + 2 * rail; // 590, largura do campo

// Y: 3 fileiras iguais — jogador (banco/descarte), meio (ativo/deck) e
// oponente (estádio). A fileira tem 107 e não 103 pra sobrar moldura de
// 4.4mm em volta do rebaixo do contêiner: com 103 o furo de ímã da costura
// encostava nele. E 107 comporta uma carta inteira (95) com 6mm de parede
// de cada lado da costura, que é o que faz os prêmios caberem em grade.
row_h  = rec_h + 2 * 4.4;    // 107
by     = 6;                  // base da cavidade dentro da fileira
H      = 3 * row_h;          // 321, profundidade do campo

// y da base da cavidade em cada fileira
row_y  = [by, row_h + by, 2 * row_h + by]; // 6, 113, 220

// bandeja de contadores e dish da moeda, centrados nas placas que sobrariam
// vazias na fileira de cima (coluna 2 e coluna 4)
tray_x = 146 + (146 - tray_w) / 2;   // 169
tray_y = 2 * row_h + (row_h - tray_h) / 2;
coin_cx = 438 + (W - 438) / 2;
coin_cy = 2 * row_h + row_h / 2;

// grid de placas: as costuras caem dentro das bandas de parede
colb = [0, 146, 292, 438, W];
rowb = [0, row_h, 2 * row_h, H];
n_cols = 4;
n_rows = 3;

// ---------------------------------------------------------------------
// Primitivas
// ---------------------------------------------------------------------
// hexágono de ponta pra cima, eixo em Z
module hex_prism(af, h) {
    rotate([0, 0, 30])
        cylinder(h = h, r = af / sqrt(3), $fn = 6);
}

// furo hexagonal de eixo horizontal (+X), ponta pra cima: é assim que ele
// imprime limpo numa parede vertical — o topo fecha em bico, não em teto
module hex_bore_x(len) {
    rotate([0, 90, 0])
        cylinder(h = len, r = mag_r, $fn = 6);
}

// cavidade rasa onde a carta cai, aberta pra cima
module pocket(x, y, w, h) {
    translate([x, y, plate_t - pocket_d])
        cube([w, h, pocket_d + 1]);
}

// rebaixo que recebe um contêiner (cestinha do deck / cesta do descarte)
module container_recess(x, y) {
    translate([x, y, plate_t - recess_d])
        cube([rec_w, rec_h, recess_d + 1]);
}

// faixa de hexágonos gravados, centrada EM CIMA da costura entre as duas
// fileiras: cada hexágono é serrado em duas metades iguais e o corte
// parece intencional. Hexágono que cavalga costura de coluna é pulado —
// sobraria um entalhe mais fino que uma extrusão na borda da placa.
module hex_band(yc) {
    n = floor((rec_x0 - 4) / (hex_af + hex_web));
    for (i = [0 : n - 1]) {
        cx = 2 + hex_af / 2 + i * (hex_af + hex_web);
        gap = min([for (s = [colb[1], colb[2], colb[3]]) abs(cx - s)]);
        if (gap > hex_af / 2 + 1)
            translate([cx, yc, plate_t - hex_deep])
                hex_prism(hex_af, hex_deep + 1);
    }
}

// ---------------------------------------------------------------------
// Zonas do campo (coordenadas do campo inteiro) — o que é escavado da
// placa maciça. Cada placa recorta a sua parte disto.
// ---------------------------------------------------------------------
module zone_cuts() {
    // prêmios: grade 2 colunas x 3 fileiras, uma carta inteira por bolso
    for (px = [px1, px2], y = row_y)
        pocket(px, y, well_w, well_h);

    // banco: 5 cavidades na frente do jogador
    for (bx = [bx1, bx2, bx3, bx4, bx5])
        pocket(bx, row_y[0], well_w, well_h);

    pocket(bx3, row_y[1], well_w, well_h); // ativo, centralizado sobre o banco
    pocket(bx1, row_y[1], well_w, well_h); // lost zone
    pocket(bx3, row_y[2], well_w, well_h); // estádio, alinhado com o ativo

    container_recess(rec_x0 + rail, 4.4);         // descarte, perto do jogador
    container_recess(rec_x0 + rail, row_h + 4.4); // deck, na fileira do meio

    // bandeja de contadores de dano (fileira de cima, coluna 2)
    translate([tray_x, tray_y, plate_t - tray_d])
        cube([tray_w, tray_h, tray_d + 1]);

    // dish da moeda (fileira de cima, coluna 4)
    translate([coin_cx, coin_cy, plate_t - coin_dp])
        cylinder(h = coin_dp + 1, d = coin_d);

    hex_band(rowb[1]);
    hex_band(rowb[2]);
}

// retângulos (em coordenadas do campo) que o miolo não pode invadir: embaixo
// de todo rebaixo o fundo tem que ficar maciço, senão a colmeia fura o piso
function solid_rects() = [
    [rec_x0 + rail, 4.4,          rec_w, rec_h],
    [rec_x0 + rail, row_h + 4.4,  rec_w, rec_h],
    [tray_x, tray_y, tray_w, tray_h],
    [coin_cx - coin_d / 2, coin_cy - coin_d / 2, coin_d, coin_d]
];

// ---------------------------------------------------------------------
// Miolo de colmeia da placa, aberto por baixo (z = 0 até core_h).
// Recua `core_inset` da borda pra deixar moldura maciça (é onde entram os
// ímãs) e pula as células que encostam nos rebaixos dos contêineres.
// ---------------------------------------------------------------------
module hex_core(tw, th, x0, y0) {
    pitch = core_af + core_rib;
    sy    = pitch * sqrt(3) / 2;
    r     = core_af / sqrt(3);

    for (j = [0 : ceil(th / sy)], i = [0 : ceil(tw / pitch)]) {
        cx = core_inset + core_af / 2 + i * pitch + (j % 2) * pitch / 2;
        cy = core_inset + r + j * sy;
        // célula inteira dentro da área útil?
        ok_edge = cx + core_af / 2 <= tw - core_inset
               && cy + r <= th - core_inset;
        // longe dos rebaixos? (teste em coordenadas do campo)
        ok_rec = min([for (rc = solid_rects())
                        max(rc[0] - 2 - (x0 + cx + core_af / 2),
                            (x0 + cx - core_af / 2) - (rc[0] + rc[2] + 2),
                            rc[1] - 2 - (y0 + cy + r),
                            (y0 + cy - r) - (rc[1] + rc[3] + 2))]) > 0;
        if (ok_edge && ok_rec)
            translate([cx, cy, -0.1])
                hex_prism(core_af, core_h + 0.1);
    }
}

// ---------------------------------------------------------------------
// Furos de ímã nas paredes laterais, 2 por costura interna. As posições
// são relativas ao próprio lado, então a placa vizinha (que tem a mesma
// medida naquele eixo) cai exatamente em cima.
// ---------------------------------------------------------------------
module magnet_bores(c, r, tw, th) {
    zc = plate_t / 2;
    for (f = mag_at) {
        if (c < n_cols) // face direita
            translate([tw - mag_dep, th * f, zc]) hex_bore_x(mag_dep + 0.1);
        if (c > 1)      // face esquerda
            translate([-0.1, th * f, zc]) hex_bore_x(mag_dep + 0.1);
        if (r < n_rows) // face de cima
            translate([tw * f, th - mag_dep, zc])
                rotate([0, 0, 90]) hex_bore_x(mag_dep + 0.1);
        if (r > 1)      // face de baixo
            translate([tw * f, -0.1, zc])
                rotate([0, 0, 90]) hex_bore_x(mag_dep + 0.1);
    }
}

// ---------------------------------------------------------------------
// Placa (c, r), já na origem e na orientação de impressão
// ---------------------------------------------------------------------
module tile(c, r) {
    x0 = colb[c - 1]; y0 = rowb[r - 1];
    tw = colb[c] - x0; th = rowb[r] - y0;

    difference() {
        cube([tw, th, plate_t]);
        translate([-x0, -y0, 0]) zone_cuts();
        hex_core(tw, th, x0, y0);
        magnet_bores(c, r, tw, th);
    }
}

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
if (part == "field") {
    for (c = [1 : n_cols], r = [1 : n_rows])
        translate([colb[c - 1], rowb[r - 1], 0])
            tile(c, r);
} else {
    // "t<c>r<r>" — validado, senão um typo renderiza vazio em silêncio e o
    // export "passa" sem nenhuma mensagem de erro
    assert(len(part) == 4 && part[0] == "t" && part[2] == "r",
           str("part inválido: '", part, "'. Use \"field\" ou \"t<coluna>r<fileira>\"."));
    c = ord(part[1]) - 48;
    r = ord(part[3]) - 48;
    assert(c >= 1 && c <= n_cols && r >= 1 && r <= n_rows,
           str("placa fora do grid ", n_cols, "x", n_rows, ": '", part, "'"));
    tile(c, r);
}
