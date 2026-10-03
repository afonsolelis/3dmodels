// switch-lite-stand-01.scad
// Suporte de mesa tipo BAINHA pra Nintendo Switch Lite COM capa protetora:
// bloco maciço em pé, com um slot central onde o console desce de pé (tela
// virada pra frente ou pra trás, borda de cima ou de baixo primeiro — TANTO
// FAZ, o slot aceita as 4 entradas), rebaixo pra dedo no meio do topo,
// 2 bolsos pra cartuchos na parede de trás e 2 bolsos estreitos na parede da
// frente (caneta, ponta de cabo, fone pequeno). PEÇA ÚNICA, sem montagem,
// sem ferragem, SEM SUPORTE DE IMPRESSÃO.
//
// COMO O USUÁRIO MANUSEIA. O bloco fica deitado na mesa com o lado comprido
// (220mm) de frente pra quem senta — a face da frente é a dos bolsos
// estreitos, a de trás é a dos cartuchos. O console entra de cima, de pé,
// pela boca do slot e desce até o piso de 5mm. Com 92mm de slot o console
// SOBRA 1mm acima do topo, e no centro o rebaixo em U (26 de largura x 26 de
// fundo, atravessando as duas paredes) deixa 27mm de console à mostra pra
// pinçar com polegar e indicador e puxar pra cima — é só isso que segura o
// console: gravidade e as nervuras do slot; não tem trava, não tem clipe.
//
// POR QUE O SLOT TEM 35mm E NERVURAS (2ª rodada, print-review reprovou a 1ª).
// O Switch Lite não é uma placa lisa de 16mm: os dois ANALÓGICOS saem ~7mm
// acima da capa (a capa não cobre o stick) e os gatilhos ZL/ZR saem ~4mm na
// face de trás, nos cantos da borda de cima. Num slot plano de 18 o console
// desce ~20mm e SENTA num stick (a referência de terceiro tem esse defeito).
// Solução: o slot abre pra 35 (canal) e o CORPO é guiado por NERVURAS
// verticais de 8mm de altura nas DUAS paredes, só na faixa central
// |x| <= 50, onde o console é liso dos dois lados (tela na frente, capa lisa
// atrás). Entre nervuras opostas sobra um canal de 19 (16 + 1,5 por lado);
// fora das nervuras a face do console centrado fica a 9,5mm da parede, e no
// PIOR caso (corpo encostado na nervura do lado da tela) a 8 — stick de 7
// + 1,0 de folga. Com nervura nos dois lados o corpo fica CENTRADO, e é por
// isso que cada parede precisa de stick_h + folga de recuo — nervura de 3,5
// (slot 25) centraria o corpo a 4,5 da parede e o stick de 7 bateria igual.
// (3ª rodada: era canal 18 / slot 32 / nervura 7, e o pior caso dava 0.)
// Nervuras a x = ±20 e ±40 (8 de largura), longe do U do dedo (|x| <= 13) e
// longe de stick (|x| 73-91), ABXY/D-pad (|x| 62-90) e ZL/ZR (|x| 69-104).
// Cada nervura tem rampa de entrada a 45° (8mm) logo abaixo do chanfro da
// boca, então o console é "afunilado" pro canal de 18 ao descer. A
// simulação das 4 orientações de entrada (posição z de cada stick e dos
// ZL/ZR com o console no fundo, cruzamento com nervura e vão local) é
// ECOADA no console, já no PIOR caso de folga; só imprime "CURSO OK" se
// tudo passar.
// ORIENTAÇÃO PRINCIPAL: borda de BAIXO primeiro (ali só tem USB-C e P2,
// rebaixados). Borda de cima primeiro é tolerada, mas apoia o console em
// power/volume/L/R — a simulação cobre as 4 de qualquer jeito.
//
// Cartuchos (31 x 21 x 3,2) ficam DE PÉ, como livros, em cada bolso de trás:
// 6 por bolso, lado a lado (eixo de 21 ao longo do comprimento do bloco,
// espessura ao longo da profundidade); o bolso tem 17mm de fundo, o cartucho
// 31, então sobram 14mm pra fora, e as duas paredes X do bolso têm um
// rebaixo semicircular R8 (Ø16, quase a pilha inteira de 19,2) do topo ao
// fundo pra pinçar o cartucho pela borda
// estreita pelos dois lados. Os bolsos estreitos da frente (20 x 12, 50mm de
// fundo) são copos: caneta (Ø8-11), ponta de cabo, fone pequeno — cabo
// enrolado NÃO cabe.
//
// IMPRESSÃO: PLA, orientação de uso (fundo na cama), SEM SUPORTE (slot,
// bolsos, rebaixos e nervuras abrem/sobem todos pra cima; o fundo do U é
// côncavo pra cima; a rampa da nervura é a 45° VIRADA PRA CIMA), SEM BRIM
// (pedido do usuário): mesa 60 °C, PEI limpo, 1ª camada lenta; as 4 arestas
// verticais têm R3 pra o canto não levantar; se um canto soltar, brim
// EXTERNO de 5mm. ~15% de infill. O bloco tem 220mm de comprimento (a cama
// inteira da AD5X), então a chapa (part="plate") já vem GIRADA 45° —
// footprint ecoado, 208,4 x 208,4 (com os cantos R3). Não girar de volta no
// fatiador.
//
// IDENTIDADE VISUAL: colmeia hexagonal (hexágonos de ponta pra cima, 8mm
// entre faces, 2mm de nervura) em BAIXO-RELEVO de 1mm nas quatro faces
// verticais. Topo e fundo lisos. A colmeia NUNCA fura pra dentro de nada:
// faixa sólida de 3mm nas bordas e em volta de cada bolso (incluindo os
// rebaixos R8) e do U; nas pontas ela fica só abaixo dos bolsos estreitos
// (z <= 44) pra não sobrar coluna solitária entre os bolsos. Parede mínima
// atrás de hexágono ecoada (3mm, nas pontas).
//
// ⚠️ ORIGEM DAS MEDIDAS. O console-com-capa de 210 x 93 x 16 é ASSUMIDO pelo
// usuário (+2mm no total em cada eixo sobre o Switch Lite nu de 208 x 91 x
// 14), NÃO foi medido com régua. MEDIR COM PAQUÍMETRO a espessura total
// com capa no CENTRO do console (sobre o lábio da capa em volta da tela e
// nas costas), não no vidro — esse valor vira content_t; a capa NÃO pode ter
// kickstand/grip na faixa central de 88mm (|x| <= 44), senão não passa no
// canal das nervuras. Stick (7mm acima da capa, cap Ø18 a
// x = ±82, 27mm da borda de cima / 30mm da de baixo), ZL/ZR (4mm, |x| 69-104
// nos 10mm junto à borda de cima) e botões (1mm, |x| 62-90) são ESTIMATIVAS.
// Faltam 3 medidas: (1) espessura TOTAL no stick com a capa (define stick_h);
// (2) distância das bordas até o centro dos caps (define a zona livre de
// nervura); (3) saliência real dos ZL/ZR. O cartucho (31 x 21 x 3) é cota de
// catálogo. O resto (bloco, slot, rebaixo, posição dos bolsos) vem dos
// NÚMEROS medidos por fatiamento da malha do 3MF de referência
// ../terceiros/nintendo-switch-lite-sleeve/nintendo-switch-lite-sleeve.3mf
// (autor e licença desconhecidos; bloco 220 x 54 x 95, slot 210 x 16 x 90,
// rebaixo R12, bolsos 30 x 22 e 20 x 9) — NADA da malha foi copiado.
//
// Export (caminhos absolutos; o flatpak não enxerga /tmp):
//   D=/home/afonsolelis/repos/3dmodels/suportes/switch-lite-stand-01
//   flatpak run org.openscad.OpenSCAD -o $D/stl/switch-lite-stand-01-stand.stl -D 'part="stand"' $D/switch-lite-stand-01.scad
//   flatpak run org.openscad.OpenSCAD -o $D/3mf/switch-lite-stand-01-plate.3mf -D 'part="plate"' $D/switch-lite-stand-01.scad
// Jobs de impressão (3mf/): só o plate (1 peça, girada 45°, PLA, sem brim,
// sem suporte). part="cut" (corte pelos bolsos) e part="cut_rib" (corte
// pela nervura) são diagnóstico, não são peças.
// Por CLI, -D mira sempre a variável FINAL (ex.: -D content_t=17), nunca
// a *_override (ver CLAUDE.md).

