// psa-box-01.scad
// Caixa GRANDE para slabs PSA (cartas graduadas, lacradas no acrílico da
// PSA), em DUAS FILAS de 19 = 38 slabs NUAS — sem bumper, sem capa, sem case
// extra por cima. Alvo: FlashForge AD5X (cama 220, conforto <= 210).
//
// Derivada do "Porta_carte_PSA_x10" (modelo de terceiro, em
// organizadores_tcg/terceiros/): mesma ideia de pente + tampa telescópica,
// com duas filas e quase o dobro de comprimento (19 vagas por fila, contra
// 10 no original).
//
// COMO SE MANUSEIA:
//   As slabs entram EM PÉ, de cima, uma em cada vaga. Elas sobram 30mm pra
//   fora da boca da base. Pra tirar uma: PINÇA a slab pelas duas bordas X
//   (as bordas estreitas de 6.3mm) nessa parte exposta — o polegar na borda
//   de FORA (encostada na parede externa) e o indicador na borda de DENTRO,
//   que fica de frente pro VÃO DE DEDO entre as duas filas — e puxa pra
//   cima. A vaga é justa (0.4/lado na espessura), então a slab não inclina
//   (no máximo ~1.3mm no topo), e entre duas vizinhas
//   sobram só 2.3mm. O acesso é sempre pela BORDA, nunca pela face.
//   O vão entre as filas tem `row_gap` = 20mm (21mm entre as bordas das
//   slabs). As paredes do meio só sobem até 2mm acima das nervuras, então
//   a borda de dentro fica livre nos ~53mm de cima da slab (30 fora + 23
//   dentro da base) — o dedo desce no vão e encosta nela. A ponta do dedo
//   (~16mm) é maior que a borda de 6.3mm: ela encosta também nas bordas das
//   duas vizinhas. Pinçar firme na do meio e puxar reto.
//   A tampa desce por cima e encaixa num rebaixo (tongue) de 20mm no topo da
//   base, guiada pelas entradas arredondadas (r1.0 no topo do ressalto e na
//   boca da tampa). O encaixe é JUSTO (0.1/lado, igual ao psa-box-02): segura
//   a tampa sem trava. Fechada, a lateral fica lisa e contínua — a tampa NÃO
//   sobressai. Pra abrir, segura a base com uma mão e puxa a tampa pra cima
//   pela borda com a outra (o relevo da colmeia nas laterais ajuda a pegada).
//
// MEDIDAS: slab nua medida com PAQUÍMETRO pelo usuário (4 vezes, 2026-10-13):
// 80.3 x 135.3 x 6.2mm. Ele tem slabs de GRADD, GBA, PSA e CAPY; só a
// espessura varia (~0.1mm), então slab_t = 6.3 = a MAIS GROSSA, e a caixa
// aceita as quatro. (Antes era engenharia reversa de malhas de terceiros,
// 83.6 x 139 x 7.1 — superestimada.) Mesmo assim, IMPRIMA O part="test"
// ANTES das peças grandes: ele prova as folgas com o empeno real.
//
// FOLGA DA TAMPA 0.1/lado — CONTRARIA A REGRA 6 DO CLAUDE.md DE PROPÓSITO.
// No psa-box-02 (mesmo tipo de encaixe: tampa telescópica de parede fina
// sobre um gargalo) a 0.5/lado foi impressa e testada na mão em 2026-10-13 e
// ficou SOLTA; a original da DAMA_Lab, com 0.1/lado e entrada em raio r1.0,
// estava muito boa. Decisão do usuário: mesma folga e mesma entrada aqui.
// NÃO "corrigir" de volta pra 0.5.
//
// Peças: "base" (o corpo com os pentes) e "lid" (a tampa). Cada uma ocupa a
// cama quase toda, então são DOIS jobs de impressão separados. As duas
// imprimem SEM SUPORTE na orientação exportada (base com o chão na cama, boca
// pra cima; tampa com o teto na cama, boca pra cima). Existe ainda um
// terceiro job, "test": o gabarito de 3 vagas pra conferir o encaixe da slab
// ANTES de mandar as peças grandes — imprima ele primeiro, sempre.
//   openscad -o stl/psa-box-01-base.stl -D 'part="base"' psa-box-01.scad
//   openscad -o stl/psa-box-01-lid.stl  -D 'part="lid"'  psa-box-01.scad
//   openscad -o stl/psa-box-01-test.stl -D 'part="test"' psa-box-01.scad
//   openscad -o 3mf/psa-box-01-test.3mf -D 'part="test"'  psa-box-01.scad
//   openscad -o 3mf/psa-box-01-base.3mf -D 'part="plate"' psa-box-01.scad
//   openscad -o 3mf/psa-box-01-lid.3mf  -D 'part="lid"'   psa-box-01.scad
// ("plate" = job: com 2 filas é a base sozinha — a tampa tem o mesmo
// footprint e não cabe junto; com 1 fila a tampa entra do lado, ver
// plate_both.) part="demo" (base + slabs de mentira, uma sendo puxada, +
// tampa levantada) e part="cut" (corte no meio do conjunto fechado, pra
// conferir o encaixe e o vão de dedo) são SÓ pra preview — nunca exportar.
//
// Variantes por include: definir rows_override / slots_override /
// smooth_override / slab_{w,h,t}_override antes do include (padrão is_undef
// abaixo; é o que o ../psa-box-fit faz — ele usa smooth_override = true: tudo
// liso — e o ../psa-cgc-fit, que ainda troca a slab pela CGC). Os números
// nos comentários (6.3, 7.1, 8.6, 2.3mm entre vizinhas, ~1.3 de inclinação)
// são os da PSA; a geometria e os ECHO derivam dos parâmetros. Por CLI o
// override NÃO pega (OpenSCAD 2021.01): use -D slots_per_row=N. Com
// footprint <= 210 cabem até 23 vagas por fila (Y = 203.1; 24 daria 211.7,
// justo).

