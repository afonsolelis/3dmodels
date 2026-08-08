// pokemon-game.scad
// Plataforma de jogo pra Pokémon TCG: o campo de UM jogador, montado a
// partir de placas ("quadros") que se encaixam, cada uma cabendo na cama
// da Bambu A1 mini. As zonas do jogo ficam em RELEVO — as cartas caem
// dentro de cavidades rasas e as paredes entre elas desenham o campo.
//
// Tamanho: playmat padrão de torneio é 610x356mm (24"x14"), mas boa parte
// disso é margem vazia. Aqui o campo é 589.2 x 206mm — 45% menos área —
// porque só as zonas de fato entram, e os 6 prêmios ficam em cascata
// (uma carta encavalando a outra, feito telha) em vez de espalhados.
//
// Zonas (jogador na borda de baixo, oponente em cima), conforme as regras:
//   - Banco: 5 cavidades na fileira de baixo, na frente do jogador
//   - Ativo: 1 cavidade centralizada acima do banco
//   - Prêmios: 6 em cascata (2 colunas x 3), à ESQUERDA — a regra exige
//     que fiquem do lado OPOSTO ao deck/descarte
//   - Deck: moldura em relevo no canto superior direito, que recebe a
//     cestinha (pokemon-game-case.scad); a cestinha é o deckbox no
//     transporte
//   - Descarte: moldura igual logo abaixo, que recebe a cesta de descarte;
//     no transporte ela guarda dados e contadores
//   - Lost Zone: cavidade na área alta à esquerda (a regra manda ficar
//     fora do mat, mas deck moderno usa direto — melhor ter o lugar)
//   - Estádio: cavidade na borda de cima, à direita do ativo. Por regra o
//     estádio fica ENTRE os dois jogadores; aqui ele encosta na borda que
//     dá pro oponente, que é o mais perto disso num campo de 1 jogador
//
// Encaixe entre placas: 3 linguetas por costura, que entram em bolsos na
// vizinha. As placas descem no lugar verticalmente — nada de deslizar em
// duas direções ao mesmo tempo, que é o que trava encaixe tipo
// rabo-de-andorinha num grid 2D. As linguetas são segmentadas de
// propósito: uma lingueta corrida ao longo da costura inteira (a) faria o
// teto do bolso imprimir em balanço puro, (b) esbarraria na lingueta da
// placa vizinha nos vértices do grid e (c) seria uma aba fina e comprida
// na primeira camada, que é a geometria clássica de encanoar. Segmentada,
// cada bolso vira uma ponte curta ancorada em 3 lados, e as próprias
// linguetas travam o deslize (dispensam detente).
//
// IMPRIMIR SEM SUPORTE. Se o fatiador gerar suporte automático, ele enche
// os bolsos das linguetas (1.8mm de altura) e a junta morre.
//
// Peças: 8 placas do campo (t<coluna>r<fileira>). Cada placa é um job de
// impressão — não cabem duas na cama da A1 mini (cada uma tem ~152x109):
//   openscad -o 3mf/pokemon-game-t1r1.3mf -D 'part="t1r1"' pokemon-game.scad
//   ... idem t2r1, t3r1, t4r1, t1r2, t2r2, t3r2, t4r2
// STLs individuais com os mesmos part=, em stl/.
// O case, a cestinha do deck e a cesta do descarte estão no arquivo
// irmão pokemon-game-case.scad.

/* [Peça a renderizar] */
part = "field"; // "field" (campo montado, preview) | "t1r1".."t4r2"

/* [Carta com sleeve - medida real, régua do usuário em 2026-08-08] */
card_w   = 68; // mm, largura da carta com sleeve
card_h   = 93; // mm, altura da carta com sleeve
card_fit = 2;  // mm, folga total na cavidade (1mm por lado)

/* [Placa] */
plate_t  = 3;   // mm, espessura da base da placa
// Altura do relevo = profundidade da cavidade. 1.0 e não mais: uma carta
// com sleeve tem 0.75mm (45mm de pilha / 60 cartas), então numa cavidade
// de 1.5 ela afundava 0.75mm cercada por uma fresta de 1mm — não dava pra
// pegar sem unha. Com 1.0 a carta fica 0.25 abaixo do batente e sai
// arrastando com a polpa do dedo; o relevo continua legível e tátil.
relief_h = 1.0;