/* [Peça a renderizar] */
part = "plate"; // "stand" (peça na orientação de uso) | "plate" (job de impressão, girada 45°) | "cut" (diagnóstico: corte pelos bolsos) | "cut_rib" (diagnóstico: corte por uma nervura)

/* [Switch Lite COM capa - ASSUMIDO, não medido com régua] */
content_l = is_undef(content_l_override) ? 210 : content_l_override; // mm, comprimento do console com capa (eixo X do bloco)
content_h = is_undef(content_h_override) ?  93 : content_h_override; // mm, altura do console com capa (fica de pé no slot)
content_t = is_undef(content_t_override) ?  16 : content_t_override; // mm, espessura do CORPO com capa, sem contar stick

/* [Saliências do console - ESTIMADAS] */
stick_h        = 7;   // mm, quanto o analógico sobe acima da capa (MEDIR: espessura total no stick - content_t)
stick_gap      = 2.5; // mm, folga NOMINAL entre o topo do stick e a parede (corpo centrado); no PIOR caso (corpo encostado na nervura do lado da tela) sobra stick_gap - slot_gap_t
stick_cap_d    = 18;  // mm, diâmetro do cap do stick
stick_x        = 82;  // mm, |x| do centro de cada stick a partir do centro do console (nu 208)
stick_l_top    = 27;  // mm, stick ESQUERDO: distância da borda de CIMA até o centro do cap
stick_r_bottom = 30;  // mm, stick DIREITO: distância da borda de BAIXO até o centro do cap
zlzr_h         = 4;   // mm, saliência dos gatilhos ZL/ZR na face de TRÁS
zlzr_x         = [69, 104]; // mm, faixa |x| dos ZL/ZR
zlzr_band      = 10;  // mm, os ZL/ZR ocupam os 10mm junto à borda de cima
btn_h          = 1;   // mm, saliência de ABXY / D-pad / +/- na face da frente
btn_x          = [62, 90]; // mm, faixa |x| dos botões
btn_band       = [20, 70]; // mm, faixa de altura dos botões a partir da borda de cima

