// pokemon-game-case.scad
// Contêineres e maleta do projeto "pokemon-game" (plataforma de jogo de
// Pokémon TCG). As PLACAS DO CAMPO são modeladas à parte, em
// playmats/pokemon-game/pokemon-game.scad — este arquivo NÃO as contém.
//
// São 4 peças:
//
// 1) "deck_basket" — cestinha do deck. Uma cesta de paredes finas vazadas em
//    colmeia que segura o deck de 60 cartas COM sleeve (93x68x45 medido com
//    régua). Durante a partida ela ENCAIXA na moldura em relevo da zona de
//    deck do campo (a moldura foi feita pro footprint externo 72.4x97.4 com
//    0.4mm de folga por lado) e fica ali segurando o deck em pé, à mão. No
//    transporte a mesma peça é a deckbox: o deck viaja dentro dela. Os
//    recortes em U nas duas laterais compridas descem até o chão da cesta —
//    é por eles que o dedo pinça a pilha até a ÚLTIMA carta.
//
// 2) "discard_tray" — cesta do descarte. MESMO footprint externo 72.4x97.4
//    (as duas molduras do campo são iguais e intercambiáveis), 30mm de
//    altura. Não é uma cesta fechada: os quatro lados têm escalopes
//    generosos que descem até 8mm do chão, então dá pra enfiar o dedo por
//    qualquer lado e tirar a pilha de descarte inteira sem catar carta por
//    carta. O chão é INTEIRO (só relevo hexagonal rebaixado, nada passante)
//    porque no transporte esta cesta vira o porta-dados/contadores.
//
// 3) "game_case" — a maleta. Guarda a pilha inteira das 9 placas do campo no
//    fundo e, EM CIMA delas, os dois contêineres lado a lado (72.4+72.4 =
//    144.8mm). Vazia, é a bandeja de rolar dado: o chão interno tem colmeia
//    em BAIXO relevo (não passante) que amortece e freia o dado. No topo do
//    rebordo ficam 6 ímãs 4x2mm; como a parede tem só 2.4mm, cada ímã ganha
//    um RESSALTO interno local (boss) que engrossa a parede pra 7.0mm
//    naquele ponto. Os ressaltos começam bem acima da pilha de placas e
//    entram com rampa a 45°, então não atrapalham as placas nem precisam de
//    suporte.
//
// 4) "case_lid" — a tampa. Painel plano do tamanho exato do exterior da
//    maleta, com uma saia que entra no interior (0.3mm de folga por lado)
//    pra centralizar e não deixar deslizar. 6 rebaixos de ímã espelhando
//    EXATAMENTE os 6 da maleta — as duas peças são modeladas na MESMA
//    origem (canto do retângulo externo) e leem a MESMA lista `magnets`,
//    então os pares fecham centro com centro por construção. Pra abrir: os
//    dois entalhes no topo das paredes compridas da maleta deixam um vão de
//    5mm de altura sob a borda da tampa (a saia é interrompida ali) — enfia
//    o dedo e levanta. O escalope na cara de cima da tampa marca o lugar.
//
// ÍMÃS: 12 discos 4x2mm (6 na maleta + 6 na tampa), press-fit 0.15.
//   - Na maleta o rebaixo é ABERTO POR CIMA (entra pelo topo do rebordo,
//     imprime sem ponte nenhuma).
//   - Na tampa o rebaixo é CEGO, aberto pra baixo, com 1.9mm de teto sólido
//     (1.3mm depois do relevo hexagonal da cara de cima). Como a tampa
//     imprime de cabeça pra baixo, esse rebaixo vira um furo cego virado pra
//     CIMA na chapa — também sem ponte.
//   - Todos os 6 da maleta com o MESMO polo pra cima; todos os 6 da tampa
//     com o polo oposto. Um pingo de cola CA em cada um se ficar frouxo.
//
// STL de cada peça:
//   openscad -o stl/pokemon-game-deck-basket.stl  -D 'part="deck_basket"'  pokemon-game-case.scad
//   openscad -o stl/pokemon-game-discard-tray.stl -D 'part="discard_tray"' pokemon-game-case.scad
//   openscad -o stl/pokemon-game-case.stl         -D 'part="game_case"'    pokemon-game-case.scad
//   openscad -o stl/pokemon-game-lid.stl          -D 'part="case_lid"'     pokemon-game-case.scad
//
// 3MF — 3 jobs de impressão (cama Bambu A1 mini 180x180), TODOS sem suporte:
//   openscad -o 3mf/pokemon-game-case.3mf       -D 'part="plate_case"'       pokemon-game-case.scad
//   openscad -o 3mf/pokemon-game-lid.3mf        -D 'part="plate_lid"'        pokemon-game-case.scad
//   openscad -o 3mf/pokemon-game-containers.3mf -D 'part="plate_containers"' pokemon-game-case.scad
//
// Orientações de impressão das chapas:
//   plate_case       — maleta de BOCA PRA CIMA (fundo na cama). Sem ponte.
//   plate_lid        — tampa de CABEÇA PRA BAIXO: a cara de cima na cama
//                      (ganha o acabamento da placa) e a saia apontando pra
//                      cima. É a única orientação sem suporte — com a saia
//                      pra baixo o painel inteiro ficaria no ar. Custo: os
//                      hexágonos rebaixados da cara de cima fecham com uma
//                      ponte curta (0.6mm de altura, vão de 10mm), o que a
//                      A1 mini faz limpo.
//   plate_containers — cestinha do deck + cesta do descarte lado a lado,
//                      ambas de boca pra cima.
//
// Previews de conferência (não são peças):
//   part="assembled" — maleta fechada com a tampa, e em fantasma (%) a pilha
//                      das 9 placas + os dois contêineres em cima delas
//   part="all"       — as 4 peças espalhadas, não montadas