/* [Molduras do deck e do descarte] */
// Footprint dos contêineres — interface FIXA com pokemon-game-case.scad.
box_x      = 72.4; // mm, largura externa da cestinha/cesta
box_y      = 97.4; // mm, profundidade externa
box_fit    = 0.4;  // mm, folga por lado dentro da moldura
frame_wall = 2;    // mm, parede da moldura
frame_h    = 6;    // mm, altura da moldura acima da superfície da placa

/* [Encaixe entre placas] */
// A lingueta é mais FINA que o bolso de propósito: a placa se apoia na
// mesa pelo próprio corpo, não pela lingueta. Espessuras múltiplas de
// 0.2mm (altura de camada) pra folga não virar loteria de fatiamento:
// 1.2 = 6 camadas, 1.8 = 9 camadas, sobra 0.6mm — que engole tanto a
// barriga da ponte quanto a pata de elefante da primeira camada.
lap      = 5;   // mm, avanço da lingueta pra dentro da vizinha
tab_len  = 20;  // mm, comprimento de cada lingueta (3 por costura)
ledge_t  = 1.2; // mm, espessura da lingueta (6 camadas)
recess_t = 1.8; // mm, profundidade do bolso (9 camadas)
lap_fit  = 0.2; // mm, folga do bolso por lado

/* [Textura hexagonal - faixa central] */
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

frame_ow = box_x + 2 * box_fit + 2 * frame_wall; // 77.2
frame_oh = box_y + 2 * box_fit + 2 * frame_wall; // 102.2

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
frame_x = bx5 + well_w + 2;  // 512, moldura deck/descarte
W = frame_x + frame_ow;      // 589.2, largura do campo

// Y: fileira do jogador (banco/descarte) | fileira do oponente (ativo/deck)
by     = 4;                  // banco, base da cavidade
band_y = by + well_h;        // 99, começo da faixa central
ay     = band_y + 9;         // 108, ativo, base da cavidade
H      = ay + well_h + 3;    // 206, profundidade do campo

// prêmios em cascata: as duas de baixo são bolsos curtos (a carta
// encavala a de cima), a de cima é bolso inteiro
p1y = by;  p1h = 49;
p2y = 55;  p2h = band_y - p2y; // 44
p3y = ay;  p3h = well_h;

disc_fy = (band_y + 4 - frame_oh) / 2; // 0.4, moldura do descarte (fileira 1)
deck_fy = 103 + 0.4;                   // 103.4, moldura do deck (fileira 2)

// grid de placas: as costuras caem dentro das bandas de parede
colb = [0, 146, 292, 438, W];
rowb = [0, 103, H];
n_cols = 4;
n_rows = 2;

// ---------------------------------------------------------------------
// Primitivas
// ---------------------------------------------------------------------
// hexágono de ponta pra cima (a ponta vira o topo na parede vertical e a
// gravação fica coerente com a colmeia do resto do repo)
module hex_prism(af, h) {
    rotate([0, 0, 30])
        cylinder(h = h, r = af / sqrt(3), $fn = 6);
}

// cavidade rasa onde a carta cai, aberta pra cima
module pocket(x, y, w, h) {
    translate([x, y, plate_t])
        cube([w, h, relief_h + 1]);
}

// Moldura que recebe um contêiner (cestinha do deck / cesta do descarte).
// Ocupa a fileira inteira em Y (`h`) em vez de sobrar 0.4mm de cada lado:
// tira de 0.4mm é mais fina que uma extrusão, o fatiador descarta ou faz
// gap-fill sujo ali.
module container_frame(x, y, h) {
    inner_y = box_y + 2 * box_fit;
    difference() {
        translate([x, y, plate_t + relief_h])
            cube([frame_ow, h, frame_h]);
        translate([x + frame_wall, y + (h - inner_y) / 2, plate_t + relief_h - 0.1])
            cube([box_x + 2 * box_fit, inner_y, frame_h + 0.2]);
    }
}