/* [Peça a renderizar] */
part = "both"; // "base" | "lid" | "test" (gabarito de 3 vagas) | "plate" (job: base, + tampa se couber) | "both" (preview lado a lado) | "demo" | "cut"

/* [Slab - medida com paquímetro (2026-10-13); vale p/ GRADD, GBA, PSA, CAPY] */
// (override por include: o ../psa-cgc-fit troca pela slab CGC 80.0 x 135.3 x 7.8)
slab_w = is_undef(slab_w_override) ? 80.3  : slab_w_override; // mm, largura da slab (vira X, atravessa a canaleta)
slab_h = is_undef(slab_h_override) ? 135.3 : slab_h_override; // mm, altura da slab (vira Z, é o que fica em pé)
slab_t = is_undef(slab_t_override) ? 6.3   : slab_t_override; // mm, espessura da slab (vira Y, define a vaga): 6.2 medido + 0.1 da marca mais grossa

/* [Vagas e filas] */
slots_per_row = is_undef(slots_override) ? 19 : slots_override; // vagas por fila
rows          = is_undef(rows_override)  ? 2  : rows_override;  // nº de filas lado a lado
// true = acabamento LISO: sem colmeia em relevo e sem fenda nenhuma (nem as
// passantes das paredes internas). As paredes ficam inteiras na espessura
// nominal, o teto da tampa encosta inteiro na cama e o fatiador não tem
// ponte nem célula pra contornar. É o que o psa-box-fit usa.
smooth        = is_undef(smooth_override) ? false : smooth_override;
// Vaga: 0.4/lado (não 0.3) porque a slab desce 80mm entre nervuras finas e
// altas — o pé de elefante estreita justo o fundo, onde ela tem que assentar,
// e nervura de 1.5mm em pé tende a sair gorda/inclinada. Custa só 0.2mm de
// passo (1.9mm em 19 vagas).
slot_gap_t = 0.4;  // mm por lado, folga na ESPESSURA da slab -> vaga de 7.1
slot_gap_w = 0.5;  // mm por lado, folga na LARGURA (deslize longo, regra 6) -> canaleta de 81.3
divider    = 1.5;  // mm, espessura da divisória entre vagas (passo = vaga + isto)
// VÃO DE DEDO entre as filas: é por ele que o indicador alcança a borda de
// DENTRO da slab (a de fora o polegar pega acima da parede externa). 20mm de
// parede a parede dão 21mm entre as bordas das slabs — cabe um indicador.
row_gap    = 20;   // mm, distância entre as canaletas de duas filas vizinhas
mid_wall   = 2.0;  // mm, parede interna de cada lado do vão (segura as nervuras de dentro)
mid_over   = 2;    // mm, quanto as paredes internas sobem ACIMA do topo das nervuras