/* [Peça a renderizar] */
part = "all"; // "deck_basket" | "discard_tray" | "game_case" | "case_lid" | "plate_case" | "plate_lid" | "plate_containers" | "assembled" (preview fechado + conteúdo em fantasma) | "all" (preview de tudo, não montado)

/* [Deck de 60 cartas COM sleeve - medido com régua] */
// Medido em 2026-08-08: 93 x 68 x 45 mm. Trocou de sleeve, mede de novo.
deck_w = 68; // mm, largura da carta com sleeve (vira X da cestinha)
deck_l = 93; // mm, altura da carta com sleeve (vira Y da cestinha)
deck_h = 45; // mm, altura da pilha das 60 cartas (vira Z)

/* [Contêineres - footprint externo FIXO] */
// NÃO MEXER: as molduras em relevo das placas do campo (pokemon-game.scad)
// já foram exportadas dimensionadas pra receber exatamente este retângulo
// com 0.4mm de folga por lado.
cont_x = 72.4; // mm, largura externa dos dois contêineres
cont_y = 97.4; // mm, profundidade externa dos dois contêineres

/* [Cestinha do deck] */
basket_wall  = 1.2; // mm, paredes (72.4-2*1.2 = 70 internos = deck + 1mm/lado)
basket_floor = 1.6; // mm, chão
basket_lip   = 3.4; // mm, quanto a parede sobe acima da pilha de cartas
basket_cut_w = 40;  // mm, largura do recorte em U das duas laterais compridas
basket_cut_r = 6;   // mm, raio dos cantos de baixo do U

/* [Cesta do descarte] */
discard_h          = 30;  // mm, altura externa
discard_wall       = 1.2; // mm, paredes
discard_floor      = 1.6; // mm, chão INTEIRO (sem furo: guarda dados no transporte)
discard_band       = 8;   // mm, faixa de parede sólida que sobra abaixo dos escalopes
discard_cut_long   = 52;  // mm, largura do escalope nas paredes compridas (97.4)
discard_cut_short  = 34;  // mm, largura do escalope nas paredes curtas (72.4)
discard_cut_r      = 6;   // mm, raio dos cantos de baixo dos escalopes
discard_floor_relief = 0.6; // mm, profundidade do relevo hexagonal do chão (de 1.6)

