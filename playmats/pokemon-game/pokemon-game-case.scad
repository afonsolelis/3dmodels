// pokemon-game-case.scad
// Contêineres e maleta do projeto "pokemon-game" (plataforma de jogo de
// Pokémon TCG). As PLACAS DO CAMPO são modeladas à parte, em
// playmats/pokemon-game/pokemon-game.scad — este arquivo NÃO as contém.
//
// São 4 peças:
//
// 1) "deck_basket" — cestinha do deck. Uma cesta de paredes finas vazadas em
//    colmeia que segura o deck de 60 cartas COM sleeve (93x68x45 medido com
//    régua). Durante a partida ela ENCAIXA no rebaixo da zona de deck do
//    campo (o rebaixo foi feito pro footprint externo 72.4x97.4 com 0.4mm de
//    folga por lado). No transporte a mesma peça é a deckbox. Os recortes em
//    U nas duas laterais compridas descem até o chão da cesta — é por eles
//    que o dedo pinça a pilha até a ÚLTIMA carta.
//
// 2) "discard_tray" — cesta do descarte. MESMO footprint externo 72.4x97.4
//    (os dois rebaixos do campo são iguais e intercambiáveis), 30mm de
//    altura. Os quatro lados têm escalopes generosos que descem até 8mm do
//    chão: dá pra enfiar o dedo por qualquer lado e tirar a pilha de
//    descarte inteira. Chão INTEIRO (só relevo, nada passante).
//
// 3) "game_case" — a maleta. As 12 placas do campo (3 fileiras de 4, todas
//    de 7mm: 146x107 ou 152x107) viajam EM PÉ, lado a lado como livros numa
//    estante: uma fatia de 152.0 x 84.0 x 107.0 encostada na parede da
//    frente. Uma nervura baixa separa essa faixa da área dos dois
//    contêineres, que viajam DEITADOS (72.4 x 50 x 97.4 cada; 144.8 x 50 os
//    dois juntos) com as BOCAS viradas pra fatia de placas — é a parede de
//    placas que tampa os contêineres, então o deck não escorrega pra fora da
//    cestinha no transporte. Em pé eles não cabiam: o interior passaria de
//    170 e estouraria a cama da AD5X.
//
//    ONDE VÃO OS DADOS: NÃO dentro da cesta do descarte — deitada, ela perde
//    o dado pelos escalopes das paredes. A cesta tem só 30mm de fundo numa
//    faixa de 50, e o que sobra atrás dela é um bolso de ~21 x 72 x 97
//    fechado pelo chão SÓLIDO da própria cesta, pela parede de trás da
//    maleta, pela lateral da cestinha do deck e pelo chão/tampa. É esse
//    bolso que leva dados e contadores.
//
//    Vazia, a maleta é a bandeja de rolar dado: o chão tem colmeia em BAIXO
//    relevo (não passante) que amortece e freia o dado.
//
//    COMO SE TIRA UMA PLACA (é o motivo do desenho ser assim):
//      a) pelas duas JANELAS da parede da frente — dois rasgos de 40mm que
//         descem 32mm a partir do rebordo, em cima da fatia de placas. As
//         placas param 7mm abaixo da borda, então sem esses rasgos não dá
//         pra pegar a borda de cima. São DUAS (e não uma central) por dois
//         motivos: dá pra usar as duas mãos numa placa de 152mm, e o pilar
//         de 25mm que sobra entre elas mantém o rebordo rígido.
//      b) com os contêineres FORA (saem fácil: deitados, o topo deles fica
//         ~16mm abaixo do rebordo, é só enfiar a mão e pegar), a nervura de
//         4mm deixa a face de trás da fatia de placas exposta de cima a
//         baixo — polegar na borda de cima, dedos na face de trás, e a placa
//         sai. É por isso que não fiz janela desse lado: já é aberto por
//         cima, e cada abertura a mais é uma chance a mais do dado escapar
//         quando a maleta vira bandeja.
//      As janelas ficam ALTAS (o ponto mais baixo a 84mm do piso), longe do
//      chão da bandeja de dados.
//
//    ÍMÃS NUM FLANGE EXTERNO, SÓ NAS DUAS PAREDES COMPRIDAS: com as placas
//    em pé ocupando 107 dos 114mm de interior, qualquer ressalto interno
//    estrangularia o poço e a placa de 152 não entraria. Então o interior é
//    um prisma LIMPO, sem nenhuma saliência, e os ímãs foram pra FORA: um
//    flange de 4.4mm corre ao longo das duas paredes compridas, dando
//    2.4+4.4 = 6.8mm de material pro furo de Ø4.15 (1.325mm de cada lado).
//    Os 6 ímãs ficam 3 e 3 nessas duas paredes; as paredes curtas não têm
//    flange, então o footprint NÃO cresce em X — é isso que segura o
//    conjunto em 159.2 x 152.6, abaixo dos 170 da cama mesmo depois da 3ª
//    fileira de placas (que levou a fatia de 56 pra 84mm). O flange entra
//    por rampa de 45°, imprime sem suporte, e enrijece a boca da caixa.
//
// 4) "case_lid" — a tampa. Painel plano do tamanho exato do contorno da
//    maleta, com uma saia que entra no interior (0.3mm de folga por lado)
//    pra centralizar. 6 rebaixos de ímã espelhando EXATAMENTE os 6 da
//    maleta — as duas peças são modeladas na MESMA origem (canto do
//    retângulo externo) e leem a MESMA lista `magnets`, então os pares
//    fecham centro com centro por construção. Pra abrir há quatro pegadores:
//    na frente as próprias janelas das placas (a saia é interrompida ali) e
//    atrás duas mordidas no flange que deixam a borda da tampa em balanço
//    sobre um vão de 10.4mm — o dedo entra e levanta. Escalopes na cara de
//    cima marcam os quatro lugares.
//
// ÍMÃS: 12 discos 4x2mm (6 na maleta + 6 na tampa), press-fit 0.15.
//   - Na maleta o rebaixo é ABERTO POR CIMA (entra pelo topo do flange,
//     imprime sem ponte nenhuma).
//   - Na tampa o rebaixo é CEGO, aberto pra baixo, com 1.9mm de teto sólido
//     (1.3mm depois do relevo hexagonal). Como a tampa imprime de cabeça pra
//     baixo, esse rebaixo vira furo cego virado pra CIMA — também sem ponte.
//   - Todos os 6 da maleta com o MESMO polo pra cima; todos os 6 da tampa
//     com o polo oposto. Um pingo de cola CA se ficar frouxo.
//
// STL de cada peça:
//   openscad -o stl/pokemon-game-deck-basket.stl  -D 'part="deck_basket"'  pokemon-game-case.scad
//   openscad -o stl/pokemon-game-discard-tray.stl -D 'part="discard_tray"' pokemon-game-case.scad
//   openscad -o stl/pokemon-game-case.stl         -D 'part="game_case"'    pokemon-game-case.scad
//   openscad -o stl/pokemon-game-lid.stl          -D 'part="case_lid"'     pokemon-game-case.scad
//
// 3MF — 3 jobs de impressão (cama FlashForge AD5X 220x220), TODOS sem suporte:
//   openscad -o 3mf/pokemon-game-case.3mf       -D 'part="plate_case"'       pokemon-game-case.scad
//   openscad -o 3mf/pokemon-game-lid.3mf        -D 'part="plate_lid"'        pokemon-game-case.scad
//   openscad -o 3mf/pokemon-game-containers.3mf -D 'part="plate_containers"' pokemon-game-case.scad
//
// Orientações de impressão das chapas:
//   plate_case       — maleta de BOCA PRA CIMA (fundo na cama). O flange
//                      abre por rampa de 45°: nada de suporte. O 1º layer é
//                      só o corpo (159.2 x 143.8) — o flange só existe nos
//                      10.4mm de cima, então brim/aderência não sofrem.
//   plate_lid        — tampa de CABEÇA PRA BAIXO: cara de cima na cama
//                      (ganha o acabamento da placa) e saia apontando pra
//                      cima. É a única orientação sem suporte — com a saia
//                      pra baixo o painel inteiro ficaria no ar. Custo: os
//                      hexágonos rebaixados da cara de cima fecham com ponte
//                      curta (0.6mm de altura, vão de 10mm), que a AD5X
//                      faz limpo.
//   plate_containers — cestinha do deck + cesta do descarte lado a lado,
//                      ambas de boca pra cima.
//
// Previews de conferência (não são peças):
//   part="assembled" — maleta fechada, com a fatia das placas EM PÉ e os
//                      dois contêineres DEITADOS em fantasma (%) na posição
//                      real de transporte
//   part="all"       — as 4 peças espalhadas, não montadas