/* [Paredes] */
// wall = ressalto (tongue_t) + folga do encaixe (lid_fit) + saia da tampa.
// 1.8 + 0.1 + 1.5 = 3.4: ressalto e saia >= 1.2, topo do ressalto 0.8 plano
// depois do raio de 1.0, e 2.5mm atrás do relevo.
wall     = 3.4; // mm, paredes externas
floor_t  = 2.4; // mm, chão da base (MACIÇO: carrega ~1.2kg de slabs e é a barreira de luz por baixo)
corner_r = 3;   // mm, raio dos cantos verticais (anti-empeno e melhor na mão)

/* [Pente - nervuras que separam as slabs] */
// Só nas duas pontas da canaleta (como no original): seguram a borda da
// slab e deixam o miolo vazio, que é onde estaria o filamento à toa.
rib_len   = 9;   // mm, quanto cada nervura avança pra dentro da canaleta
rib_h     = 80;  // mm, altura da nervura a partir do chão (dos 135.3 da slab)
rib_lead  = 4;   // mm, chanfro 45° no topo da nervura (funil de entrada)
rib_tip_t = 0.8; // mm, espessura da nervura no topo (telhado, imprime sem ponte; 2 linhas de 0.4)

/* [Encaixe da tampa] */
grip        = 30;  // mm, quanto a slab sobra pra fora da base (é a pegada da mão)
tongue_h    = 20;  // mm, altura do rebaixo em que a tampa encaixa
tongue_t    = 1.8; // mm, espessura do ressalto que sobra no rebaixo
// 0.1/lado = psa-box-02 / original DAMA_Lab. Contraria a regra 6 de
// propósito (0.5 testada no psa-box-02 ficou solta). NÃO corrigir de volta.
lid_fit     = 0.1; // mm por lado, folga do encaixe tampa x ressalto
neck_round  = 1.0; // mm, raio na quina EXTERNA do topo do ressalto (entrada da tampa)
mouth_round = 1.0; // mm, raio na quina INTERNA da boca da saia (entrada no ressalto)
round_steps = 8;   // fatias por raio (resolução do arredondado)
lid_wall    = 2.4; // mm, parede da tampa acima do encaixe
lid_top     = 2.4; // mm, teto da tampa (é a face que vai na cama; 1.8 atrás do relevo)
lid_head    = 3.0; // mm, folga entre o topo da slab e o teto da tampa

/* [Colmeia - identidade visual do repo, em BAIXO RELEVO] */
// A caixa é uma BARREIRA DE LUZ: slab graduada desbota com UV, então nada
// que dá pro lado de fora é passante. A colmeia é gravada na face externa e
// a parede continua inteira atrás — de fora o desenho é o mesmo.
// Único vazado que sobra: as fendas das PAREDES INTERNAS do vão de dedo,
// que separam uma fila do poço do meio e não enxergam o lado de fora com a
// tampa posta.
hex_d       = 10;  // mm, hexágono entre faces (paredes de ponta ±Y da base)
lid_hex_d   = 9;   // mm, hexágono da tampa (teto e faixa lateral)
hex_web     = 2.6; // mm, teia entre hexágonos vizinhos
hex_margin  = 4;   // mm, borda sólida em volta de cada painel de colmeia
relief      = 0.9; // mm, profundidade do relevo na base (parede 3.4 -> sobra 2.5)
lid_relief  = 0.6; // mm, profundidade do relevo na tampa (parede/teto 2.4 -> sobra 1.8)
louver_w    = 5.0; // mm, largura das fendas hexagonais entre nervuras
louver_z0   = 12;  // mm, z de baixo das fendas
louver_z1   = 74;  // mm, z de cima das fendas

/* [Qualidade] */
$fn = 48;

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
slot_t  = slab_t + 2 * slot_gap_t;          // 7.1 — largura da vaga
pitch   = slot_t + divider;                 // 8.6 — passo de uma slab pra outra
channel = slab_w + 2 * slot_gap_w;          // 81.3 — canaleta (X) de cada fila

inner_y = slots_per_row * slot_t + (slots_per_row - 1) * divider; // 161.9
box_x   = rows * channel + (rows - 1) * row_gap + 2 * wall;       // 189.4
box_y   = inner_y + 2 * wall;                                     // 168.7

// x da parede de começo da canaleta da fila j
function row_x0(j) = wall + j * (channel + row_gap);