/* [Maleta - interior dimensionado pelas placas REAIS do campo] */
// Placas medidas com bbox.py: a maior é 152.0 x 109.0; a pilha das 9 dá
// 6x4.5 + 2x10.5 + 4.5 = 52.5mm. Em cima delas entram os dois contêineres
// lado a lado (144.8 x 97.4) — a cestinha do deck é a mais alta, 50mm.
case_in_x  = 158; // mm, interior X (placa 152.0 -> 3.0/lado; contêineres 144.8 -> 6.6/lado)
case_in_y  = 113; // mm, interior Y (placa 109.0 -> 2.0/lado; contêineres 97.4 -> 7.8/lado)
case_in_z  = 106; // mm, interior Z (52.5 de placas + 50 da cestinha + 3.5 de folga)
case_wall  = 2.4; // mm, paredes e fundo
case_floor_relief = 0.9; // mm, profundidade da colmeia em baixo relevo do chão (de 2.4)

/* [Placas do campo - só conferência, geometria mora em pokemon-game.scad] */
plates_stack_h = 52.5;  // mm, altura da pilha das 9 placas
plate_max_x    = 152.0; // mm, maior placa em X
plate_max_y    = 109.0; // mm, maior placa em Y

/* [Tampa] */
lid_t        = 4.0; // mm, espessura do painel (2.1 de rebaixo de ímã + 1.9 de teto)
lid_skirt_h  = 6;   // mm, quanto a saia desce pra dentro do interior
lid_skirt_t  = 2.4; // mm, espessura da saia
lid_clear    = 0.3; // mm, folga por lado entre saia e interior (peça solta em cavidade)
lid_chamfer  = 1;   // mm, chanfro 45° na borda de cima (vira o 1º layer na chapa)
lid_relief   = 0.6; // mm, profundidade do relevo hexagonal da cara de cima

/* [Ímãs disco 4x2mm - 6 na maleta + 6 na tampa] */
magnet_d      = 4;    // mm, diâmetro
magnet_h      = 2;    // mm, espessura
magnet_fit    = 0.15; // mm, folga de press-fit (padrão do repo)
magnet_sink   = 0.1;  // mm, quanto o ímã afunda abaixo da face (rebaixo = 2.1)
boss_t        = 4.6;  // mm, quanto o ressalto engrossa a parede PRA DENTRO (2.4+4.6 = 7.0)
boss_w        = 9;    // mm, largura do ressalto ao longo da parede
boss_above_floor = 61; // mm, altura (a partir do chão interno) em que o ressalto começa
magnet_x_inset = 42;  // mm, X dos ímãs das paredes compridas (e o espelho, out_x - 42)

/* [Puxador da tampa] */
grip_w             = 30;  // mm, largura do entalhe no topo da parede comprida da maleta
grip_depth         = 5;   // mm, quanto o entalhe afunda o rebordo (= altura do vão pro dedo)
grip_r             = 4;   // mm, raio dos cantos de baixo do entalhe
grip_scallop_len   = 30;  // mm, comprimento do escalope decorativo na cara de cima da tampa
grip_scallop_r     = 5;   // mm, raio (metade da largura) do escalope
grip_scallop_depth = 1.0; // mm, profundidade do escalope
grip_scallop_inset = 8;   // mm, distância do centro do escalope até a borda da tampa

/* [Colmeia - identidade visual do repo, hexágonos de PONTA PRA CIMA] */
hex_d      = 8;   // mm, entre-faces do hexágono (paredes/chão da cestinha do deck)
hex_web    = 2;   // mm, material entre furos vizinhos
hex_margin = 2.5; // mm, borda sólida em volta de cada painel
hex_s_d      = 6;   // mm, colmeia fina (paredes estreitas da cesta do descarte)
hex_s_web    = 1.8;
hex_s_margin = 2.2;
hex_l_d      = 10;  // mm, colmeia graúda (chão da maleta e cara de cima da tampa)
hex_l_web    = 2.5;
hex_l_margin = 6;

/* [Qualidade] */
$fn = 48;

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
basket_h    = basket_floor + deck_h + basket_lip; // 50.0
basket_in_x = cont_x - 2 * basket_wall;           // 70 = deck_w + 1mm/lado
basket_in_y = cont_y - 2 * basket_wall;           // 95 = deck_l + 1mm/lado
basket_in_z = basket_h - basket_floor;

discard_in_x = cont_x - 2 * discard_wall;
discard_in_y = cont_y - 2 * discard_wall;
discard_cut_z = discard_floor + discard_band; // fundo dos escalopes