/* [Slot do console] */
slot_gap_l        = 1.0; // mm por lado, folga no comprimento (padrão do repo pra conteúdo)
slot_gap_t        = 1.5; // mm por lado, folga do CORPO entre nervuras opostas (1.5: o corpo pode encostar numa nervura, e esse deslocamento come folga do stick)
content_above_top = 1.0; // mm, quanto do console sobra ACIMA do topo do bloco (define a profundidade do slot)
slot_chamfer      = 1.2; // mm, chanfro 45° na boca do slot

/* [Nervuras de guia do corpo (dentro do slot, nas duas paredes)] */
rib_w         = 8;    // mm, largura de cada nervura (eixo X)
rib_pitch     = 20;   // mm, passo entre nervuras a partir do centro (x = ±20, ±40, ...)
rib_zone_half = 50;   // mm, nervuras só em |x| <= isto (console liso dos dois lados nessa faixa)
rib_ends      = false; // nervuras também junto das pontas (|x| >= 96) — NÃO: com entrada "tanto faz" os ZL/ZR podem cair ali

/* [Rebaixo pra dedo] */
finger_w     = 26; // mm, largura do U no centro do topo (atravessa as duas paredes)
finger_depth = 26; // mm, profundidade do U a partir do topo (fundo redondo, raio = finger_w/2)

/* [Bolsos de cartucho - parede de TRÁS, um em cada ponta] */
cart_l            = 31;  // mm, comprimento do cartucho de Switch (fica na vertical, pra fora)
cart_w            = 21;  // mm, largura do cartucho (ao longo do comprimento do bloco)
cart_t            = 3.2; // mm, espessura do cartucho com etiqueta (ao longo da profundidade)
cart_count        = 6;   // cartuchos por bolso, de pé, lado a lado
cart_gap          = 0.5; // mm por lado, folga do bolso (0.3 é o padrão de peça solta; 0.5 porque cavidade em XY sai menor e o cartucho não foi medido)
cart_pocket_depth = 17;  // mm, fundo do bolso a partir do topo (31 - 17 = 14mm de cartucho pra fora)
cart_end_offset   = 8;   // mm, afastamento do bolso até a parede de ponta (dá parede pro rebaixo de pinça)
cart_pinch_r      = 8;   // mm, raio do rebaixo semicircular de pinça nas duas paredes X do bolso (Ø16 cobre a pilha de 6 x 3.2 = 19.2 quase inteira)

/* [Bolsos estreitos - parede da FRENTE, um em cada ponta] */
small_pocket_l     = 20; // mm, ao longo do comprimento do bloco
small_pocket_w     = 12; // mm, ao longo da profundidade (caneta Ø8-11 com folga)
small_pocket_depth = 50; // mm, fundo a partir do topo
pocket_chamfer     = 0.6; // mm, chanfro 45° na boca de todos os bolsos