base_h   = floor_t + slab_h - grip; // 107.7 — altura da base
shoulder = base_h - tongue_h;       // 87.7  — onde a boca da tampa apoia
slab_top = floor_t + slab_h;        // 137.7 — topo da slab, a partir da cama

// vão de dedo
mid_h       = rib_h + mid_over;               // 82   — paredes internas, a partir do chão
mid_top_z   = floor_t + mid_h;                // 84.4 — topo delas, a partir da cama
well_w      = row_gap - 2 * mid_wall;         // 16   — poço (com chão) entre as paredes internas
finger_slot = row_gap + 2 * slot_gap_w;       // 21   — entre as bordas de dentro das slabs
inner_free  = slab_top - mid_top_z;           // 53.3 — borda de DENTRO livre (30 fora + 23.3 dentro)

skirt_wall = wall - tongue_t - lid_fit;                 // 1.5 — parede fina da tampa no encaixe
skirt_h    = tongue_h + 0.6;                            // 20.6 — 0.6 de folga pra boca assentar no ombro
lid_h      = slab_top + lid_head + lid_top - shoulder;  // 55.4 — altura externa da tampa
closed_h   = shoulder + lid_h;                          // 143.1 — conjunto fechado
lead_in    = lid_fit + neck_round + mouth_round;        // 2.1 — boca da saia x topo do ressalto, por lado
tongue_flat = tongue_t - neck_round;                    // 0.8 — topo plano do ressalto
mouth_lip   = skirt_wall - mouth_round;                 // 0.5 — saia na última camada da boca

// recuo de uma aresta arredondada de raio R a uma altura t da face (0 = na face)
function round_in(R, t) = R - sqrt(max(R * R - (R - t) * (R - t), 0));

// Quantas vagas por fila cabem no alvo de conforto da AD5X (Y <= 210).
max_slots_210 = floor((210 - 2 * wall + divider) / pitch); // 23

capacity = rows * slots_per_row; // 38 slabs

// Chapa de impressão: a tampa vai do lado da base quando as duas cabem em
// <= 210 (uma fila só); com duas filas não cabe e a base é job sozinha.
plate_gap  = 6;                                  // mm, vão entre peças na chapa
plate_both = 2 * box_x + plate_gap <= 210;       // false com 2 filas

assert(tongue_t >= 1.2 && skirt_wall >= 1.2, "ressalto e saia têm que ter >= 1.2");
assert(tongue_flat >= 0.8, "topo do ressalto ficou < 0.8 depois do raio");
assert(mouth_lip > 0, "raio da boca come a saia inteira");
assert(rows == 1 || well_w >= 4, "row_gap pequeno demais pras duas paredes internas");
assert(louver_z1 + 5 <= mid_top_z, "fenda chega perto demais do topo da parede interna (lasca)");
assert(box_x <= 210 && box_y <= 210, "passou do alvo de 210 da AD5X");

echo(str("psa-box: ", rows, " fila(s) x ", slots_per_row, " vagas | base ", box_x, " x ", box_y, " x ", base_h,
         " | tampa ", box_x, " x ", box_y, " x ", lid_h,
         " | fechado h=", closed_h,
         " | vaga ", slot_t, " passo ", pitch, " canaleta ", channel,
         " | ", capacity, " slabs (ate ", max_slots_210, "/fila em <=210)",
         " | chapa ", plate_both ? "base + tampa" : "so a base"));
echo(str("ENCAIXE: ressalto ", tongue_t, " + folga ", lid_fit, " + saia ", skirt_wall,
         " = parede ", wall, " | entrada r", neck_round, " + r", mouth_round, " = ", lead_in, "/lado",
         " | topo plano do ressalto ", tongue_flat, " | saia na boca ", mouth_lip,
         " | folga topo da slab x teto ", lid_head));
if (rows > 1)
    echo(str("VAO DE DEDO: ", row_gap, " entre canaletas, ", finger_slot, " entre bordas das slabs",
             " | paredes internas ", mid_wall, " ate z=", mid_top_z, " (", mid_over, " acima da nervura)",
             " | poco ", well_w, " com chao", " | borda de dentro livre ", inner_free,
             " (", grip, " fora + ", base_h - mid_top_z, " dentro) | borda de fora livre ", grip));
