// deckbox-02.scad
// Versão de UM deck do deckbox-01 — mesma mecânica (bandeja deslizante em
// capa com 4 ímãs, cestinha hexagonal empurrada por baixo pelo furo no
// chão), com duas diferenças de parâmetro: um compartimento de deck em vez
// de dois, e o compartimento de dados/moedas bem mais fundo (64mm em vez
// de 30 — ~244cm³ contra ~114). Toda a geometria vem do deckbox-01.scad.
//
// 64mm é o máximo prático: a bandeja (que imprime deitada) fica com
// 169.6mm, no limite ~170 da chapa da AD5X. A capa em pé vai a 171.6mm
// dos 220 de altura disponíveis — o teto não é a capa, é a bandeja.
// O conjunto INTEIRO ainda cabe numa chapa única (~170x162mm) — 1 job:
//   openscad -o 3mf/deckbox-02-plate.3mf   -D 'part="plate"'   deckbox-02.scad
// STLs individuais (a cestinha é a MESMA do deckbox-01):
//   openscad -o stl/deckbox-02-tray.stl    -D 'part="tray"'    deckbox-02.scad
//   openscad -o stl/deckbox-02-sleeve.stl  -D 'part="sleeve"'  deckbox-02.scad
//   openscad -o stl/deckbox-02-basket.stl  -D 'part="basket"'  deckbox-02.scad

deck_lanes = 1;
dice_depth = 64; // mm, profundidade do compartimento de dados (deckbox-01 usa 30)
sleeve_tray_reveal = 0; // deixa a traseira da bandeja alinhada com a boca da capa quando fechada
sleeve_finger_hole_d = 18; // mm, furo maior no fundo da capa pra passar um dedo
include <../deckbox-01/deckbox-01.scad>