/* [Peça a renderizar] */
part = "all"; // "deck_basket" | "discard_tray" | "game_case" | "case_lid" | "plate_case" | "plate_lid" | "plate_containers" | "assembled" | "all"

/* [Deck de 60 cartas COM sleeve - medido com régua] */
// Medido em 2026-08-08: 93 x 68 x 45 mm. Trocou de sleeve, mede de novo.
deck_w = 68; // mm, largura da carta com sleeve (vira X da cestinha)
deck_l = 93; // mm, altura da carta com sleeve (vira Y da cestinha)
deck_h = 45; // mm, altura da pilha das 60 cartas (vira Z)

/* [Contêineres - footprint externo FIXO] */
// NÃO MEXER: os rebaixos das placas do campo (pokemon-game.scad) já foram
// dimensionados pra receber exatamente este retângulo com 0.4mm de folga por
// lado.
cont_x = 72.4; // mm, largura externa dos dois contêineres
cont_y = 97.4; // mm, profundidade externa dos dois contêineres

/* [Cestinha do deck] */
basket_wall  = 1.2; // mm, paredes (72.4-2*1.2 = 70 internos = deck + 1mm/lado)
basket_floor = 1.6; // mm, chão
basket_lip   = 3.4; // mm, quanto a parede sobe acima da pilha de cartas
basket_cut_w = 40;  // mm, largura do recorte em U das duas laterais compridas
basket_cut_r = 6;   // mm, raio dos cantos de baixo do U