/* [Paredes] */
floor_t    = 5;   // mm, piso sob o slot e sob tudo
end_wall   = 4;   // mm, parede de cada ponta (fecha o slot no comprimento)
inner_wall = 3;   // mm, parede entre o slot e os bolsos (frente e trás)
outer_wall = 2.5; // mm, parede entre os bolsos e a face externa (frente e trás; 2.5 pra chapa a 45° ficar < 210)
corner_r   = 3;   // mm, raio das 4 arestas verticais do bloco (canto não levanta sem brim)

/* [Colmeia em baixo-relevo] */
hex_d      = 8;   // mm, hexágono medido entre faces
hex_web    = 2;   // mm, nervura entre hexágonos vizinhos
hex_margin = 3;   // mm, faixa sólida nas bordas das faces e em volta de bolsos/rebaixo
hex_relief = 1.0; // mm, profundidade do baixo-relevo
hex_front  = true; // colmeia na face da frente
hex_back   = true; // colmeia na face de trás
hex_ends   = true; // colmeia nas duas pontas (só abaixo dos bolsos)

/* [Impressão] */
plate_angle = 45;   // graus, giro da peça na chapa (220mm não cabem reto na cama de 220)
infill      = 0.15; // fração, só pra estimativa de massa
pla_density = 1.24; // g/cm³, só pra estimativa de massa
shell_t     = 1.2;  // mm, casca equivalente (3 paredes de 0.4) pra estimativa de massa

/* [Qualidade] */
$fn = 64;
eps = 0.01;

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
slot_l     = content_l + 2 * slot_gap_l;                   // 212
channel_t  = content_t + 2 * slot_gap_t;                   // 19  vão entre nervuras opostas
rib_h      = stick_h + stick_gap - slot_gap_t;             // 8   altura da nervura
slot_t     = channel_t + 2 * rib_h;                        // 35  largura do slot fora das nervuras
stick_room = (slot_t - content_t) / 2;                     // 9.5 face do console (centrado) até a parede
stick_worst = stick_room - slot_gap_t - stick_h;           // 1.0 PIOR caso: corpo encostado na nervura do lado da tela
slot_depth = content_h - content_above_top;                // 92
H          = floor_t + slot_depth;                         // 97 altura total
L          = slot_l + 2 * end_wall;                        // 220 comprimento total

cart_pocket_x = cart_w + 2 * cart_gap;                     // 22   (eixo X)
cart_pocket_y = cart_count * cart_t + 2 * cart_gap;        // 20.2 (eixo Y)
cart_exposed  = cart_l - cart_pocket_depth;                // 14   cartucho pra fora

front_wall = inner_wall + small_pocket_w + outer_wall;     // 17.5
back_wall  = inner_wall + cart_pocket_y + outer_wall;      // 25.7
D          = front_wall + slot_t + back_wall;              // 75.2 profundidade total

y_front = -D / 2;                 // face da frente (bolsos estreitos)
y_back  =  D / 2;                 // face de trás (cartuchos)
slot_y0 = y_front + front_wall;   // parede da frente do slot
slot_y1 = slot_y0 + slot_t;       // parede de trás do slot
x_in    = L / 2 - end_wall;       // face interna da parede de ponta

cart_x1  = x_in - cart_end_offset;           // bolso de cartucho (lado +X): x
cart_x0  = cart_x1 - cart_pocket_x;
cart_y0  = slot_y1 + inner_wall;             // bolso de cartucho: y
cart_y1  = cart_y0 + cart_pocket_y;
cart_yc  = (cart_y0 + cart_y1) / 2;
small_y0 = y_front + outer_wall;             // bolso estreito: y
small_y1 = small_y0 + small_pocket_w;

finger_r = finger_w / 2;
finger_z = H - finger_depth + finger_r;      // eixo do cilindro do fundo do U

rib_top   = H - slot_chamfer;                // a rampa da nervura morre onde começa o chanfro da boca
rib_x_mid = [for (k = [1 : 10]) if (k * rib_pitch + rib_w / 2 <= rib_zone_half
                                     && k * rib_pitch - rib_w / 2 >= finger_r + 2) k * rib_pitch];
rib_x_end = rib_ends ? [slot_l / 2 - rib_w / 2 - 2] : [];
rib_xs    = concat([for (x = rib_x_mid) -x], rib_x_mid, [for (x = rib_x_end) -x], rib_x_end); // centros em X

// parede mais fina que sobra atrás de um hexágono
min_behind_hex_end   = end_wall - hex_relief;    // 3
min_behind_hex_front = front_wall - hex_relief;
min_behind_hex_back  = back_wall - hex_relief;
min_behind_hex       = min(min_behind_hex_end, min_behind_hex_front, min_behind_hex_back);
cart_end_min_wall    = cart_end_offset + end_wall - cart_pinch_r;   // 4: do fundo do rebaixo de pinça até a face da ponta