case_out_x = case_in_x + 2 * case_wall;
case_out_y = case_in_y + 2 * case_wall;
case_out_z = case_in_z + case_wall; // topo aberto: só o fundo entra na conta

// espessura local da parede no ressalto e profundidade do centro do ímã
boss_T    = case_wall + boss_t;   // 7.0
mag_depth = boss_T / 2;           // 3.5 -> sobra (7.0-4.15)/2 = 1.425mm de cada lado do furo
boss_z0   = case_wall + boss_above_floor; // z onde o ressalto fica com a seção cheia
boss_ramp_z = boss_z0 - boss_t;           // início da rampa 45° (abaixo disso, parede lisa)

mag_pocket_d = magnet_d + magnet_fit;  // 4.15
mag_pocket_h = magnet_h + magnet_sink; // 2.1

// FONTE ÚNICA das posições de ímã, em coordenadas do retângulo EXTERNO
// (0,0 = canto da maleta E canto da tampa). Maleta e tampa leem esta mesma
// lista, então os pares fecham centro com centro por construção — foi
// exatamente aqui que o deckbox-01 errou (referenciais diferentes).
// Formato: [cx, cy, nx, ny] com (nx,ny) = normal apontando PRA DENTRO.
magnets = [
    [magnet_x_inset,              mag_depth,              0,  1],
    [case_out_x - magnet_x_inset, mag_depth,              0,  1],
    [magnet_x_inset,              case_out_y - mag_depth, 0, -1],
    [case_out_x - magnet_x_inset, case_out_y - mag_depth, 0, -1],
    [mag_depth,                   case_out_y / 2,         1,  0],
    [case_out_x - mag_depth,      case_out_y / 2,        -1,  0],
];

grip_cx = case_out_x / 2; // entalhes de puxador no meio das duas paredes compridas

lid_x      = case_out_x;
lid_y      = case_out_y;
skirt_x0   = case_wall + lid_clear;      // 2.7 (interior começa em 2.4)
skirt_y0   = case_wall + lid_clear;
skirt_ox   = case_in_x - 2 * lid_clear;  // saia externa
skirt_oy   = case_in_y - 2 * lid_clear;
skirt_gap_w = grip_w + 4;                // a saia some nos puxadores, pro dedo entrar

// alturas empilhadas dentro da maleta (conferência)
stack_top_z     = case_wall + plates_stack_h;              // topo da pilha de placas
basket_top_z    = stack_top_z + basket_h;                  // topo da cestinha do deck
cont_free_x     = case_in_x - 2 * cont_x;                  // folga total dos 2 contêineres em X
cont_boss_clr_x = (case_in_x - 2 * cont_x) / 2 - boss_t;   // folga contêiner <-> ressalto (X)
cont_boss_clr_y = (case_in_y - cont_y) / 2 - boss_t;       // folga contêiner <-> ressalto (Y)

echo(str("cestinha do deck  ext = ", cont_x, " x ", cont_y, " x ", basket_h,
         "  int = ", basket_in_x, " x ", basket_in_y, " x ", basket_in_z));
echo(str("cesta do descarte ext = ", cont_x, " x ", cont_y, " x ", discard_h,
         "  int = ", discard_in_x, " x ", discard_in_y, " x ", discard_h - discard_floor));
echo(str("maleta ext = ", case_out_x, " x ", case_out_y, " x ", case_out_z,
         "  int = ", case_in_x, " x ", case_in_y, " x ", case_in_z));
echo(str("tampa  ext = ", lid_x, " x ", lid_y, " x ", lid_t + lid_skirt_h));
echo(str("placas: maior ", plate_max_x, " x ", plate_max_y, " -> folga ",
         (case_in_x - plate_max_x) / 2, "/lado em X e ",
         (case_in_y - plate_max_y) / 2, "/lado em Y"));
echo(str("pilha: placas ", plates_stack_h, " + cestinha ", basket_h, " = ",
         plates_stack_h + basket_h, " (interior ", case_in_z, ")"));
echo(str("ressalto do ima: comeca em z=", boss_z0, " (rampa a partir de ", boss_ramp_z,
         "), topo da pilha de placas em z=", stack_top_z));