/* [Cesta do descarte] */
discard_h            = 30;  // mm, altura externa
discard_wall         = 1.2; // mm, paredes
discard_floor        = 1.6; // mm, chão INTEIRO (é ele que fecha o bolso dos dados)
discard_band         = 8;   // mm, faixa sólida que sobra abaixo dos escalopes
// As paredes CURTAS têm faixa mais alta que as compridas: é nelas que vai a
// etiqueta DESCARTE, e ela precisa nascer acima do rebaixo de 5mm do campo
// (senão o campo come o pé da letra). O acesso ao dedo continua sendo pelos
// escalopes das compridas, que são 52 de largura contra 34 destes.
discard_band_short   = 15;  // mm, faixa sólida das paredes curtas
discard_cut_long     = 52;  // mm, escalope das paredes compridas (97.4)
discard_cut_short    = 34;  // mm, escalope das paredes curtas (72.4)
discard_cut_r        = 6;   // mm, raio dos cantos de baixo dos escalopes
discard_floor_relief = 0.6; // mm, relevo hexagonal do chão (de 1.6)

/* [Placas do campo - medidas REAIS (bbox.py nos STLs), só conferência] */
// 12 placas TODAS de 7.0mm (3 fileiras de 4): 146.0x107.0 ou 152.0x107.0 (as
// que têm o rebaixo do contêiner). Miolo hexagonal aberto por baixo; os
// encaixes viraram ímã 4x2 deitado na parede lateral, o que exige >= 6.55mm
// de espessura, e por isso sumiram as linguetas. Em pé, encostadas, formam
// uma fatia de 152.0 (X) x 84.0 (Y) x 107.0 (Z).
// A 3ª fileira entrou quando o campo foi de 590x214 pra 590x321: agora cabe
// uma carta inteira por fileira e os 6 prêmios viraram grade 2x3.
plate_slice_x = 152.0; // mm, maior largura de placa
plate_slice_y = 84.0;  // mm, soma das espessuras das 12 placas (12 x 7)
plate_slice_z = 107.0; // mm, altura da placa em pé

/* [Maleta] */
plate_gap_side  = 1.2; // mm, folga por lado da fatia de placas em X
plate_gap_depth = 1.0; // mm, folga por lado da fatia de placas em Y
cont_gap_back   = 1.0; // mm, folga atrás dos contêineres deitados (a boca
                       //     encosta na nervura, a folga fica só nas costas)
case_wall       = 2.4; // mm, paredes e fundo
case_in_z       = 114; // mm, interior Z (placa em pé 107 + saia da tampa 5 + 2)
case_floor_relief = 0.9; // mm, colmeia em baixo relevo do chão (de 2.4)
rib_t = 2;   // mm, espessura da nervura que separa placas de contêineres
rib_h = 4;   // mm, altura da nervura (baixa de propósito: deixa a face de
             //     trás da fatia de placas acessível de cima)

/* [Flange dos ímãs - só nas duas paredes COMPRIDAS, por fora] */
// O interior tem que ser um prisma limpo (a placa em pé usa a altura toda),
// então o material extra pro furo do ímã vai pra fora. Só nas compridas: o
// eixo X é o apertado (placa de 152), e assim ele não cresce nada.
flange_w = 4.4; // mm, quanto o flange avança pra fora (2.4+4.4 = 6.8 de material)
flange_h = 6;   // mm, altura da faixa cheia do flange (rebaixo do ímã tem 2.1)