echo(str("BARREIRA DE LUZ: parede da base ", wall, " - relevo ", relief,
         " = ", wall - relief, " de material atras da colmeia",
         " | parede da tampa ", lid_wall, " - ", lid_relief, " = ", lid_wall - lid_relief,
         " | teto da tampa ", lid_top, " - ", lid_relief, " = ", lid_top - lid_relief,
         " | chao da base macico ", floor_t,
         smooth ? " | LISO: sem relevo e sem fenda" :
         rows > 1 ? " | unico vazado: fendas das paredes internas (dao pro poco)" : " | nenhum vazado"));

// ---------------------------------------------------------------------
// Primitivas de contorno
// ---------------------------------------------------------------------
// Retângulo de cantos redondos com o canto em (0,0).
module rrect(w, d, r) {
    hull() for (x = [r, w - r], y = [r, d - r]) translate([x, y]) circle(r = r);
}

// O contorno da caixa recuado `i` por lado (usado pra cavidades e rebaixos).
module inset_rrect(i) {
    translate([i, i]) rrect(box_x - 2 * i, box_y - 2 * i, max(0.4, corner_r - i));
}

// fatia fina (0.01) do contorno recuado `i`, em z
module inset_slice(i, z) {
    translate([0, 0, z]) linear_extrude(0.01) inset_rrect(i);
}

// ---------------------------------------------------------------------
// Colmeia: células hexagonais (prismas de z=0 a z=h) em arranjo de colmeia
// cobrindo o retângulo a x b no plano XY, com `hex_margin` de borda sólida.
// Só entra hexágono que caiba INTEIRO na área útil (regra "sem lascas" do
// repo). Hexágonos de PONTA PRA CIMA: em parede vertical o topo de cada
// célula fecha em bico, então imprime sem ponte reta.
// ---------------------------------------------------------------------
module hex_cells(a, b, h, f = hex_d) {
    R  = f / sqrt(3);      // circunraio (centro -> ponta)
    sx = f + hex_web;      // passo entre colunas
    sy = sx * sqrt(3) / 2; // passo entre fileiras (as ímpares deslocam sx/2)

    for (j = [0 : ceil(b / sy)], i = [0 : ceil(a / sx)]) {
        cx = hex_margin + f / 2 + i * sx + (j % 2) * sx / 2;
        cy = hex_margin + R + j * sy;
        if (cx + f / 2 <= a - hex_margin && cy + R <= b - hex_margin)
            translate([cx, cy, 0])
                rotate([0, 0, 30])
                    cylinder(h = h, r = R, $fn = 6);
    }
}

// BAIXO RELEVO: cava `d` PRA CIMA a partir da superfície em z=0 — nunca vira
// furo passante. É o que fecha a caixa contra a LUZ mantendo o desenho de
// colmeia: de fora fica igual, mas sobra parede inteira atrás. Mesmo padrão
// do hex_relief do pokemon-game-case.
module hex_relief(a, b, d, f = hex_d) {
    translate([0, 0, -0.05]) hex_cells(a, b, d + 0.05, f);
}

// Colmeia em baixo relevo numa parede de ponta (plano XZ): `yf` é a FACE
// EXTERNA e `dir` diz pra que lado fica o material (+1 = material em +Y).
module hex_relief_y(x0, yf, z0, a, b, d, f = hex_d, dir = 1) {
    translate([x0, yf, z0])
        mirror([0, dir > 0 ? 1 : 0, 0])
            rotate([90, 0, 0])
                hex_relief(a, b, d, f);
}

// Colmeia em baixo relevo numa parede lateral (plano YZ): `xf` é a FACE
// EXTERNA e `dir` diz pra que lado fica o material (+1 = material em +X).
module hex_relief_x(xf, y0, z0, a, b, d, f = hex_d, dir = 1) {
    translate([xf, y0, z0])
        mirror([dir > 0 ? 0 : 1, 0, 0])
            rotate([0, 0, 90])
                rotate([90, 0, 0])
                    hex_relief(a, b, d, f);
}

// Fenda hexagonal alongada (hexágono esticado em Z), avançando t em X.
// Ponta pra cima e pra baixo: imprime sem ponte, igual às células da colmeia.
// É a versão "entre nervuras" da colmeia — hexágono redondo não cabe nos
// 7.1mm entre duas nervuras, o esticado cabe. Usada PASSANTE só nas paredes
// internas do vão de dedo; nas paredes externas entra como baixo relevo.
module louver(w, h, t) {
    R = w / sqrt(3);
    d = max(0.01, h - 2 * R);
    hull() for (s = [-1, 1])
        translate([0, 0, s * d / 2])
            rotate([0, 90, 0])
                cylinder(h = t, r = R, $fn = 6);
}