echo(str("folga contêiner <-> ressalto: X=", cont_boss_clr_x, "/lado  Y=", cont_boss_clr_y, "/lado"));
echo(str("parede no ima = ", boss_T, "mm, furo ", mag_pocket_d,
         " -> ", (boss_T - mag_pocket_d) / 2, "mm de material de cada lado"));
echo(str("teto solido sobre o ima da tampa = ", lid_t - mag_pocket_h,
         "mm (", lid_t - mag_pocket_h - lid_relief, "mm depois do relevo)"));

// ---------------------------------------------------------------------
// Colmeia (adaptada do deckbox-01: mesma malha, agora com tamanho de célula
// por chamada e com uma variante em BAIXO RELEVO, que não atravessa).
// Hexágonos de ponta pra cima: em parede vertical cada furo fecha em bico,
// sem ponte reta.
// ---------------------------------------------------------------------

// Malha de prismas hexagonais cobrindo o retângulo a x b no plano XY, com
// altura h em +Z a partir de z=0. Só entra hexágono que caiba INTEIRO na
// área útil (borda sólida `mg`). `skip_w` reserva uma faixa central sem
// furos ao longo de `a` — é o que evita lasca fina na beira dos recortes.
module hex_cells(a, b, h, skip_w = 0, f = hex_d, web = hex_web, mg = hex_margin) {
    R  = f / sqrt(3);      // circunraio (centro -> ponta)
    sx = f + web;          // passo entre colunas
    sy = sx * sqrt(3) / 2; // passo entre fileiras (ímpares deslocam sx/2)

    for (j = [0 : ceil(b / sy)], i = [0 : ceil(a / sx)]) {
        cx = mg + f / 2 + i * sx + (j % 2) * sx / 2;
        cy = mg + R + j * sy;
        in_skip = skip_w > 0
            && cx + f / 2 > a / 2 - skip_w / 2 - mg
            && cx - f / 2 < a / 2 + skip_w / 2 + mg;
        if (cx + f / 2 <= a - mg && cy + R <= b - mg && !in_skip)
            translate([cx, cy, 0])
                rotate([0, 0, 30])
                    cylinder(h = h, r = R, $fn = 6);
    }
}

// Vazado PASSANTE numa chapa de espessura t apoiada em z=0.
module hex_panel(a, b, t, skip_w = 0, f = hex_d, web = hex_web, mg = hex_margin) {
    translate([0, 0, -0.1]) hex_cells(a, b, t + 0.2, skip_w, f, web, mg);
}

// Baixo relevo: cava `d` PRA BAIXO a partir da superfície em z=0. Usado no
// chão da maleta e na cara de cima da tampa — nunca vira furo passante.
module hex_relief(a, b, d, skip_w = 0, f = hex_l_d, web = hex_l_web, mg = hex_l_margin) {
    translate([0, 0, -d]) hex_cells(a, b, d + 0.05, skip_w, f, web, mg);
}

// ---------------------------------------------------------------------
// Recorte em U / escalope: aberto no topo, cantos de baixo arredondados,
// atravessando uma parede no plano XZ (normal +Y) que começa em y0 e tem
// espessura t. `cx` é o centro ao longo de X, `zb` o fundo do U e `h` o
// quanto ele sobe (é só passar a altura da peça).
// ---------------------------------------------------------------------
module u_cutout(cx, y0, t, w, r, zb, h) {
    translate([0, y0 - 0.1, 0]) {
        hull()
            for (xx = [cx - w / 2 + r, cx + w / 2 - r])
                translate([xx, 0, zb + r])
                    rotate([-90, 0, 0])
                        cylinder(h = t + 0.2, r = r);
        translate([cx - w / 2, 0, zb + r])
            cube([w, t + 0.2, h]);
    }
}