/* [Janelas das placas e pegadores - dois de cada, fora do centro] */
feat_off       = 32.6; // mm, distância de cada rasgo/pegador até o centro em X
plate_window_w = 40;   // mm, largura de cada janela (parede da frente)
plate_window_h = 32;   // mm, quanto a janela desce a partir do rebordo
plate_window_r = 10;   // mm, raio dos cantos de baixo da janela
pull_w         = 34;   // mm, largura de cada mordida no flange (parede de trás)
pull_r         = 3;    // mm, raio dos cantos internos da mordida

/* [Tampa] */
lid_t       = 4.0; // mm, painel (2.1 de rebaixo de ímã + 1.9 de teto)
lid_skirt_h = 5;   // mm, quanto a saia desce pra dentro do interior
lid_skirt_t = 2.4; // mm, espessura da saia
lid_clear   = 0.3; // mm, folga por lado saia x interior (peça solta em cavidade)
lid_chamfer = 1;   // mm, chanfro 45° na borda de cima (vira o 1º layer na chapa)
lid_relief  = 0.6; // mm, relevo hexagonal da cara de cima

/* [Ímãs disco 4x2mm - 3+3 nas paredes compridas da maleta, espelhados na tampa] */
magnet_d       = 4;    // mm, diâmetro
magnet_h       = 2;    // mm, espessura
magnet_fit     = 0.15; // mm, folga de press-fit (padrão do repo)
magnet_sink    = 0.1;  // mm, quanto o ímã afunda abaixo da face (rebaixo = 2.1)
magnet_x_inset = 20;   // mm, X dos ímãs das pontas (o do meio fica no centro)

/* [Escalope decorativo dos pegadores na cara de cima da tampa] */
grip_scallop_len   = 30;  // mm
grip_scallop_r     = 5;   // mm
grip_scallop_depth = 1.0; // mm
grip_scallop_inset = 8;   // mm, distância do centro até a borda da tampa

/* [Etiquetas gravadas nos contêineres] */
// O nome vai na parede CURTA externa (a que aponta pro jogador), nas duas,
// pra ler certo em qualquer orientação. No campo o nome também está gravado
// no piso do rebaixo, mas ali o contêiner tampa — este aqui é o que se vê
// com o jogo em andamento.
// A letra nunca cai em cima de furo: a faixa da colmeia que ela ocupa é
// reservada (parâmetro `band` da malha), então sobra chapa inteira. Fica
// 0.5 de 1.2 de parede, ou seja, 0.7mm de material atrás da letra.
cont_label_size = 6;   // mm, altura da letra
cont_label_deep = 0.5; // mm, profundidade da gravação (parede tem 1.2)
cont_label_z    = 10;  // mm, centro do texto acima do chão externo (rebaixo
                       //     do campo tem 5, então a letra nasce livre)
cont_label_band = 10;  // mm, faixa de colmeia reservada em volta do texto
cont_label_font = "Liberation Sans:style=Bold";

/* [Colmeia - identidade visual do repo, hexágonos de PONTA PRA CIMA] */
hex_d      = 8;   // mm, entre-faces (paredes/chão da cestinha do deck)
hex_web    = 2;   // mm, material entre furos vizinhos
hex_margin = 2.5; // mm, borda sólida em volta de cada painel
hex_s_d      = 6;   // mm, colmeia fina (paredes estreitas do descarte)
hex_s_web    = 1.8;
hex_s_margin = 2.2;
hex_l_d      = 10;  // mm, colmeia graúda (chão da maleta e cara da tampa)
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

discard_in_x  = cont_x - 2 * discard_wall;
discard_in_y  = cont_y - 2 * discard_wall;
discard_cut_z = discard_floor + discard_band;
discard_cut_z_short = discard_floor + discard_band_short;

// interior: fatia de placas em pé | nervura | dois contêineres DEITADOS
// (deitado, cada contêiner vira cont_x de largura, basket_h de fundo e
// cont_y de altura — a boca aponta pra fatia de placas)
cont_lie_y   = basket_h;                            // 50, fundo do contêiner deitado
plate_zone_y = plate_slice_y + 2 * plate_gap_depth; // 58.0
cont_zone_y  = cont_lie_y + cont_gap_back;          // 51.0
case_in_x    = plate_slice_x + 2 * plate_gap_side;  // 154.4 (contêineres 144.8 -> 4.8/lado)
case_in_y    = plate_zone_y + rib_t + cont_zone_y;  // 111.0

// retângulo EXTERNO = footprint total da maleta E da tampa; é a origem comum
// das duas peças (canto em 0,0). X NÃO leva flange (paredes curtas), Y leva.
case_bb_x  = case_in_x + 2 * case_wall;             // 159.2
case_bb_y  = case_in_y + 2 * case_wall + 2 * flange_w; // 124.6
case_out_z = case_in_z + case_wall;                 // 116.4 (topo aberto)

