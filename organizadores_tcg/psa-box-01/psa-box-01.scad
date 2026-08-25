// psa-box-01.scad
// Caixa GRANDE para slabs PSA (cartas graduadas, lacradas no acrílico da
// PSA), em DUAS FILAS. Dimensionada para a cama antiga de 180; na AD5X
// (220x220) sobra folga em volta.
// Guarda 38 slabs NUAS — sem bumper, sem capa, sem case extra por cima.
//
// Derivada do "Porta_carte_PSA_x10" (modelo de terceiro, em
// organizadores_tcg/): mesma ideia de pente + tampa telescópica, mas com o
// dobro de largura (duas filas) e quase o dobro de comprimento (19 vagas por
// fila, contra 10 no original).
//
// COMO SE MANUSEIA:
//   As slabs entram EM PÉ, de cima, uma em cada vaga. Elas sobram ~30mm pra
//   fora da boca da base — é essa parte exposta que a mão pega. As nervuras
//   (o "pente") só sobem 80mm dos 139 da slab, então os ~59mm de cima ficam
//   soltos: dá pra abrir as slabs em leque com o dedo, como pasta suspensa,
//   inclinar a que você quer pra trás e pinçar. (É exatamente assim que o
//   modelo original funciona nas fotos do autor — sem isso, com 1.9mm de
//   folga entre slabs vizinhas, não entraria dedo nenhum.)
//   A tampa desce por cima e encaixa num rebaixo (tongue) de 20mm no topo da
//   base; fechada, a lateral fica lisa e contínua — a tampa NÃO sobressai.
//   Pra abrir, segura a caixa e puxa a tampa pra cima com as duas mãos (os
//   furos da colmeia dão pegada).
//
// ATENÇÃO ÀS MEDIDAS: slab_w/slab_h/slab_t NÃO foram tiradas com régua pelo
// usuário — vieram de engenharia reversa de malhas de terceiros, que
// DIVERGEM entre si. O bloco de parâmetros logo abaixo lista as fontes, o
// que foi adotado e por quê. Resumo: esta caixa aceita slab de até
// 84.4 x 142 x 7.5mm, e o teste físico manda. IMPRIMA O part="test" ANTES
// das peças grandes.
//
// Peças: "base" (o corpo com os pentes) e "lid" (a tampa). Cada uma ocupa a
// muita cama, então são DOIS jobs de impressão separados. As duas imprimem
// SEM SUPORTE na orientação exportada (base com o chão na cama, boca pra
// cima; tampa com a face fechada na cama, boca pra cima). Existe ainda um
// terceiro job, "test": o gabarito de 3 vagas pra conferir o encaixe da slab
// ANTES de mandar as peças grandes — imprima ele primeiro, sempre.
//   openscad -o stl/psa-box-01-base.stl -D 'part="base"' psa-box-01.scad
//   openscad -o stl/psa-box-01-lid.stl  -D 'part="lid"'  psa-box-01.scad
//   openscad -o stl/psa-box-01-test.stl -D 'part="test"' psa-box-01.scad
//   openscad -o 3mf/psa-box-01-test.3mf -D 'part="test"'  psa-box-01.scad
//   openscad -o 3mf/psa-box-01-base.3mf -D 'part="plate"' psa-box-01.scad
//   openscad -o 3mf/psa-box-01-lid.3mf  -D 'part="lid"'   psa-box-01.scad
// ("plate" = job = a base sozinha; nada mais cabe junto dela na cama.)
// part="demo" (base + slabs de mentira + tampa levantada) e part="cut"
// (corte no meio do conjunto fechado, pra conferir o encaixe) são SÓ pra
// preview — nunca exportar.
//
// Variantes por include: definir rows_override / slots_override antes do
// include (ex.: uma fila só, ou uma caixa mais curta que sobre margem de
// brim). Ver o padrão is_undef abaixo.

/* [Peça a renderizar] */
part = "both"; // "base" | "lid" | "test" (gabarito de 3 vagas) | "plate" (job 1 = base) | "both" (preview lado a lado) | "demo" | "cut"