// ---------------------------------------------------------------------
// Nervura do pente: cresce em +X a partir da parede, com o topo afinando
// em telhado (funil que guia a slab pra dentro da vaga).
// ---------------------------------------------------------------------
module rib(h = rib_h) {
    hull() {
        cube([rib_len, divider, h - rib_lead]);
        translate([0, (divider - rib_tip_t) / 2, h - rib_lead])
            cube([max(0.01, rib_len - rib_lead), rib_tip_t, rib_lead]);
    }
}

// ---------------------------------------------------------------------
// Gabarito de teste (part="test"): um PEDAÇO da base — uma fila só, 3 vagas,
// 45mm de altura. Sai em ~1h e prova, com a slab na mão, as folgas que o
// paquímetro não garante: a LARGURA da canaleta, a ESPESSURA da vaga e o
// passo/entrada do pente, já com o empeno real da impressora.
// Imprima ISTO ANTES de mandar a base (peso no README/index.json).
//   openscad -o 3mf/psa-box-01-test.3mf -D 'part="test"' psa-box-01.scad
// A slab tem que descer até o chão sozinha, sem forçar, e não dançar mais que
// um chacoalho de folga. Se não entrar, subir slot_gap_w (largura) ou
// slot_gap_t (espessura) e repetir o gabarito.
// ---------------------------------------------------------------------
module test_gauge(n = 3, h = 45) {
    gx = channel + 2 * wall;
    gy = n * slot_t + (n - 1) * divider + 2 * wall;
    rh = h - floor_t - 2;
    union() {
        difference() {
            linear_extrude(h) rrect(gx, gy, corner_r);
            translate([wall, wall, floor_t]) cube([channel, gy - 2 * wall, h]);
        }
        for (i = [0 : n - 2]) {
            y = wall + i * pitch + slot_t;
            translate([wall, y, floor_t]) rib(rh);
            translate([wall + channel, y, floor_t]) mirror([1, 0, 0]) rib(rh);
        }
    }
}