flange_z0     = case_out_z - flange_h; // base da faixa cheia do flange
flange_ramp_z = flange_z0 - flange_w;  // início da rampa 45°

// origem do interior dentro do retângulo externo
in_x0 = case_wall;
in_y0 = flange_w + case_wall;

// zonas internas
plate_y0 = in_y0;                  // fatia de placas encostada na parede da frente
rib_y0   = in_y0 + plate_zone_y;
cont_y0  = rib_y0 + rib_t;

mag_depth    = (case_wall + flange_w) / 2; // 3.4 -> centro do ímã no meio dos 6.8
mag_pocket_d = magnet_d + magnet_fit;      // 4.15
mag_pocket_h = magnet_h + magnet_sink;     // 2.1

// FONTE ÚNICA das posições de ímã, em coordenadas do retângulo EXTERNO
// (0,0 = canto da maleta E canto da tampa). Maleta e tampa leem esta mesma
// lista, então os pares fecham centro com centro por construção — foi
// exatamente aqui que o deckbox-01 errou (referenciais diferentes).
magnet_xs = [magnet_x_inset, case_bb_x / 2, case_bb_x - magnet_x_inset];
magnets = [for (yy = [mag_depth, case_bb_y - mag_depth], xx = magnet_xs) [xx, yy]];

// os dois rasgos/pegadores, fora do centro pra não bater no ímã do meio
feat_x = [case_bb_x / 2 - feat_off, case_bb_x / 2 + feat_off];

lid_x    = case_bb_x;
lid_y    = case_bb_y;
skirt_x0 = in_x0 + lid_clear;
skirt_y0 = in_y0 + lid_clear;
skirt_ox = case_in_x - 2 * lid_clear;
skirt_oy = case_in_y - 2 * lid_clear;
skirt_in_face = in_y0 + lid_clear + lid_skirt_t; // face interna da saia (y)

// conferências
plate_top_z  = case_wall + plate_slice_z;   // topo das placas em pé
cont_top_z   = case_wall + cont_y;          // topo dos contêineres deitados
skirt_bot_z  = case_out_z - lid_skirt_h;    // até onde a saia desce
window_bot_z = case_out_z - plate_window_h; // ponto mais baixo das janelas
mag_edge     = (case_wall + flange_w - mag_pocket_d) / 2;

echo(str("cestinha do deck  ext = ", cont_x, " x ", cont_y, " x ", basket_h,
         "  int = ", basket_in_x, " x ", basket_in_y, " x ", basket_in_z));
echo(str("cesta do descarte ext = ", cont_x, " x ", cont_y, " x ", discard_h,
         "  int = ", discard_in_x, " x ", discard_in_y, " x ", discard_h - discard_floor));
echo(str("etiqueta dos contêineres: letra de ", cont_label_size, " ocupando z=",
         cont_label_z - cont_label_size / 2, "..", cont_label_z + cont_label_size / 2,
         " (rebaixo do campo tem 5 -> nasce ", cont_label_z - cont_label_size / 2 - 5,
         "mm acima da superfície); sobra ", discard_wall - cont_label_deep,
         "mm de parede atrás da letra; escalope curto do descarte começa em z=",
         discard_cut_z_short));
echo(str("maleta EXTERNO (= footprint) ", case_bb_x, " x ", case_bb_y, " x ", case_out_z,
         "  | 1o layer (corpo, sem flange) ", case_bb_x, " x ", case_in_y + 2 * case_wall));
echo(str("maleta interior = ", case_in_x, " x ", case_in_y, " x ", case_in_z, " (prisma limpo)"));
echo(str("tampa ext = ", lid_x, " x ", lid_y, " x ", lid_t + lid_skirt_h));
echo(str("placas em pé ", plate_slice_x, " x ", plate_slice_y, " x ", plate_slice_z,
         " -> folga ", plate_gap_side, "/lado em X, ", plate_gap_depth, "/lado em Y, topo em z=",
         plate_top_z, " (rebordo em ", case_out_z, ")"));
echo(str("saia da tampa desce até z=", skirt_bot_z, " -> folga sobre a placa = ",
         skirt_bot_z - plate_top_z));
echo(str("contêineres DEITADOS 144.8 x ", cont_lie_y, " x ", cont_y, " -> folga ",
         (case_in_x - 2 * cont_x) / 2, "/lado em X, ", cont_gap_back,
         " nas costas, topo em z=", cont_top_z, " (interior ", case_in_z, ")"));
echo(str("bolso dos dados (atrás da cesta do descarte) = ", cont_x, " x ",
         cont_zone_y - discard_h, " x ", cont_y));