/* [Slab PSA - ENGENHARIA REVERSA, não medida com régua] */
// NENHUMA destas três veio da régua do usuário. Só a ESPESSURA (7.1) é
// consenso: a vaga de 7.5 do original fecha com ela e todas as fontes batem.
// Largura e altura são as duas incógnitas, e as fontes DIVERGEM:
//   Porta_carte_PSA_x10.3mf ... canaleta de 85.0 de largura, base 102 fundo
//   my_psa_slab.3mf .......... silhueta de 85.00 x 138.52
//   Slab_Protectors.3mf ...... peças de 85.40 x 140.00 e 86.20 x 140.70
//   nominal PSA documentado .. 3.29" x 5.29" = 83.6 x 134.4
// Adotado 83.6 x 139: a largura é o nominal documentado (a canaleta ainda
// aceita até 84.4) e a altura é o TETO das fontes, porque altura sobrando é
// barata (só encompre a base) e altura faltando trava a tampa.
// ENVELOPE QUE ESTA CAIXA ACEITA: até 84.4 de largura, 142 de altura, 7.5 de
// espessura. IMPRIMA ANTES o part="test" (~45g, ~1h) com uma slab na mão.
// Se a slab real passar de 84.4 de largura, DUAS FILAS NÃO CABEM na AD5X
// (na cama de 220 da AD5X ainda há folga: 2 x 85 = 170 de 220).
slab_w = 83.6; // mm, largura da slab (vira X, atravessa a canaleta)
slab_h = 139;  // mm, altura da slab (vira Z, é o que fica em pé)
slab_t = 7.1;  // mm, espessura da slab (vira Y, é o passo das vagas)

/* [Vagas e filas] */
slots_per_row = is_undef(slots_override) ? 19 : slots_override; // vagas por fila
rows          = is_undef(rows_override)  ? 2  : rows_override;  // nº de filas lado a lado
slot_gap_t = 0.2;  // mm por lado, folga na ESPESSURA da slab -> vaga de 7.5
slot_gap_w = 0.4;  // mm por lado, folga na LARGURA da slab -> canaleta de 84.4
divider    = 1.5;  // mm, espessura da divisória entre vagas (passo = vaga + isto)

/* [Paredes] */
// wall = 2.8 é o MÍNIMO que hospeda o encaixe da tampa (ressalto 1.3 + saia
// 1.3 + folga 0.2). E cada 1mm dele custa 2mm de cama — por isso não é 3.
wall     = 2.8; // mm, paredes externas
spine    = 2.0; // mm, espinho central entre as duas filas
floor_t  = 2.4; // mm, chão da base (MACIÇO: carrega ~1.2kg de slabs E é a aderência de 1ª camada de uma peça de 176mm sem espaço pra brim)
corner_r = 3;   // mm, raio dos cantos verticais (anti-empeno e melhor na mão)

/* [Pente - nervuras que separam as slabs] */
// Só nas duas pontas da canaleta (como no original): seguram a borda da
// slab e deixam o miolo vazio, que é onde estaria o filamento à toa.
rib_len   = 9;   // mm, quanto cada nervura avança pra dentro da canaleta
rib_h     = 80;  // mm, altura da nervura a partir do chão (dos 139 da slab)
rib_lead  = 4;   // mm, chanfro 45° no topo da nervura (funil de entrada)
rib_tip_t = 0.6; // mm, espessura da nervura no topo (telhado, imprime sem ponte)

/* [Encaixe da tampa] */
grip      = 30;  // mm, quanto a slab sobra pra fora da base (é a pegada da mão)
tongue_h  = 20;  // mm, altura do rebaixo em que a tampa encaixa
tongue_t  = 1.3; // mm, espessura do ressalto que sobra no rebaixo
lid_fit   = 0.2; // mm por lado, folga do encaixe (deslize firme, sem travar)
lid_wall  = 2.4; // mm, parede da tampa acima do encaixe
lid_top   = 2.4; // mm, teto da tampa (é a face que vai na cama). Era 2.0 quando
                 // o teto era vazado; virou barreira de luz, então engrossou
                 // pra sobrar 1.8 de material atrás do relevo.
lid_head  = 3.0; // mm, folga entre o topo da slab e o teto da tampa

/* [Colmeia - identidade visual do repo, em BAIXO RELEVO] */
// A caixa é uma BARREIRA DE LUZ: slab graduada desbota com UV, então nada
// que dá pro lado de fora é passante. A colmeia é gravada na face externa e
// a parede continua inteira atrás — de fora o desenho é o mesmo.
// Único vazado que sobra: as fendas dos ESPINHOS, que são internos (separam
// as duas filas) e não enxergam o lado de fora com a tampa posta.
hex_d       = 10;  // mm, hexágono entre faces (paredes de ponta ±Y da base)
lid_hex_d   = 9;   // mm, hexágono da tampa (teto e faixa lateral)
hex_web     = 2.6; // mm, teia entre hexágonos vizinhos
hex_margin  = 4;   // mm, borda sólida em volta de cada painel de colmeia
relief      = 0.9; // mm, profundidade do relevo na base (parede 2.8 -> sobra 1.9)
lid_relief  = 0.6; // mm, profundidade do relevo na tampa (parede/teto 2.4 -> sobra 1.8)
louver_w    = 5.0; // mm, largura das fendas hexagonais entre nervuras
louver_z0   = 12;  // mm, z de baixo das fendas
louver_z1   = 74;  // mm, z de cima das fendas