// ---------------------------------------------------------------------
// 1) Cestinha do deck
// Cesta de boca aberta, deck deitado dentro (as 60 cartas empilhadas em Z).
// Encaixa na moldura da zona de deck do campo; no transporte é a deckbox.
// Chão e as 4 paredes vazados em colmeia; recorte em U até o chão nas duas
// laterais compridas, com faixa sólida em volta (skip_w) pra não sobrar
// lasca fina na beira do U.
// ---------------------------------------------------------------------
module deck_basket() {
    difference() {
        cube([cont_x, cont_y, basket_h]);

        // cavidade (chão embaixo, topo aberto)
        translate([basket_wall, basket_wall, basket_floor])
            cube([basket_in_x, basket_in_y, basket_h]);

        // recortes em U nas duas laterais COMPRIDAS (paredes normais a X)
        for (xx = [basket_wall, cont_x])
            translate([xx, 0, 0])
                rotate([0, 0, 90])
                    u_cutout(cont_y / 2, 0, basket_wall,
                             basket_cut_w, basket_cut_r, basket_floor, basket_h);

        // colmeia do chão
        translate([basket_wall, basket_wall, 0])
            hex_panel(basket_in_x, basket_in_y, basket_floor);

        // colmeia das laterais compridas (faixa central reservada pro U)
        for (xx = [0, cont_x - basket_wall])
            translate([xx, 0, basket_floor])
                rotate([90, 0, 90])
                    hex_panel(cont_y, basket_in_z, basket_wall, skip_w = basket_cut_w);

        // colmeia das laterais curtas
        for (yy = [basket_wall, cont_y])
            translate([0, yy, basket_floor])
                rotate([90, 0, 0])
                    hex_panel(cont_x, basket_in_z, basket_wall);
    }
}

// ---------------------------------------------------------------------
// 2) Cesta do descarte
// Mesmo footprint da cestinha do deck (as molduras do campo são iguais).
// Escalopes nos QUATRO lados descendo até `discard_band` do chão: o dedo
// entra por qualquer lado e tira a pilha de descarte inteira. Chão inteiro,
// só com colmeia em baixo relevo — no transporte esta cesta leva os dados.
// ---------------------------------------------------------------------
module discard_tray() {
    wall_z = discard_h - discard_floor;

    difference() {
        cube([cont_x, cont_y, discard_h]);

        translate([discard_wall, discard_wall, discard_floor])
            cube([discard_in_x, discard_in_y, discard_h]);

        // escalopes das paredes compridas (normais a X)
        for (xx = [discard_wall, cont_x])
            translate([xx, 0, 0])
                rotate([0, 0, 90])
                    u_cutout(cont_y / 2, 0, discard_wall,
                             discard_cut_long, discard_cut_r, discard_cut_z, discard_h);

        // escalopes das paredes curtas (normais a Y)
        for (y0 = [0, cont_y - discard_wall])
            u_cutout(cont_x / 2, y0, discard_wall,
                     discard_cut_short, discard_cut_r, discard_cut_z, discard_h);

        // colmeia fina no que sobra das paredes
        for (xx = [0, cont_x - discard_wall])
            translate([xx, 0, discard_floor])
                rotate([90, 0, 90])
                    hex_panel(cont_y, wall_z, discard_wall, skip_w = discard_cut_long,
                              f = hex_s_d, web = hex_s_web, mg = hex_s_margin);
        for (yy = [discard_wall, cont_y])
            translate([0, yy, discard_floor])
                rotate([90, 0, 0])
                    hex_panel(cont_x, wall_z, discard_wall, skip_w = discard_cut_short,
                              f = hex_s_d, web = hex_s_web, mg = hex_s_margin);

        // chão: baixo relevo, NUNCA passante (senão o dado cai)
        translate([discard_wall, discard_wall, discard_floor])
            hex_relief(discard_in_x, discard_in_y, discard_floor_relief,
                       f = hex_s_d, web = hex_s_web, mg = hex_s_margin);
    }
}

// ---------------------------------------------------------------------
// Ressaltos (bosses) dos ímãs
// A parede da maleta tem 2.4mm — não cabe um furo Ø4.15 nela. Em cada uma
// das 6 posições o ressalto engrossa a parede PRA DENTRO até 7.0mm, com o
// centro do ímã a 3.5mm da face externa (1.425mm de material de cada lado
// do furo). O ressalto só existe do topo até `boss_z0`, bem acima da pilha
// de placas, e entra com rampa a 45° — não estorva as placas nem precisa de
// suporte. O bloco é CENTRADO no ímã e tem exatamente 7.0mm na direção da
// normal, então vai da face externa até a face interna do ressalto.
// ---------------------------------------------------------------------
module boss_solid(m, z0, z1, grow = 0) {
    T = boss_T + 2 * grow;
    W = boss_w + 2 * grow;
    sx = abs(m[2]) * T + abs(m[3]) * W;
    sy = abs(m[3]) * T + abs(m[2]) * W;
    translate([m[0] - sx / 2, m[1] - sy / 2, z0])
        cube([sx, sy, z1 - z0]);
}