// faixa de hexágonos gravados no meio do campo, na parede larga que separa
// a fileira do banco da fileira do ativo (some sob as cartas? não: é a
// única faixa de material que fica à vista o jogo inteiro)
// Centrada EM CIMA da costura (yc = 103, não 103.5): assim cada hexágono é
// serrado em duas metades iguais e o corte parece intencional. Hexágono que
// cavalga costura de coluna é pulado — sobraria um entalhe mais estreito
// que uma extrusão na borda da placa, que sai rasgado.
module hex_band() {
    yc = rowb[1];
    n  = floor((frame_x - 4) / (hex_af + hex_web));
    for (i = [0 : n - 1]) {
        cx = 2 + hex_af / 2 + i * (hex_af + hex_web);
        gap = min([for (s = [colb[1], colb[2], colb[3]]) abs(cx - s)]);
        if (gap > hex_af / 2 + 1)
            translate([cx, yc, plate_t + relief_h - hex_deep])
                hex_prism(hex_af, hex_deep + 1);
    }
}

// ---------------------------------------------------------------------
// Campo inteiro (é daqui que cada placa é recortada)
// ---------------------------------------------------------------------
module field_solid() {
    difference() {
        cube([W, H, plate_t + relief_h]);

        // prêmios: 2 colunas x 3 fileiras em cascata
        for (px = [px1, px2]) {
            pocket(px, p1y, well_w, p1h);
            pocket(px, p2y, well_w, p2h);
            pocket(px, p3y, well_w, p3h);
        }

        // banco: 5 cavidades na frente do jogador
        for (bx = [bx1, bx2, bx3, bx4, bx5])
            pocket(bx, by, well_w, well_h);

        // ativo: centralizado sobre o banco
        pocket(bx3, ay, well_w, well_h);

        // lost zone: área alta à esquerda, do lado dos prêmios
        pocket(bx1, ay, well_w, well_h);

        // estádio: encostado na borda que dá pro oponente
        pocket(bx4, ay, well_w, well_h);

        hex_band();
    }

    container_frame(frame_x, 0, rowb[1]);              // descarte, perto do jogador
    container_frame(frame_x, rowb[1], H - rowb[1]);    // deck, do lado do oponente
}

// ---------------------------------------------------------------------
// Placa (c, r): recorte do campo + linguetas.
// Convenção: a placa da ESQUERDA avança linguetas por baixo da direita, e
// a de BAIXO por baixo da de cima. Assim toda placa desce no lugar na
// ordem esquerda->direita, baixo->cima.
// As linguetas ficam a 25%, 50% e 75% da costura — longe dos vértices do
// grid, onde uma lingueta de coluna e uma de fileira disputariam o mesmo
// volume e deixariam a placa balançando 1.2mm no ar.
// ---------------------------------------------------------------------
tab_at = [0.25, 0.5, 0.75];
module tile(c, r) {
    x0 = colb[c - 1]; x1 = colb[c];
    y0 = rowb[r - 1]; y1 = rowb[r];
    tw = x1 - x0; th = y1 - y0;

    difference() {
        union() {
            intersection() {
                field_solid();
                translate([x0, y0, -1])
                    cube([tw, th, plate_t + relief_h + frame_h + 2]);
            }

            // linguetas macho: avançam pra dentro da vizinha
            if (c < n_cols)
                for (f = tab_at)
                    translate([x1, y0 + th * f - tab_len / 2, 0])
                        cube([lap, tab_len, ledge_t]);
            if (r < n_rows)
                for (f = tab_at)
                    translate([x0 + tw * f - tab_len / 2, y1, 0])
                        cube([tab_len, lap, ledge_t]);
        }

        // bolsos fêmea: recebem as linguetas da vizinha. Abertos por baixo e
        // pela costura, fechados nos outros 3 lados — o teto vira ponte curta
        // ancorada, não balanço.
        if (c > 1)
            for (f = tab_at)
                translate([x0 - 0.1, y0 + th * f - tab_len / 2 - lap_fit, -0.1])
                    cube([lap + lap_fit + 0.1, tab_len + 2 * lap_fit,
                          recess_t + 0.1]);
        if (r > 1)
            for (f = tab_at)
                translate([x0 + tw * f - tab_len / 2 - lap_fit, y0 - 0.1, -0.1])
                    cube([tab_len + 2 * lap_fit, lap + lap_fit + 0.1,
                          recess_t + 0.1]);
    }
}

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
// cada placa é exportada na origem, deitada, relevo pra cima: é assim que
// imprime (sem suporte, primeira camada = a face de baixo, lisa)
module place_at_origin(c, r) {
    translate([-colb[c - 1], -rowb[r - 1], 0])
        tile(c, r);
}

if (part == "field") {
    for (c = [1 : n_cols], r = [1 : n_rows])
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
    place_at_origin(c, r);
}