/* [Qualidade] */
$fn = 48;

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
slot_t  = slab_t + 2 * slot_gap_t;          // 7.5 — largura da vaga
pitch   = slot_t + divider;                 // 9.0 — passo de uma slab pra outra
channel = slab_w + 2 * slot_gap_w;          // 84.4 — canaleta (X) de cada fila

inner_y = slots_per_row * slot_t + (slots_per_row - 1) * divider; // 169.5
box_x   = rows * channel + (rows - 1) * spine + 2 * wall;         // 176.4
box_y   = inner_y + 2 * wall;                                     // 175.1

base_h   = floor_t + slab_h - grip; // 111.4 — altura da base
shoulder = base_h - tongue_h;       // 91.4  — onde a boca da tampa apoia
slab_top = floor_t + slab_h;        // 141.4 — topo da slab, a partir da cama

skirt_wall = wall - tongue_t - lid_fit;                 // 1.3 — parede fina da tampa no encaixe
skirt_h    = tongue_h + 0.6;                            // 20.6 — 0.6 de folga pra boca assentar no ombro
lid_h      = slab_top + lid_head + lid_top - shoulder;  // 55.0 — altura externa da tampa
closed_h   = shoulder + lid_h;                          // 146.4 — conjunto fechado

capacity = rows * slots_per_row; // 38 slabs

echo(str("psa-box-01: base ", box_x, " x ", box_y, " x ", base_h,
         " | tampa ", box_x, " x ", box_y, " x ", lid_h,
         " | fechado h=", closed_h,
         " | vaga ", slot_t, " passo ", pitch, " canaleta ", channel,
         " | ", capacity, " slabs"));
echo(str("BARREIRA DE LUZ: parede da base ", wall, " - relevo ", relief,
         " = ", wall - relief, " de material atras da colmeia",
         " | parede da tampa ", lid_wall, " - ", lid_relief, " = ", lid_wall - lid_relief,
         " | teto da tampa ", lid_top, " - ", lid_relief, " = ", lid_top - lid_relief,
         " | chao da base macico ", floor_t,
         " | unico vazado: fendas dos espinhos (internas)"));

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
// 7.5mm entre duas nervuras, o esticado cabe. Usada PASSANTE só nos espinhos
// (que são internos); nas paredes externas entra como baixo relevo.
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
// 45mm de altura. Sai por ~45g em ~1h e prova, com a slab na mão, as três
// medidas que este projeto não tem da régua: a LARGURA da canaleta, a
// ESPESSURA da vaga e o passo/entrada do pente.
// Imprima ISTO ANTES de mandar a base (~368g, ~20-30h).
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
// Base: caixa de chão maciço, duas canaletas separadas pelo espinho, pente
// de nervuras nas quatro faces internas compridas, colmeia nas paredes de
// ponta, fendas hexagonais entre as nervuras e rebaixo pra tampa no topo.
// Já na orientação de impressão (chão na cama, boca pra cima) — sem suporte.
// ---------------------------------------------------------------------
module base() {
    union() {
        difference() {
            linear_extrude(base_h) rrect(box_x, box_y, corner_r);

            // canaletas das filas (sobem além do topo -> boca aberta)
            for (j = [0 : rows - 1])
                translate([wall + j * (channel + spine), wall, floor_t])
                    cube([channel, inner_y, base_h]);

            // rebaixo do encaixe da tampa: tira a casca externa no topo,
            // deixando um ressalto de `tongue_t` que entra na tampa
            translate([0, 0, shoulder])
                linear_extrude(base_h - shoulder + 0.1)
                    difference() {
                        offset(delta = 0.2) rrect(box_x, box_y, corner_r);
                        inset_rrect(wall - tongue_t);
                    }

            // colmeia em BAIXO RELEVO nas duas paredes de ponta (±Y).
            // Gravada na face externa; sobra (wall - relief) de parede cheia.
            hex_relief_y(corner_r + 1, 0, floor_t + 1,
                         box_x - 2 * (corner_r + 1), shoulder - floor_t - 2,
                         relief, hex_d, dir = 1);
            hex_relief_y(corner_r + 1, box_y, floor_t + 1,
                         box_x - 2 * (corner_r + 1), shoulder - floor_t - 2,
                         relief, hex_d, dir = -1);

            // fendas hexagonais entre as nervuras. Nas paredes ±X entram como
            // BAIXO RELEVO na face externa (é casca da caixa: não pode vazar).
            // Nos ESPINHOS continuam PASSANTES: são internos, separam uma fila
            // da outra e não dão pro lado de fora — ali o vazado só economiza
            // material. Pula a primeira e a última vaga de cada fila — furo
            // colado no canto vira lasca (regra "sem lascas" do repo).
            for (i = [1 : slots_per_row - 2]) {
                yc = wall + i * pitch + slot_t / 2;
                zc = (louver_z0 + louver_z1) / 2;
                hh = louver_z1 - louver_z0;
                translate([-0.05, yc, zc])          louver(louver_w, hh, relief + 0.05);
                translate([box_x - relief, yc, zc]) louver(louver_w, hh, relief + 0.05);
                for (k = [0 : rows - 2])
                    translate([wall + channel + k * (channel + spine) - 0.1, yc, zc])
                        louver(louver_w, hh, spine + 0.2);
            }
        }