// Rampa 45° na base do ressalto: da espessura de parede (2.4) até a seção
// cheia (7.0) ao longo de `boss_t` em Z. As faces laterais ficam verticais.
module boss_ramp(m) {
    tx = abs(m[2]) * boss_T + abs(m[3]) * boss_w;
    ty = abs(m[3]) * boss_T + abs(m[2]) * boss_w;
    // centro da fatia de baixo: só a espessura de parede, encostada na face externa
    bcx = m[0] - m[2] * boss_t / 2;
    bcy = m[1] - m[3] * boss_t / 2;
    bx = abs(m[2]) * case_wall + abs(m[3]) * boss_w;
    by = abs(m[3]) * case_wall + abs(m[2]) * boss_w;

    hull() {
        translate([m[0] - tx / 2, m[1] - ty / 2, boss_z0]) cube([tx, ty, 0.01]);
        translate([bcx - bx / 2, bcy - by / 2, boss_ramp_z]) cube([bx, by, 0.01]);
    }
}

// ---------------------------------------------------------------------
// 3) Maleta
// ---------------------------------------------------------------------
module game_case() {
    difference() {
        union() {
            difference() {
                cube([case_out_x, case_out_y, case_out_z]);
                translate([case_wall, case_wall, case_wall])
                    cube([case_in_x, case_in_y, case_in_z + 1]); // passa do topo -> boca aberta
            }
            for (m = magnets) {
                boss_solid(m, boss_z0, case_out_z);
                boss_ramp(m);
            }
        }

        // rebaixos de ímã ABERTOS no topo do rebordo (imprimem sem ponte)
        for (m = magnets)
            translate([m[0], m[1], case_out_z - mag_pocket_h])
                cylinder(h = mag_pocket_h + 0.1, d = mag_pocket_d);

        // entalhes de puxador no topo das duas paredes compridas: afundam o
        // rebordo `grip_depth`, criando o vão onde o dedo levanta a tampa
        for (y0 = [0, case_out_y - case_wall])
            u_cutout(grip_cx, y0, case_wall + 2, grip_w, grip_r,
                     case_out_z - grip_depth, grip_depth + 1);

        // chão interno: colmeia em BAIXO relevo (identidade + amortece o dado
        // quando a maleta vazia vira bandeja de rolagem). Não passante.
        translate([case_wall, case_wall, case_wall])
            hex_relief(case_in_x, case_in_y, case_floor_relief);
    }
}