// ---------------------------------------------------------------------
// Base: caixa de chão maciço, uma canaleta por fila, VÃO DE DEDO entre as
// filas (duas paredes internas baixas com um poço de chão maciço no meio),
// pente de nervuras nas faces compridas de cada canaleta, colmeia nas paredes
// de ponta, fendas hexagonais entre as nervuras e rebaixo pra tampa no topo.
// Já na orientação de impressão (chão na cama, boca pra cima) — sem suporte.
// ---------------------------------------------------------------------
module base() {
    union() {
        difference() {
            linear_extrude(base_h) rrect(box_x, box_y, corner_r);

            // canaletas das filas (sobem além do topo -> boca aberta)
            for (j = [0 : rows - 1])
                translate([row_x0(j), wall, floor_t])
                    cube([channel, inner_y, base_h]);

            // vão de dedo entre filas vizinhas: o poço entre as duas paredes
            // internas (chão maciço embaixo, é o mesmo chão da caixa) e, acima
            // do topo delas, o vão inteiro aberto de uma canaleta à outra.
            // Fica entre as paredes de ponta (Y de wall a wall+inner_y), então
            // não abre pro lado de fora. (guarda rows > 1: no 2021.01 o range
            // [0:-1] é INVERTIDO e roda 2 vezes.)
            if (rows > 1) for (k = [0 : rows - 2]) {
                xg = row_x0(k) + channel;   // começo do vão (fim da canaleta k)
                translate([xg + mid_wall, wall, floor_t])
                    cube([well_w, inner_y, base_h]);
                translate([xg - 0.01, wall, mid_top_z])
                    cube([row_gap + 0.02, inner_y, base_h]);
            }

            // rebaixo do encaixe da tampa: tira a casca externa no topo,
            // deixando um ressalto de `tongue_t` que entra na tampa
            translate([0, 0, shoulder])
                linear_extrude(base_h - shoulder + 0.1)
                    difference() {
                        offset(delta = 0.2) rrect(box_x, box_y, corner_r);
                        inset_rrect(wall - tongue_t);
                    }

            // raio de entrada na quina externa do topo do ressalto: guia a
            // saia da tampa pra dentro. Imprime sem suporte (a face sobe
            // recuando pra dentro, cada camada apoia na de baixo). O que fica
            // é o hull convexo das fatias do arredondado; sai o resto.
            difference() {
                translate([0, 0, base_h - neck_round - 0.01])
                    linear_extrude(neck_round + 0.2)
                        offset(delta = 0.2) rrect(box_x, box_y, corner_r);
                hull() {
                    for (i = [0 : round_steps]) {
                        t = neck_round * i / round_steps;
                        inset_slice(wall - tongue_t + round_in(neck_round, t), base_h - t - 0.01);
                    }
                    inset_slice(wall - tongue_t + neck_round, base_h + 0.3);
                }
            }

            // colmeia em BAIXO RELEVO nas duas paredes de ponta (±Y).
            // Gravada na face externa; sobra (wall - relief) de parede cheia.
            if (!smooth) {
                hex_relief_y(corner_r + 1, 0, floor_t + 1,
                             box_x - 2 * (corner_r + 1), shoulder - floor_t - 2,
                             relief, hex_d, dir = 1);
                hex_relief_y(corner_r + 1, box_y, floor_t + 1,
                             box_x - 2 * (corner_r + 1), shoulder - floor_t - 2,
                             relief, hex_d, dir = -1);
            }

            // fendas hexagonais entre as nervuras. Nas paredes ±X entram como
            // BAIXO RELEVO na face externa (é casca da caixa: não pode vazar).
            // Nas PAREDES INTERNAS do vão continuam PASSANTES: dão pro poço do
            // meio, que é interno — ali o vazado só economiza material. Pula a
            // primeira e a última vaga de cada fila — furo colado no canto
            // vira lasca (regra "sem lascas" do repo).
            if (!smooth) for (i = [1 : slots_per_row - 2]) {
                yc = wall + i * pitch + slot_t / 2;
                zc = (louver_z0 + louver_z1) / 2;
                hh = louver_z1 - louver_z0;
                translate([-0.05, yc, zc])          louver(louver_w, hh, relief + 0.05);
                translate([box_x - relief, yc, zc]) louver(louver_w, hh, relief + 0.05);
                if (rows > 1) for (k = [0 : rows - 2]) {
                    xg = row_x0(k) + channel;
                    translate([xg - 0.1, yc, zc])
                        louver(louver_w, hh, mid_wall + 0.2);
                    translate([xg + row_gap - mid_wall - 0.1, yc, zc])
                        louver(louver_w, hh, mid_wall + 0.2);
                }
            }
        }

        // pente: 2 nervuras por divisória por fila (uma em cada ponta da canaleta)
        for (j = [0 : rows - 1]) {
            x0 = row_x0(j);
            x1 = x0 + channel;
            for (i = [0 : slots_per_row - 2]) {
                y = wall + i * pitch + slot_t;
                translate([x0, y, floor_t]) rib();
                translate([x1, y, floor_t]) mirror([1, 0, 0]) rib();
            }
        }
    }
}