// topo entre o chanfro do slot e o chanfro de um bolso (tem que sobrar faixa plana)
top_land = inner_wall - slot_chamfer - pocket_chamfer;  // 1.2

// footprint da chapa girada (os cantos R3 cortam o extremo da diagonal)
plate_x = (L - 2 * corner_r) * cos(plate_angle) + (D - 2 * corner_r) * sin(plate_angle) + 2 * corner_r;
plate_y = (L - 2 * corner_r) * sin(plate_angle) + (D - 2 * corner_r) * cos(plate_angle) + 2 * corner_r;

// massa estimada (aproximação: hexágonos tiram ~64% x 1mm das faces verticais)
hex_fill   = (sqrt(3) / 2 * hex_d * hex_d) / ((hex_d + hex_web) * (hex_d + hex_web) * sqrt(3) / 2);
v_block    = L * D * H;
v_slot     = slot_l * slot_t * slot_depth - len(rib_xs) * 2 * rib_w * rib_h * (rib_top - floor_t - rib_h / 2);
v_cart     = 2 * (cart_pocket_x * cart_pocket_y + PI * cart_pinch_r * cart_pinch_r) * cart_pocket_depth;
v_small    = 2 * small_pocket_l * small_pocket_w * small_pocket_depth;
v_finger   = D * (finger_w * (finger_depth - finger_r) + PI * finger_r * finger_r / 2);
a_faces    = (hex_front ? 1 : 0) * (L - 2 * hex_margin) * (H - 2 * hex_margin)
           + (hex_back  ? 1 : 0) * (L - 2 * hex_margin) * (H - 2 * hex_margin)
           + (hex_ends  ? 2 : 0) * (D - 2 * hex_margin) * (H - small_pocket_depth - 2 * hex_margin);
v_hex      = a_faces * hex_fill * hex_relief * 0.85;   // 0.85: desconto das zonas puladas
v_solid    = v_block - v_slot - v_cart - v_small - v_finger - v_hex;      // mm³
a_surface  = 2 * (L * D + L * H + D * H) + 2 * slot_depth * (slot_l + slot_t)
           + 2 * cart_pocket_depth * 2 * (cart_pocket_x + cart_pocket_y)
           + 2 * small_pocket_depth * 2 * (small_pocket_l + small_pocket_w);
v_shell    = a_surface * shell_t;
mass_solid = v_solid * pla_density / 1000;                                 // g, 100% infill
mass_print = (v_shell + (v_solid - v_shell) * infill) * pla_density / 1000; // g, com infill

echo(str("BLOCO L x D x H = ", L, " x ", D, " x ", H, " mm, cantos R", corner_r, " (chapa girada ", plate_angle, "°: ",
         round(plate_x * 10) / 10, " x ", round(plate_y * 10) / 10, " -> ", plate_x <= 210 ? "cabe <= 210" : "PASSOU DE 210", ")"));
echo(str("SLOT ", slot_l, " x ", slot_t, " x ", slot_depth, " de fundo | canal entre nervuras ", channel_t,
         " (corpo ", content_t, " + ", slot_gap_t, "/lado) | nervuras ", rib_h, " altas x ", rib_w, " largas em x = ", rib_xs,
         " | face do console até a parede fora da nervura = ", stick_room, " centrado (stick ", stick_h, " + ", stick_room - stick_h,
         ") | PIOR CASO corpo encostado na nervura: folga do stick = ", stick_worst));
echo(str("CONSOLE-COM-CAPA ", content_l, " x ", content_h, " x ", content_t, " sobra ", content_above_top, " acima do topo"));
echo(str("PAREDES: ponta ", end_wall, " | frente ", front_wall, " (", inner_wall, "+", small_pocket_w, "+", outer_wall,
         ") | trás ", back_wall, " (", inner_wall, "+", cart_pocket_y, "+", outer_wall, ") | piso ", floor_t));
echo(str("BOLSO CARTUCHO ", cart_pocket_x, " x ", cart_pocket_y, " x ", cart_pocket_depth, " de fundo a ", cart_end_offset,
         " da ponta, pinça R", cart_pinch_r, " nas duas paredes X (parede até a face da ponta = ", cart_end_min_wall, ") | ",
         cart_count, " cartuchos de ", cart_w, "x", cart_t, " de pé, ", cart_exposed, "mm pra fora"));