// ---------------------------------------------------------------------
// 4) Tampa
// Modelada na MESMA origem da maleta (canto do retângulo externo), com a
// face de baixo em z=0: o painel sobe de 0 a lid_t e a saia desce de 0 a
// -lid_skirt_h. Assim os rebaixos de ímã da tampa usam literalmente o mesmo
// [cx, cy] dos da maleta.
// ---------------------------------------------------------------------
module case_lid() {
    difference() {
        union() {
            // painel com chanfro 45° na borda de cima (na chapa a tampa vai
            // de cabeça pra baixo, então esse chanfro vira o 1º layer e some
            // com a pata de elefante)
            hull() {
                cube([lid_x, lid_y, lid_t - lid_chamfer]);
                translate([lid_chamfer, lid_chamfer, lid_t - 0.01])
                    cube([lid_x - 2 * lid_chamfer, lid_y - 2 * lid_chamfer, 0.01]);
            }

            // saia que entra no interior da maleta (0.3/lado)
            translate([0, 0, -lid_skirt_h])
                difference() {
                    translate([skirt_x0, skirt_y0, 0])
                        cube([skirt_ox, skirt_oy, lid_skirt_h]);
                    translate([skirt_x0 + lid_skirt_t, skirt_y0 + lid_skirt_t, -0.1])
                        cube([skirt_ox - 2 * lid_skirt_t, skirt_oy - 2 * lid_skirt_t,
                              lid_skirt_h + 0.2]);
                }
        }

        // a saia tem que passar pelos 6 ressaltos internos da maleta:
        // abre um rasgo em cada um, com 0.3 de folga (só abaixo de z=0, o
        // painel não é tocado)
        for (m = magnets)
            boss_solid(m, -lid_skirt_h - 1, 0, grow = lid_clear);

        // a saia também some nos 2 puxadores, pro dedo entrar de verdade
        // (vão de 5mm de altura por ~5.1mm de profundidade)
        for (s = [0, 1])
            translate([grip_cx - skirt_gap_w / 2,
                       s == 0 ? -1 : lid_y - (skirt_y0 + lid_skirt_t + 1),
                       -lid_skirt_h - 1])
                cube([skirt_gap_w, skirt_y0 + lid_skirt_t + 1, lid_skirt_h + 1]);

        // rebaixos de ímã na face de baixo (cegos, 1.9mm de teto)
        for (m = magnets)
            translate([m[0], m[1], -0.1])
                cylinder(h = mag_pocket_h + 0.1, d = mag_pocket_d);

        // colmeia em baixo relevo na cara de cima
        translate([0, 0, lid_t])
            hex_relief(lid_x, lid_y, lid_relief);

        // escalopes de puxador na cara de cima, em cima dos entalhes da maleta
        for (yy = [grip_scallop_inset, lid_y - grip_scallop_inset])
            translate([0, 0, lid_t - grip_scallop_depth])
                hull()
                    for (xx = [grip_cx - grip_scallop_len / 2 + grip_scallop_r,
                               grip_cx + grip_scallop_len / 2 - grip_scallop_r])
                        translate([xx, yy, 0])
                            cylinder(h = grip_scallop_depth + 0.1, r = grip_scallop_r);
    }
}

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
plate_gap = 6;

if (part == "deck_basket") {
    deck_basket();
} else if (part == "discard_tray") {
    discard_tray();
} else if (part == "game_case") {
    game_case();
} else if (part == "case_lid") {
    case_lid();
} else if (part == "plate_case") {
    // maleta de boca pra cima, fundo na cama — sem suporte
    game_case();
} else if (part == "plate_lid") {
    // tampa de cabeça pra baixo: cara de cima na cama, saia apontando pra
    // cima. Única orientação sem suporte (com a saia pra baixo o painel
    // ficaria no ar). Os rebaixos de ímã viram furos cegos virados pra cima.
    translate([0, lid_y, lid_t])
        rotate([180, 0, 0])
            case_lid();
} else if (part == "plate_containers") {
    // os dois contêineres lado a lado, ambos de boca pra cima
    deck_basket();
    translate([cont_x + plate_gap, 0, 0])
        discard_tray();
} else if (part == "assembled") {
    // preview de conferência (não é peça): maleta fechada com a tampa, e em
    // fantasma (%) o que vai dentro — pilha das 9 placas do campo, cestinha
    // do deck e cesta do descarte lado a lado em cima delas.
    %translate([case_wall + (case_in_x - plate_max_x) / 2,
                case_wall + (case_in_y - plate_max_y) / 2, case_wall])
        cube([plate_max_x, plate_max_y, plates_stack_h]);
    %translate([case_wall + (case_in_x - 2 * cont_x) / 2,
                case_wall + (case_in_y - cont_y) / 2, stack_top_z])
        cube([cont_x, cont_y, basket_h]);
    %translate([case_wall + (case_in_x - 2 * cont_x) / 2 + cont_x,
                case_wall + (case_in_y - cont_y) / 2, stack_top_z])
        cube([cont_x, cont_y, discard_h]);
    game_case();
    translate([0, 0, case_out_z]) case_lid();
} else {
    // preview: as 4 peças espalhadas, não montadas
    deck_basket();
    translate([cont_x + 15, 0, 0]) discard_tray();
    translate([0, cont_y + 20, 0]) game_case();
    translate([0, cont_y + case_out_y + 40, lid_skirt_h]) case_lid();
}