// ---------------------------------------------------------------------
// Tampa: caixa aberta embaixo que desce sobre o rebaixo da base. A parede
// afina pra `skirt_wall` nos últimos `skirt_h` (a saia que abraça o
// ressalto) — a transição é um chanfro de 45°, então imprime sem suporte.
// Modelada JÁ na orientação de impressão: teto na cama, boca pra cima (a
// saia fina e o raio da boca ficam no topo do print).
// ---------------------------------------------------------------------
module lid() {
    difference() {
        linear_extrude(lid_h) rrect(box_x, box_y, corner_r);

        // cavidade principal
        translate([0, 0, lid_top])
            linear_extrude(lid_h - lid_top + 0.1) inset_rrect(lid_wall);

        // rampa 45° + saia fina do encaixe
        hull() {
            inset_slice(lid_wall,   lid_h - skirt_h - (lid_wall - skirt_wall));
            inset_slice(skirt_wall, lid_h - skirt_h);
        }
        translate([0, 0, lid_h - skirt_h])
            linear_extrude(skirt_h + 0.1) inset_rrect(skirt_wall);

        // raio de entrada na quina interna da boca da saia (no topo do
        // print): a saia afina subindo, cada camada apoia na de baixo.
        // Côncavo do lado da cavidade -> hull fatia a fatia.
        for (i = [0 : round_steps - 1]) {
            t0 = mouth_round * i / round_steps;
            t1 = mouth_round * (i + 1) / round_steps;
            hull() {
                inset_slice(skirt_wall - round_in(mouth_round, t1), lid_h - t1);
                inset_slice(skirt_wall - round_in(mouth_round, t0), lid_h - t0);
            }
        }
        // acima da boca (só pra o corte passar limpo, sem inclinar o raio)
        translate([0, 0, lid_h - 0.01])
            linear_extrude(0.4) inset_rrect(skirt_wall - mouth_round);

        // colmeia em BAIXO RELEVO no TETO. Esta é a cara da caixa fechada e a
        // face que mais pega sol, então é justamente a que não pode vazar:
        // grava `lid_relief` e deixa (lid_top - lid_relief) de teto cheio.
        // É também a face que vai na cama: como o relevo começa em z=0, só a
        // TEIA entre hexágonos + a borda lisa encostam na cama (as células
        // ficam no ar e fecham com uma ponte curta de 9mm sobre 0.6mm).
        // Aceito de propósito — ver README: área de contato medida na malha.
        if (!smooth) translate([lid_wall + 2, lid_wall + 2, -0.05])
            hex_cells(box_x - 2 * (lid_wall + 2), box_y - 2 * (lid_wall + 2),
                      lid_relief + 0.05, lid_hex_d);

        // colmeia em baixo relevo nas 4 paredes, na faixa grossa (abaixo da saia)
        band_z0 = lid_top + 1;
        band_b  = lid_h - skirt_h - (lid_wall - skirt_wall) - band_z0 - 1;
        if (!smooth) hex_relief_y(corner_r + 1, 0, band_z0,
                     box_x - 2 * (corner_r + 1), band_b, lid_relief, lid_hex_d, dir = 1);
        if (!smooth) hex_relief_y(corner_r + 1, box_y, band_z0,
                     box_x - 2 * (corner_r + 1), band_b, lid_relief, lid_hex_d, dir = -1);
        if (!smooth) hex_relief_x(0, corner_r + 1, band_z0,
                     box_y - 2 * (corner_r + 1), band_b, lid_relief, lid_hex_d, dir = 1);
        if (!smooth) hex_relief_x(box_x, corner_r + 1, band_z0,
                     box_y - 2 * (corner_r + 1), band_b, lid_relief, lid_hex_d, dir = -1);
    }
}

// A tampa na posição de USO (boca pra baixo, encaixada no rebaixo da base).
// Só pros previews "demo"/"cut" — a peça exportada é sempre lid().
module lid_placed() {
    translate([0, box_y, shoulder + lid_h]) rotate([180, 0, 0]) lid();
}

// Slab de mentira, só pros previews.
module slab_mock() {
    translate([slab_w / 2, slab_t / 2, 0])
        linear_extrude(slab_h)
            offset(r = 1.5) square([slab_w - 3, slab_t - 3], center = true);
}

// Algumas slabs nas vagas, em pé (a vaga justa não deixa inclinar). Com
// `lift` > 0, a slab 9 da primeira fila aparece sendo PUXADA reto pra cima —
// é o movimento real: pinça pelas duas bordas X e sobe.
module demo_slabs(lift = 0) {
    for (j = [0 : rows - 1], i = [0, 1, 2, 9, slots_per_row - 1]) {
        x = row_x0(j) + slot_gap_w;
        y = wall + i * pitch + slot_gap_t;
        translate([x, y, floor_t + ((i == 9 && j == 0) ? lift : 0)]) slab_mock();
    }
}

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
if (part == "base") {
    base();
} else if (part == "plate") {
    base();
    if (plate_both) translate([box_x + plate_gap, 0, 0]) lid();
} else if (part == "lid") {
    lid();
} else if (part == "test") {
    test_gauge();
} else if (part == "demo") {
    base();
    demo_slabs(lift = 25);
    translate([0, 0, 60]) lid_placed(); // tampa levantada, pra ver as duas peças
} else if (part == "cut") {
    // corte no meio do conjunto FECHADO com slabs dentro: é aqui que se
    // confere o encaixe da tampa (saia x ressalto x ombro), o vão de dedo e a
    // folga sobre o topo da slab. Preview only.
    difference() {
        union() { base(); demo_slabs(); lid_placed(); }
        translate([-1, box_y / 2, -1]) cube([box_x + 2, box_y, closed_h + 2]);
    }
} else {
    // preview lado a lado (não montado)
    base();
    translate([0, box_y + 25, 0]) lid();
}