echo(str("BOLSO ESTREITO ", small_pocket_l, " x ", small_pocket_w, " x ", small_pocket_depth, " de fundo"));
echo(str("REBAIXO DEDO U ", finger_w, " x ", finger_depth, " | console à mostra no centro = ",
         finger_depth + content_above_top, " mm"));
echo(str("COLMEIA: parede mínima atrás de hexágono = ", min_behind_hex, " mm (ponta ", min_behind_hex_end,
         ", frente ", min_behind_hex_front, ", trás ", min_behind_hex_back, ") | pontas só até z = ",
         H - small_pocket_depth - hex_margin, " | faixa plana no topo entre chanfros = ", top_land));
echo(str("MASSA PLA estimada: ", round(mass_solid), " g maciça | ", round(mass_print), " g a ", infill * 100,
         "% de infill (volume ~", round(v_solid / 1000), " cm3) — estimativa ANALÍTICA, ~2% abaixo da malha; README/index usam o volume da malha exportada"));

// ---------------------------------------------------------------------
// SIMULAÇÃO DO CURSO: 4 orientações de entrada, console no fundo do slot.
// Cada saliência é [nome, x0, x1 (no referencial do console, tela pra
// frente), h0, h1 (distância da borda de CIMA), saliência, face "tela"/"tras"].
// Checa: (a) não cruza nervura em X; (b) saliência + folga cabe no vão local
// (fora da nervura: stick_room; dentro: slot_gap_t).
// ---------------------------------------------------------------------
console_h_nu = content_h - 2;   // 91: as distâncias de borda são do console nu
features = [
    ["stick ESQ", -stick_x - stick_cap_d / 2, -stick_x + stick_cap_d / 2, stick_l_top - stick_cap_d / 2, stick_l_top + stick_cap_d / 2, stick_h, "tela"],
    ["stick DIR",  stick_x - stick_cap_d / 2,  stick_x + stick_cap_d / 2, console_h_nu - stick_r_bottom - stick_cap_d / 2, console_h_nu - stick_r_bottom + stick_cap_d / 2, stick_h, "tela"],
    ["ZL", -zlzr_x[1], -zlzr_x[0], 0, zlzr_band, zlzr_h, "tras"],
    ["ZR",  zlzr_x[0],  zlzr_x[1], 0, zlzr_band, zlzr_h, "tras"],
    ["D-pad", -btn_x[1], -btn_x[0], btn_band[0], btn_band[1], btn_h, "tela"],
    ["ABXY",   btn_x[0],  btn_x[1], btn_band[0], btn_band[1], btn_h, "tela"],
];
orientations = [["tela FRENTE, borda de cima primeiro", 1, true], ["tela FRENTE, borda de baixo primeiro", 1, false],
                ["tela TRÁS, borda de cima primeiro", -1, true],  ["tela TRÁS, borda de baixo primeiro", -1, false]];

function rib_hit(x0, x1) = len([for (rx = rib_xs) if (x1 > rx - rib_w / 2 && x0 < rx + rib_w / 2) 1]) > 0;
// resultado por feature e orientação: [z0, z1, cruza_nervura, folga_local]
function sim(f, o) = let(
        x0 = min(o[1] * f[1], o[1] * f[2]), x1 = max(o[1] * f[1], o[1] * f[2]),
        z0 = floor_t + (o[2] ? f[3] : console_h_nu - f[4]),
        z1 = floor_t + (o[2] ? f[4] : console_h_nu - f[3]),
        hit = rib_hit(x0, x1),
        room = (hit ? slot_gap_t : stick_room - slot_gap_t) - f[5])   // PIOR caso: corpo encostado na nervura do lado da saliência
    [x0, x1, z0, z1, hit, room];
results = [for (o = orientations) [for (f = features) sim(f, o)]];
all_ok = len([for (o = [0 : len(orientations) - 1], i = [0 : len(features) - 1])
              if (results[o][i][4] || results[o][i][5] < 0.5) 1]) == 0;
for (o = [0 : len(orientations) - 1]) {
    echo(str("CURSO [", orientations[o][0], "]"));
    for (i = [0 : len(features) - 1]) let(r = results[o][i], f = features[i])
        echo(str("   ", f[0], " (", f[6], ", +", f[5], "mm): x ", r[0], "..", r[1], " | z ", r[2], "..", r[3],
                 " | cruza nervura: ", r[4] ? "SIM" : "não", " | vão local (pior caso) ", r[4] ? slot_gap_t : stick_room - slot_gap_t,
                 " -> folga ", r[5], r[4] || r[5] < 0.5 ? "  <<< FALHA" : "  ok"));
}
echo(str("REBAIXO DO DEDO em |x| <= ", finger_r, ": console liso dos dois lados (nenhuma saliência com |x| < ", btn_x[0], ")"));
echo(all_ok ? str("CURSO OK — nenhuma saliência cruza nervura e a espessura local cabe no vão nas 4 orientações (corpo ",
                  content_t, " < canal ", channel_t, " na nervura; ", content_t, "+", stick_h, " < ", slot_t, " fora; pior caso do stick ", stick_worst, ")")
            : "CURSO FALHOU — ver linhas <<< FALHA acima");