echo(str("janelas das placas: 2 x ", plate_window_w, " em x=", feat_x,
         ", do rebordo até z=", window_bot_z, " (piso da bandeja em z=", case_wall, ")"));
echo(str("ímãs em x=", magnet_xs, " nas duas paredes compridas (y=", mag_depth,
         " e ", case_bb_y - mag_depth, ")"));
echo(str("parede no ima = ", case_wall + flange_w, "mm, furo ", mag_pocket_d,
         " -> ", mag_edge, "mm de material de cada lado"));
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
// `band = [centro, altura]` reserva uma faixa HORIZONTAL (ao longo de `b`)
// sem furos — é o contrário do `skip_w`, que reserva uma vertical. É o que
// dá chapa inteira pra gravar a etiqueta do contêiner: a célula que encosta
// na faixa cai fora, então a letra nunca esbarra em furo, seja qual for o
// tamanho de hexágono da chamada.
module hex_cells(a, b, h, skip_w = 0, f = hex_d, web = hex_web, mg = hex_margin,
                 band = [0, 0]) {
    R  = f / sqrt(3);      // circunraio (centro -> ponta)
    sx = f + web;          // passo entre colunas
    sy = sx * sqrt(3) / 2; // passo entre fileiras (ímpares deslocam sx/2)

    for (j = [0 : ceil(b / sy)], i = [0 : ceil(a / sx)]) {
        cx = mg + f / 2 + i * sx + (j % 2) * sx / 2;
        cy = mg + R + j * sy;
        in_skip = skip_w > 0
            && cx + f / 2 > a / 2 - skip_w / 2 - mg
            && cx - f / 2 < a / 2 + skip_w / 2 + mg;
        in_band = band[1] > 0
            && cy + R > band[0] - band[1] / 2
            && cy - R < band[0] + band[1] / 2;
        if (cx + f / 2 <= a - mg && cy + R <= b - mg && !in_skip && !in_band)
            translate([cx, cy, 0])
                rotate([0, 0, 30])
                    cylinder(h = h, r = R, $fn = 6);
    }
}

// Vazado PASSANTE numa chapa de espessura t apoiada em z=0.
module hex_panel(a, b, t, skip_w = 0, f = hex_d, web = hex_web, mg = hex_margin,
                 band = [0, 0]) {
    translate([0, 0, -0.1]) hex_cells(a, b, t + 0.2, skip_w, f, web, mg, band);
}

// Baixo relevo: cava `d` PRA BAIXO a partir da superfície em z=0. Usado no
// chão da maleta e na cara de cima da tampa — nunca vira furo passante.
module hex_relief(a, b, d, skip_w = 0, f = hex_l_d, web = hex_l_web, mg = hex_l_margin) {
    translate([0, 0, -d]) hex_cells(a, b, d + 0.05, skip_w, f, web, mg);
}

// ---------------------------------------------------------------------
// Recorte em U / escalope / janela: aberto no topo, cantos de baixo
// arredondados, atravessando uma parede no plano XZ (normal +Y) que começa
// em y0 e tem espessura t. `cx` é o centro ao longo de X, `zb` o fundo e `h`
// o quanto ele sobe (é só passar a altura da peça).
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
// Etiqueta gravada nas DUAS paredes CURTAS externas do contêiner (as normais
// a Y, de cont_x de largura). Nas duas porque o contêiner cai no rebaixo em
// qualquer um dos dois sentidos, e o nome tem que ler certo dos dois jeitos.
// `zc` é a altura do CENTRO do texto medida do chão externo da peça.
// ---------------------------------------------------------------------
module cont_label(s, zc = cont_label_z, size = cont_label_size,
                  deep = cont_label_deep) {
    // parede da frente: face externa em y=0, lê-se de -Y
    translate([cont_x / 2, deep, zc])
        rotate([90, 0, 0])
            linear_extrude(deep + 0.1)
                text(s, size = size, halign = "center", valign = "center",
                     font = cont_label_font);
    // parede de trás: face externa em y=cont_y, lê-se de +Y
    translate([cont_x / 2, cont_y - deep, zc])
        rotate([90, 0, 180])
            linear_extrude(deep + 0.1)
                text(s, size = size, halign = "center", valign = "center",
                     font = cont_label_font);
}

// ---------------------------------------------------------------------
// 1) Cestinha do deck  (footprint é interface com o campo — NÃO mexer)
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

        // colmeia das laterais curtas, com a faixa da etiqueta reservada
        for (yy = [basket_wall, cont_y])
            translate([0, yy, basket_floor])
                rotate([90, 0, 0])
                    hex_panel(cont_x, basket_in_z, basket_wall,
                              band = [cont_label_z - basket_floor, cont_label_band]);

        cont_label("DECK");
    }
}