        // pente: 2 nervuras por divisória por fila (uma em cada ponta da canaleta)
        for (j = [0 : rows - 1]) {
            x0 = wall + j * (channel + spine);
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
// Modelada JÁ na orientação de impressão: face fechada na cama, boca pra
// cima (é a face fechada, maciça e enorme, que segura a peça na cama).
// ---------------------------------------------------------------------
module lid() {
    difference() {
        linear_extrude(lid_h) rrect(box_x, box_y, corner_r);

        // cavidade principal
        translate([0, 0, lid_top])
            linear_extrude(lid_h - lid_top + 0.1) inset_rrect(lid_wall);

        // rampa 45° + saia fina do encaixe
        hull() {
            translate([0, 0, lid_h - skirt_h - (lid_wall - skirt_wall)])
                linear_extrude(0.01) inset_rrect(lid_wall);
            translate([0, 0, lid_h - skirt_h])
                linear_extrude(0.01) inset_rrect(skirt_wall);
        }
        translate([0, 0, lid_h - skirt_h])
            linear_extrude(skirt_h + 0.1) inset_rrect(skirt_wall);

        // colmeia em BAIXO RELEVO no TETO. Esta é a cara da caixa fechada e a
        // face que mais pega sol, então é justamente a que não pode vazar:
        // grava `lid_relief` e deixa (lid_top - lid_relief) de teto cheio.
        // É também a face que vai na cama — o relevo raso vira um bridge
        // curtinho por célula, trivial pro slicer, e a aderência continua
        // sendo a chapa inteira.
        translate([lid_wall + 2, lid_wall + 2, -0.05])
            hex_cells(box_x - 2 * (lid_wall + 2), box_y - 2 * (lid_wall + 2),
                      lid_relief + 0.05, lid_hex_d);

        // colmeia em baixo relevo nas 4 paredes, na faixa grossa (abaixo da saia)
        band_z0 = lid_top + 1;
        band_b  = lid_h - skirt_h - (lid_wall - skirt_wall) - band_z0 - 1;
        hex_relief_y(corner_r + 1, 0, band_z0,
                     box_x - 2 * (corner_r + 1), band_b, lid_relief, lid_hex_d, dir = 1);
        hex_relief_y(corner_r + 1, box_y, band_z0,
                     box_x - 2 * (corner_r + 1), band_b, lid_relief, lid_hex_d, dir = -1);
        hex_relief_x(0, corner_r + 1, band_z0,
                     box_y - 2 * (corner_r + 1), band_b, lid_relief, lid_hex_d, dir = 1);
        hex_relief_x(box_x, corner_r + 1, band_z0,
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

// Algumas slabs nas vagas, uma inclinada — é assim que a mão tira uma do
// meio: abre o leque na parte que sobra pra fora e pinça.
module demo_slabs() {
    for (j = [0 : rows - 1], i = [0, 1, 2, 9, slots_per_row - 1]) {
        x = wall + j * (channel + spine) + slot_gap_w;
        y = wall + i * pitch + slot_gap_t;
        if (i == 9 && j == 0)
            translate([x, y + 3, floor_t]) rotate([6, 0, 0]) slab_mock();
        else
            translate([x, y, floor_t]) slab_mock();
    }
}

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
if (part == "base" || part == "plate") {
    base();
} else if (part == "lid") {
    lid();
} else if (part == "test") {
    test_gauge();
} else if (part == "demo") {
    base();
    demo_slabs();
    translate([0, 0, 60]) lid_placed(); // tampa levantada, pra ver as duas peças
} else if (part == "cut") {
    // corte no meio do conjunto FECHADO com slabs dentro: é aqui que se
    // confere o encaixe da tampa (saia x ressalto x ombro) e a folga sobre
    // o topo da slab. Preview only.
    difference() {
        union() { base(); demo_slabs(); lid_placed(); }
        translate([-1, box_y / 2, -1]) cube([box_x + 2, box_y, closed_h + 2]);
    }
} else {
    // preview lado a lado (não montado)
    base();
    translate([0, box_y + 25, 0]) lid();
}