// ---------------------------------------------------------------------
// Módulos
// ---------------------------------------------------------------------

// Cavidade retangular aberta pra cima, com chanfro 45° na boca.
module pocket(x0, x1, y0, y1, z_floor, chamfer) {
    w = x1 - x0; d = y1 - y0;
    translate([x0, y0, z_floor]) cube([w, d, H - z_floor + 1]);
    if (chamfer > 0)
        translate([(x0 + x1) / 2, (y0 + y1) / 2, H - chamfer])
            linear_extrude(height = chamfer + eps, scale = [(w + 2 * (chamfer + eps)) / w, (d + 2 * (chamfer + eps)) / d])
                square([w, d], center = true);
}

// Bolso de cartucho com rebaixo semicircular de pinça nas duas paredes X.
module cart_pocket(x0, x1) {
    pocket(x0, x1, cart_y0, cart_y1, H - cart_pocket_depth, pocket_chamfer);
    for (xx = [x0, x1])
        translate([xx, cart_yc, H - cart_pocket_depth]) {
            cylinder(h = cart_pocket_depth + 1, r = cart_pinch_r);
            translate([0, 0, cart_pocket_depth - pocket_chamfer])
                cylinder(h = pocket_chamfer + eps, r1 = cart_pinch_r, r2 = cart_pinch_r + pocket_chamfer + eps);
        }
}

// Rebaixo em U pro dedo: atravessa o bloco inteiro em Y, no centro de X.
module finger_notch() {
    hull() {
        translate([0, 0, finger_z]) rotate([90, 0, 0]) cylinder(h = D + 2, r = finger_r, center = true);
        translate([-finger_r, -(D + 2) / 2, finger_z]) cube([finger_w, D + 2, H - finger_z + 1]);
    }
}

// Nervura de guia: prisma vertical colado na parede do slot, rampa 45° no topo.
// y_wall = parede; s = +1 avança pra +Y (parede da frente), -1 pra -Y (de trás).
module rib(xc, y_wall, s) {
    translate([xc - rib_w / 2, y_wall, 0])
        rotate([90, 0, 90])   // local (x,y,z) -> mundo (z, x, y): x local = Y, y local = Z, extrusão em X
            linear_extrude(height = rib_w)
                polygon([[-0.5 * s, floor_t - 0.5], [rib_h * s, floor_t - 0.5],
                         [rib_h * s, rib_top - rib_h], [-0.5 * s, rib_top]]);
}

module ribs() {
    for (xc = rib_xs) {
        rib(xc, slot_y0, 1);
        rib(xc, slot_y1, -1);
    }
}

// true se o retângulo [u0,u1]x[v0,v1] toca algum retângulo de `ex`
function hits(u0, u1, v0, v1, ex) =
    len([for (r = ex) if (u1 > r[0] && u0 < r[1] && v1 > r[2] && v0 < r[3]) 1]) > 0;

// Painel de colmeia em baixo-relevo numa face w x h (coordenadas locais u,v;
// z local aponta pra DENTRO do material). Hexágonos de ponta pra cima,
// centrados na face, faixa sólida um (lados) / hex_margin (topo e fundo) nas
// bordas e hex_margin em volta de cada retângulo de exclusão `ex`.
module hex_relief_face(w, h, ex = [], um = hex_margin) {
    f  = hex_d;
    R  = f / sqrt(3);
    sx = f + hex_web;
    sy = sx * sqrt(3) / 2;
    cols = floor((w - 2 * um - f) / sx) + 1;
    rows = floor((h - 2 * hex_margin - 2 * R) / sy) + 1;
    off_u = (w - (f + (cols - 1) * sx + sx / 2)) / 2;
    off_v = (h - (2 * R + (rows - 1) * sy)) / 2;
    translate([0, 0, -eps])
        linear_extrude(height = hex_relief + eps)
            for (j = [0 : rows - 1], i = [0 : cols - 1]) {
                cu = off_u + f / 2 + i * sx + (j % 2) * sx / 2;
                cv = off_v + R + j * sy;
                if (cu - f / 2 >= um && cu + f / 2 <= w - um
                    && cv - R >= hex_margin && cv + R <= h - hex_margin
                    && !hits(cu - f / 2 - hex_margin, cu + f / 2 + hex_margin,
                             cv - R - hex_margin, cv + R + hex_margin, ex))
                    translate([cu, cv]) rotate(30) circle(r = R, $fn = 6);
            }
}