// ---------------------------------------------------------------------
// 2) Cesta do descarte  (inalterada)
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

        // escalopes das paredes curtas (normais a Y). Começam mais alto que
        // os das compridas: é abaixo deles que mora a etiqueta DESCARTE.
        for (y0 = [0, cont_y - discard_wall])
            u_cutout(cont_x / 2, y0, discard_wall,
                     discard_cut_short, discard_cut_r, discard_cut_z_short, discard_h);

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
                              f = hex_s_d, web = hex_s_web, mg = hex_s_margin,
                              band = [cont_label_z - discard_floor, cont_label_band]);

        cont_label("DESCARTE");

        // chão: baixo relevo, NUNCA passante (é ele que fecha o bolso dos dados)
        translate([discard_wall, discard_wall, discard_floor])
            hex_relief(discard_in_x, discard_in_y, discard_floor_relief,
                       f = hex_s_d, web = hex_s_web, mg = hex_s_margin);
    }
}

// ---------------------------------------------------------------------
// Flange: faixa que corre por FORA das duas paredes compridas, onde moram os
// 6 ímãs. Faixa cheia de `flange_h` no topo + rampa de 45° (`flange_w` de
// altura) descendo até a parede — assim não há nenhuma face virada pra baixo
// e imprime sem suporte. As paredes CURTAS não têm flange: é o que mantém o
// footprint em X igual ao do corpo.
// ---------------------------------------------------------------------
module flange() {
    band = flange_w + case_wall; // 6.8 = espessura local (o furo do ímã cabe aqui)
    for (s = [0, 1]) {
        yo = (s == 0) ? 0        : case_bb_y - band;      // início da faixa cheia
        yw = (s == 0) ? flange_w : case_bb_y - band;      // início do trecho de parede
        translate([0, yo, flange_z0])
            cube([case_bb_x, band, flange_h]);
        hull() {
            translate([0, yw, flange_ramp_z]) cube([case_bb_x, case_wall, 0.01]);
            translate([0, yo, flange_z0])     cube([case_bb_x, band, 0.01]);
        }
    }
}

// Mordida no flange da parede de TRÁS: tira o flange inteiro (faixa + rampa)
// numa largura `pull_w`, deixando a borda da tampa em balanço sobre um vão de
// flange_h+flange_w. O dedo entra por baixo da tampa e levanta. A parede de
// 2.4 fica intacta, então o interior continua fechado.
module flange_pull(cx) {
    yi = case_bb_y - (flange_w - pull_r); // centro dos raios (fundo da mordida)
    translate([0, 0, flange_ramp_z - 0.1])
        linear_extrude(flange_h + flange_w + 0.2) {
            hull()
                for (xx = [cx - pull_w / 2 + pull_r, cx + pull_w / 2 - pull_r])
                    translate([xx, yi]) circle(r = pull_r);
            translate([cx - pull_w / 2, yi]) square([pull_w, case_bb_y + 1 - yi]);
        }
}

// ---------------------------------------------------------------------
// 3) Maleta
// ---------------------------------------------------------------------
module game_case() {
    union() {
        difference() {
            union() {
                translate([0, flange_w, 0])
                    cube([case_bb_x, case_in_y + 2 * case_wall, case_out_z]);
                flange();
            }

            // interior: prisma LIMPO, sem nenhuma saliência (a placa em pé de
            // 152 x 107 precisa entrar sem raspar em nada)
            translate([in_x0, in_y0, case_wall])
                cube([case_in_x, case_in_y, case_in_z + 1]);

            // as duas janelas das placas, na parede da frente (y=0), do
            // rebordo pra baixo. Ficam a 84mm do piso — dado não passa.
            for (cx = feat_x)
                u_cutout(cx, 0, flange_w + case_wall + 0.5,
                         plate_window_w, plate_window_r, window_bot_z, case_out_z);

            // os dois pegadores da tampa, na parede de trás
            for (cx = feat_x)
                flange_pull(cx);

            // rebaixos de ímã ABERTOS no topo do flange (imprimem sem ponte)
            for (m = magnets)
                translate([m[0], m[1], case_out_z - mag_pocket_h])
                    cylinder(h = mag_pocket_h + 0.1, d = mag_pocket_d);

            // chão interno: colmeia em BAIXO relevo (identidade + amortece o
            // dado quando a maleta vazia vira bandeja). Não passante.
            translate([in_x0, in_y0, case_wall])
                hex_relief(case_in_x, case_in_y, case_floor_relief);
        }

        // nervura entre a fatia de placas e a área dos contêineres: segura as
        // placas em pé, encosta a boca dos contêineres e impede que eles
        // escorreguem por cima das placas. Baixa (4mm) de propósito — é o que
        // deixa a face de trás da fatia de placas acessível de cima.
        translate([in_x0, rib_y0, case_wall - case_floor_relief])
            cube([case_in_x, rib_t, rib_h + case_floor_relief]);
    }
}

// ---------------------------------------------------------------------
// 4) Tampa
// Modelada na MESMA origem da maleta (canto do retângulo externo), com a
// face de baixo em z=0: o painel sobe de 0 a lid_t e a saia desce de 0 a
// -lid_skirt_h. Assim os rebaixos de ímã usam literalmente o mesmo [cx, cy]
// dos da maleta.
// ---------------------------------------------------------------------
module case_lid() {
    difference() {
        union() {
            // painel com chanfro 45° na borda de cima (na chapa a tampa vai
            // de cabeça pra baixo, então o chanfro vira o 1º layer e some com
            // a pata de elefante)
            hull() {
                cube([lid_x, lid_y, lid_t - lid_chamfer]);
                translate([lid_chamfer, lid_chamfer, lid_t - 0.01])
                    cube([lid_x - 2 * lid_chamfer, lid_y - 2 * lid_chamfer, 0.01]);
            }

            // saia que entra no interior da maleta (0.3/lado). O interior é um
            // prisma limpo, então a saia é um anel inteiro.
            translate([0, 0, -lid_skirt_h])
                difference() {
                    translate([skirt_x0, skirt_y0, 0])
                        cube([skirt_ox, skirt_oy, lid_skirt_h]);
                    translate([skirt_x0 + lid_skirt_t, skirt_y0 + lid_skirt_t, -0.1])
                        cube([skirt_ox - 2 * lid_skirt_t, skirt_oy - 2 * lid_skirt_t,
                              lid_skirt_h + 0.2]);
                }
        }

        // a saia é interrompida em cima das duas janelas: senão o dedo que
        // entra pela janela não alcança a barriga da tampa pra levantar
        for (cx = feat_x)
            translate([cx - (plate_window_w + 4) / 2, -1, -lid_skirt_h - 1])
                cube([plate_window_w + 4, skirt_in_face + 1.5, lid_skirt_h + 1]);

        // rebaixos de ímã na face de baixo (cegos, 1.9mm de teto)
        for (m = magnets)
            translate([m[0], m[1], -0.1])
                cylinder(h = mag_pocket_h + 0.1, d = mag_pocket_d);

        // colmeia em baixo relevo na cara de cima
        translate([0, 0, lid_t])
            hex_relief(lid_x, lid_y, lid_relief);

        // escalopes que marcam os quatro pegadores, na cara de cima
        for (yy = [grip_scallop_inset, lid_y - grip_scallop_inset], cx = feat_x)
            translate([0, 0, lid_t - grip_scallop_depth])
                hull()
                    for (xx = [cx - grip_scallop_len / 2 + grip_scallop_r,
                               cx + grip_scallop_len / 2 - grip_scallop_r])
                        translate([xx, yy, 0])
                            cylinder(h = grip_scallop_depth + 0.1, r = grip_scallop_r);
    }
}

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
plate_sep = 6;

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
    translate([cont_x + plate_sep, 0, 0])
        discard_tray();
} else if (part == "assembled") {
    // preview de conferência (não é peça): maleta fechada e, em fantasma (%),
    // a fatia das 12 placas EM PÉ + os dois contêineres DEITADOS de boca pra
    // fatia de placas (as peças reais, não caixas equivalentes).
    cx0 = in_x0 + (case_in_x - 2 * cont_x) / 2;
    %translate([in_x0 + plate_gap_side, plate_y0 + plate_gap_depth, case_wall])
        cube([plate_slice_x, plate_slice_y, plate_slice_z]);
    // rotate([90,0,0]) vira a boca (+Z) pra -Y; o translate recoloca a peça
    // em y >= cont_y0, com a boca encostada na nervura
    %translate([cx0, cont_y0 + basket_h, case_wall]) rotate([90, 0, 0]) deck_basket();
    %translate([cx0 + cont_x, cont_y0 + discard_h, case_wall]) rotate([90, 0, 0]) discard_tray();
    game_case();
    translate([0, 0, case_out_z]) case_lid();
} else {
    // preview: as 4 peças espalhadas, não montadas
    deck_basket();
    translate([cont_x + 15, 0, 0]) discard_tray();
    translate([0, cont_y + 20, 0]) game_case();
    translate([0, cont_y + case_bb_y + 40, lid_skirt_h]) case_lid();
}