// exclusões por face (u = ao longo da face a partir da esquerda, v = Z)
face_um   = hex_margin + corner_r;   // faixa lateral: o canto R3 come 3mm de face plana
ex_finger = [L / 2 - finger_r, L / 2 + finger_r, H - finger_depth, H];
ex_front  = [ [end_wall, end_wall + small_pocket_l, H - small_pocket_depth, H],
              [L - end_wall - small_pocket_l, L - end_wall, H - small_pocket_depth, H],
              ex_finger ];
ex_back   = [ [L / 2 - cart_x1 - cart_pinch_r, L / 2 - cart_x0 + cart_pinch_r, H - cart_pocket_depth, H],
              [L / 2 + cart_x0 - cart_pinch_r, L / 2 + cart_x1 + cart_pinch_r, H - cart_pocket_depth, H],
              ex_finger ];
ex_end    = [ [0, D, H - small_pocket_depth, H + 1] ];   // pontas: colmeia só abaixo dos bolsos

module hex_reliefs() {
    // frente (y = y_front, normal -Y): local (u,v,z) -> (u - L/2, y_front + z, v)
    if (hex_front)
        translate([-L / 2, y_front, 0]) mirror([0, 1, 0]) rotate([90, 0, 0]) hex_relief_face(L, H, ex_front, face_um);
    // trás (y = y_back, normal +Y): local (u,v,z) -> (u - L/2, y_back - z, v)
    if (hex_back)
        translate([-L / 2, y_back, 0]) rotate([90, 0, 0]) hex_relief_face(L, H, ex_back, face_um);
    if (hex_ends) {
        // ponta -X: local (u,v,z) -> (-L/2 + z, u - D/2, v)
        translate([-L / 2, -D / 2, 0]) rotate([90, 0, 90]) hex_relief_face(D, H, ex_end, face_um);
        // ponta +X: local (u,v,z) -> (L/2 - z, u - D/2, v)
        translate([L / 2, -D / 2, 0]) mirror([1, 0, 0]) rotate([90, 0, 90]) hex_relief_face(D, H, ex_end, face_um);
    }
}

// Bloco com as 4 arestas verticais arredondadas.
module block() {
    hull()
        for (sx = [-1, 1], sy = [-1, 1])
            translate([sx * (L / 2 - corner_r), sy * (D / 2 - corner_r), 0])
                cylinder(h = H, r = corner_r);
}

// A peça, na orientação de uso: fundo em z=0, centrada em XY.
module stand() {
    union() {
        difference() {
            block();
            // slot do console
            pocket(-slot_l / 2, slot_l / 2, slot_y0, slot_y1, floor_t, slot_chamfer);
            // bolsos de cartucho (trás, nas pontas)
            cart_pocket(cart_x0, cart_x1);
            cart_pocket(-cart_x1, -cart_x0);
            // bolsos estreitos (frente, nas pontas)
            for (s = [-1, 1])
                pocket(min(s * x_in, s * (x_in - small_pocket_l)), max(s * x_in, s * (x_in - small_pocket_l)),
                       small_y0, small_y1, H - small_pocket_depth, pocket_chamfer);
            finger_notch();
            hex_reliefs();
        }
        ribs();
    }
}

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
if (part == "stand") {
    stand();
} else if (part == "plate") {
    // JOB ÚNICO: a peça na orientação de uso, girada 45° em Z pra caber na
    // cama de 220. PLA, sem brim, sem suporte.
    rotate([0, 0, plate_angle]) stand();
} else if (part == "cut") {
    // DIAGNÓSTICO: fatia da ponta +X cortada pelo meio dos bolsos.
    intersection() {
        stand();
        translate([(cart_x0 + cart_x1) / 2, -D, -1]) cube([L, 2 * D, H + 2]);
    }
} else if (part == "cut_rib") {
    // DIAGNÓSTICO: corte transversal pelo meio da nervura de x = +20 (mostra
    // canal de 18, rampas de entrada e o piso).
    intersection() {
        stand();
        translate([rib_x_mid[0], -D, -1]) cube([L, 2 * D, H + 2]);
    }
}
