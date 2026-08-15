// deckbox-01.scad
// Deckbox estilo caixa de fósforo (matchbox), com 3 compartimentos na
// bandeja: dois lado a lado pra decks de 60 cartas (sleeved) DEITADAS
// (empilhadas horizontalmente, não em pé), e um terceiro abaixo dos dois
// (ocupando toda a largura) pra dados/moedas. Cada compartimento de deck
// tem uma CESTINHA — uma cesta solta de paredes finas que segura o deck
// inteiro. Um furo no chão da bandeja, embaixo de cada cestinha, deixa
// empurrar a cestinha pra cima com o dedo (como o miolo de uma caixa de
// fósforo) até dar pra pegar ela pela borda e tirar com o deck dentro.
// A cestinha é vazada em hexágonos (colmeia), como uma cesta de verdade,
// e os recortes em U nas laterais descem até o chão dela — dá pra pinçar
// até a última carta da pilha com ela fora da bandeja.
//
// A bandeja desliza dentro de uma capa fechada em UMA ponta (a outra fica
// aberta, por onde a bandeja entra). Fechamento por 4 ímãs (um em cada
// canto) na ponta da bandeja, espelhados por outros 4 na tampa da capa —
// quando a bandeja é empurrada até o fim, os ímãs se encostam e travam por
// atração. Um furo passante no fundo da capa deixa empurrar a bandeja de
// volta pra fora com o dedo.
//
// Peças: "tray" (bandeja), "sleeve" (capa) e "basket" (cestinha — imprimir
// 2, uma por compartimento de deck). STLs individuais de cada peça:
//   openscad -o stl/deckbox-01-tray.stl    -D 'part="tray"'    deckbox-01.scad
//   openscad -o stl/deckbox-01-sleeve.stl  -D 'part="sleeve"'  deckbox-01.scad
//   openscad -o stl/deckbox-01-basket.stl  -D 'part="basket"'  deckbox-01.scad
// A pasta 3mf/ tem SÓ os 2 arquivos de impressão (cama Bambu A1 mini,
// 180x180): a chapa "plate" (capa em pé + 2 cestinhas, ~155x161mm) e a
// bandeja à parte (136x151mm — não cabe junto). Conjunto completo = 2 jobs:
//   openscad -o 3mf/deckbox-01-plate.3mf   -D 'part="plate"'   deckbox-01.scad
//   openscad -o 3mf/deckbox-01-tray.3mf    -D 'part="tray"'    deckbox-01.scad
//
// Variante de UM deck só: deckboxes/deckbox-02/ — inclui este arquivo
// definindo deck_lanes = 1 (o nº de compartimentos de deck é parametrizado)
// e dice_depth = 64 (compartimento de dados mais fundo).

/* [Peça a renderizar] */
part = "both"; // "tray" | "sleeve" | "basket" | "plate" (chapa de impressão com tudo) | "both" (preview lado a lado, não montado)

/* [Deck com sleeve - medidas do deck REAL, tiradas com régua] */
// Medido em 2026-08-08: deck completo de 60 cartas COM sleeve = ~93 x 68 x 45 mm.
// Se trocar de sleeve (ou de jogo), medir o deck de novo e atualizar aqui.
deck_length = 93; // mm, comprimento da carta com sleeve (deitada — vira X, profundidade do compartimento)
deck_width  = 68; // mm, largura da carta com sleeve (vira Y)
deck_height = 45; // mm, altura da pilha completa deitada (as 60 cartas)

/* [Compartimento de dados/moedas] */
// Profundidade do compartimento (a largura é a dos dois decks juntos). A
// variante deckbox-02 aprofunda definindo dice_depth antes do include —
// mesmo padrão is_undef do deck_lanes, pro override não gerar warning.
dice_length = is_undef(dice_depth) ? 30 : dice_depth; // mm

/* [Cestinha do deck - cesta solta, empurrada por baixo] */
basket_wall  = 1.2; // mm, paredes da cestinha
basket_floor = 1.6; // mm, chão da cestinha (é onde o dedo empurra por baixo)
basket_clear = 0.3; // mm, folga por lado entre cestinha e compartimento, pra subir livre
basket_lip   = 3;   // mm, quanto a parede da cestinha sobe acima da pilha de cartas
cutout_w     = 40;  // mm, largura do recorte em U nas laterais compridas da cestinha
push_hole_d  = 16;  // mm, furo passante no chão da bandeja pra empurrar a cestinha com o dedo

/* [Vazado hexagonal da cestinha] */
hex_d      = 8;   // mm, tamanho de cada furo hexagonal (medido entre faces)
hex_web    = 2;   // mm, material que sobra entre furos vizinhos
hex_margin = 2.5; // mm, borda sólida ao redor de cada painel vazado (junções e cantos)

/* [Folgas] */
card_gap      = 2;    // folga extra em largura/profundidade pro deck não ficar apertado na cestinha

// TESTE FÍSICO 2026-08-10 (deckbox-02 impresso): com 0.25 por lado a bandeja
// TRAVOU NO MEIO DO CURSO e não saiu mais. Não foi folga nominal — foi EMPENO:
// o encaixe tem ~167mm, a capa imprime EM PÉ (tubo de 171.6mm com parede de
// 1.6mm, que barriga pra dentro) e a bandeja imprime DEITADA (cavidade em XY
// sai subdimensionada, sólido em XY sai superdimensionado), mais o pé de
// elefante das primeiras camadas da bandeja. Os desvios somam mais que 0.25 e
// a peça agarra na barriga, antes de assentar.
// 0.5 por lado cobre esse somatório com margem. Se ficar bambo demais no
// teste físico, descer pra 0.4 — NÃO voltar pra 0.25.
fit_tolerance = 0.5;  // folga por lado entre bandeja e caixa, pra deslizar sem travar

/* [Chanfro de entrada da capa] */
// Guia a bandeja na hora de entrar, pra ela não morder a borda da boca e
// entrar torta (que é o que inicia o travamento).
mouth_lead = 2.5; // mm, profundidade do chanfro medida ao longo do curso
mouth_grow = 0.8; // mm, quanto a boca abre a mais por lado na entrada

/* [Paredes] */
wall      = 1.6; // paredes externas (laterais/fundo/tubo)
end_wall  = 4;   // parede da ponta com ímã — mais grossa que wall, só o suficiente pro rebaixo do ímã
back_wall = 2;  // parede de trás da bandeja (sólida) — é a aba que sempre fica pra fora da capa, pra puxar
divider   = 1.6; // parede interna entre os 3 compartimentos

/* [Ímãs 4x2mm - discos, um em cada canto] */
magnet_d      = 4;    // mm, diâmetro
magnet_h      = 2;    // mm, espessura
magnet_fit    = 0.15; // mm, folga de encaixe pressionado (press-fit; se ficar frouxo, um pingo de cola resolve)
magnet_margin = 10;   // mm, distância do centro de cada ímã até as bordas da ponta

/* [Furo pra empurrar a bandeja] */
finger_hole_d = 12; // mm, diâmetro do furo passante no fundo da capa

/* [Qualidade] */
$fn = 48;

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
// nº de compartimentos de deck: 2 por padrão. A variante deckbox-02 inclui
// este arquivo definindo deck_lanes = 1 (por isso o is_undef, em vez de
// uma atribuição normal — assim o override não gera warning).
lanes = is_undef(deck_lanes) ? 2 : deck_lanes;

// a cestinha envolve o deck, então o compartimento precisa caber:
// deck medido + folga do deck + paredes da cestinha + folga da cestinha
lane_inner_w = deck_width  + card_gap + 2 * (basket_wall + basket_clear); // Y: largura interna de cada compartimento de deck
lane_inner_l = deck_length + card_gap + 2 * (basket_wall + basket_clear); // X: profundidade de cada compartimento (carta deitada)

basket_outer_w = lane_inner_w - 2 * basket_clear;
basket_outer_l = lane_inner_l - 2 * basket_clear;
basket_h       = basket_floor + deck_height + basket_lip;

// largura interna total: os compartimentos de deck lado a lado + as divisórias entre eles
tray_inner_w = lanes * lane_inner_w + (lanes - 1) * divider;
// Z: altura da cestinha + 1mm de folga pra borda dela não raspar na capa
tray_inner_h = basket_h + 1;
// comprimento interno total: compartimento de dados + divisória + zona dos decks
tray_inner_l = dice_length + divider + lane_inner_l;

tray_outer_w = tray_inner_w + 2 * wall;
tray_outer_h = tray_inner_h + 2 * wall;
tray_outer_l = tray_inner_l + end_wall + back_wall; // ponta do ímã de um lado, aba de puxar sólida do outro

// Quanto da parede de trás da bandeja fica propositalmente pra fora quando
// fechada. Padrão: deixa a aba inteira exposta pra puxar. Variantes podem
// reduzir/zerar isso e depender mais do furo traseiro da capa.
tray_reveal = is_undef(sleeve_tray_reveal) ? back_wall : sleeve_tray_reveal;

sleeve_cavity_w = tray_outer_w + 2 * fit_tolerance;
sleeve_cavity_h = tray_outer_h + 2 * fit_tolerance;
// a capa cobre a bandeja toda, menos o "reveal" configurado. No padrão o
// reveal = back_wall; com reveal = 0 a traseira da bandeja fica alinhada com
// a boca da capa quando fechada.
sleeve_cavity_l = tray_outer_l - tray_reveal;

sleeve_outer_w = sleeve_cavity_w + 2 * wall;
sleeve_outer_h = sleeve_cavity_h + 2 * wall;
sleeve_outer_l = sleeve_cavity_l + end_wall; // + a ponta fechada (tampa)

finger_hole_d_eff = is_undef(sleeve_finger_hole_d) ? finger_hole_d : sleeve_finger_hole_d;

// ---------------------------------------------------------------------
// Bandeja (tray): fundo + 4 paredes fechadas, aberta só em cima, com 3
// compartimentos internos.
// A ponta em x=0 é a que entra primeiro na caixa e carrega os 4 ímãs de
// canto. Nessa ponta fica o compartimento de dados/moedas (mais fundo, só
// aparece quando a bandeja é puxada quase até o fim); os dois
// compartimentos de deck ficam do lado da parede de trás — `back_wall` —
// (aparecem primeiro ao puxar a bandeja). No centro do chão de cada
// compartimento de deck há um furo passante: é por ele que o dedo empurra
// a cestinha (com o deck dentro) pra cima, até dar pra pegar pela borda.
// ---------------------------------------------------------------------
module tray() {
    lanes_x = end_wall + dice_length + divider;
    lane_y0 = [for (i = [0 : lanes - 1]) wall + i * (lane_inner_w + divider)]; // y de cada compartimento de deck

    difference() {
        cube([tray_outer_l, tray_outer_w, tray_outer_h]);

        // compartimento de dados/moedas — ocupa toda a largura
        translate([end_wall, wall, wall])
            cube([dice_length, tray_inner_w, tray_outer_h]); // sobe além do topo -> topo aberto

        for (y0 = lane_y0) {
            // compartimento de deck
            translate([lanes_x, y0, wall])
                cube([lane_inner_l, lane_inner_w, tray_outer_h]);

            // furo passante no chão, centralizado no compartimento, pra
            // empurrar a cestinha por baixo
            translate([lanes_x + lane_inner_l / 2, y0 + lane_inner_w / 2, -0.1])
                cylinder(h = wall + 0.2, d = push_hole_d);
        }

        // 4 ímãs de canto na ponta (precisa estar dentro do difference() pra CAVAR, não somar)
        magnet_corners(x = 0, w = tray_outer_w, h = tray_outer_h, dir = 1);
    }
}

// ---------------------------------------------------------------------
// Caixa externa (sleeve): tubo com a ponta em x=0 fechada e a outra aberta,
// por onde a bandeja entra. 4 ímãs de canto na ponta fechada, virados pra
// dentro (espelhando os da bandeja), e um furo passante no meio pra
// empurrar a bandeja de volta com o dedo.
// ---------------------------------------------------------------------
module sleeve() {
    difference() {
        cube([sleeve_outer_l, sleeve_outer_w, sleeve_outer_h]);
        translate([end_wall, wall, wall])
            cube([sleeve_outer_l, sleeve_cavity_w, sleeve_cavity_h]); // sobe além da frente -> frente aberta
        mouth_lead_in();
        finger_hole();

        // 4 ímãs de canto na tampa (precisa estar dentro do difference() pra CAVAR, não somar).
        // A capa é maior que a bandeja em (wall + fit_tolerance) por lado, então o margin
        // compensa esse deslocamento — senão cada par de ímãs fecha ~2.6mm fora de centro.
        magnet_corners(x = end_wall, w = sleeve_outer_w, h = sleeve_outer_h, dir = -1,
                       margin = magnet_margin + wall + fit_tolerance);
    }
}

// Rebaixo cilíndrico pra UM ímã, em (x, y, z).
// dir = 1  -> cava a partir de x pra dentro (+X)  [usado na bandeja]
// dir = -1 -> cava a partir de x pra fora (-X)     [usado na caixa]
module magnet_hole(x, y, z, dir) {
    translate([x, y, z])
        rotate([0, dir * 90, 0])
            cylinder(h = magnet_h + 0.01, d = magnet_d + magnet_fit);
}

// 4 ímãs, um em cada canto de uma parede de ponta (w x h), a `margin`
// das bordas.
module magnet_corners(x, w, h, dir, margin = magnet_margin) {
    for (yy = [margin, w - margin])
        for (zz = [margin, h - margin])
            magnet_hole(x, yy, zz, dir);
}

// Chanfro de entrada na boca da capa: a cavidade abre `mouth_grow` por lado
// nos últimos `mouth_lead` mm, em rampa. A bandeja encontra uma boca maior que
// ela e é centrada pela rampa em vez de bater na quina.
// Imprimibilidade: a capa imprime EM PÉ com a boca pra CIMA, então a rampa só
// afina a parede conforme sobe — cada camada continua apoiada na de baixo,
// sem balanço nenhum.
module mouth_lead_in() {
    hull() {
        translate([sleeve_outer_l - mouth_lead, wall, wall])
            cube([0.01, sleeve_cavity_w, sleeve_cavity_h]);
        translate([sleeve_outer_l - 0.01, wall - mouth_grow, wall - mouth_grow])
            cube([0.02, sleeve_cavity_w + 2 * mouth_grow, sleeve_cavity_h + 2 * mouth_grow]);
    }
}

// Furo passante centralizado no fundo da capa (sleeve), pra empurrar a
// bandeja de volta pra fora com o dedo.
module finger_hole() {
    translate([-0.1, sleeve_outer_w / 2, sleeve_outer_h / 2])
        rotate([0, 90, 0])
            cylinder(h = end_wall + 0.2, d = finger_hole_d_eff);
}

// ---------------------------------------------------------------------
// Cestinha (basket): cesta aberta em cima que vive dentro de um
// compartimento de deck, com o deck deitado dentro dela. O dedo empurra o
// chão dela pra cima (pelo furo no chão da bandeja) até a borda aparecer;
// daí é só pegar e tirar a cestinha inteira, com o deck junto. Os recortes
// em U nas duas laterais compridas descem até o chão dela, pra pinçar a
// pilha até a última carta com ela fora da bandeja. Chão e paredes são
// vazados em hexágonos (colmeia). A mesma peça serve nos dois
// compartimentos.
// ---------------------------------------------------------------------
module basket() {
    difference() {
        cube([basket_outer_l, basket_outer_w, basket_h]);

        // cavidade interna (chão fica embaixo, topo aberto)
        translate([basket_wall, basket_wall, basket_floor])
            cube([basket_outer_l - 2 * basket_wall,
                  basket_outer_w - 2 * basket_wall,
                  basket_h]);

        // recortes em U nas duas laterais compridas
        u_cutout(basket_outer_l / 2, 0);
        u_cutout(basket_outer_l / 2, basket_outer_w - basket_wall);

        // vazado hexagonal: chão + 4 paredes
        translate([basket_wall, basket_wall, 0])
            hex_panel(basket_outer_l - 2 * basket_wall,
                      basket_outer_w - 2 * basket_wall, basket_floor);
        for (y = [basket_wall, basket_outer_w]) // laterais compridas (faixa central
            translate([0, y, basket_floor])     // sem furos, por causa do recorte em U)
                rotate([90, 0, 0])
                    hex_panel(basket_outer_l, basket_h - basket_floor, basket_wall,
                              skip_w = cutout_w);
        for (x = [0, basket_outer_l - basket_wall]) // laterais curtas
            translate([x, 0, basket_floor])
                rotate([90, 0, 90])
                    hex_panel(basket_outer_w, basket_h - basket_floor, basket_wall);
    }
}

// Painel de furos hexagonais (colmeia) cobrindo o retângulo a x b no plano
// XY, com os furos atravessando a espessura t em Z e `hex_margin` de borda
// sólida em volta. Só entra hexágono que caiba INTEIRO na área útil.
// `skip_w` reserva uma faixa central (ao longo de `a`) sem furos — usada
// nas paredes com recorte em U, senão sobram lascas finas na borda do U.
// Hexágonos de ponta pra cima: nas paredes verticais cada furo imprime sem
// ponte reta (o topo fecha em bico, não em vão plano).
module hex_panel(a, b, t, skip_w = 0) {
    f  = hex_d;            // entre-faces
    R  = f / sqrt(3);      // circunraio (centro -> ponta)
    sx = f + hex_web;      // passo entre colunas
    sy = sx * sqrt(3) / 2; // passo entre fileiras (ímpares deslocam sx/2)

    for (j = [0 : ceil(b / sy)], i = [0 : ceil(a / sx)]) {
        cx = hex_margin + f / 2 + i * sx + (j % 2) * sx / 2;
        cy = hex_margin + R + j * sy;
        in_skip = skip_w > 0
            && cx + f / 2 > a / 2 - skip_w / 2 - hex_margin
            && cx - f / 2 < a / 2 + skip_w / 2 + hex_margin;
        if (cx + f / 2 <= a - hex_margin && cy + R <= b - hex_margin && !in_skip)
            translate([cx, cy, -0.1])
                rotate([0, 0, 30])
                    cylinder(h = t + 0.2, r = R, $fn = 6);
    }
}

// Recorte em U de cantos redondos, aberto no topo, atravessando uma parede
// comprida da cestinha (a parede começa em y0 e tem `basket_wall` de
// espessura). `cx` é o centro do recorte ao longo de X.
module u_cutout(cx, y0) {
    r  = 6;            // raio dos cantos de baixo do U
    zb = basket_floor; // o recorte desce até o CHÃO da cestinha, pra dar
                       // pra pinçar a última carta da pilha pela lateral

    translate([0, y0 - 0.1, 0]) {
        hull()
            for (xx = [cx - cutout_w / 2 + r, cx + cutout_w / 2 - r])
                translate([xx, 0, zb + r])
                    rotate([-90, 0, 0])
                        cylinder(h = basket_wall + 0.2, r = r);
        // abre o U até em cima da parede
        translate([cx - cutout_w / 2, 0, zb + r])
            cube([cutout_w, basket_wall + 0.2, basket_h]);
    }
}

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
if (part == "tray") {
    tray();
} else if (part == "sleeve") {
    sleeve();
} else if (part == "basket") {
    basket();
} else if (part == "plate") {
    // chapa pra cama 180x180 (A1 mini), já na orientação de impressão. A
    // capa fica EM PÉ, apoiada na ponta fechada — o tubo imprime sem
    // suporte. Com 1 deck (deckbox-02) o conjunto INTEIRO cabe numa chapa
    // só (~161x162mm); com 2 decks a bandeja não cabe junto e imprime à
    // parte (part="tray").
    plate_gap = 6;

    if (lanes == 1) {
        // job único: bandeja + cestinha + capa em pé
        tray();
        translate([0, tray_outer_w + plate_gap, 0]) {
            basket();
            translate([basket_outer_l + plate_gap + sleeve_outer_h, 0, 0])
                rotate([0, -90, 0])
                    sleeve();
        }
    } else {
        // capa em pé, deitada como uma faixa ao longo do fundo da chapa
        translate([0, sleeve_outer_h, 0])
            rotate([0, 0, -90])
                translate([sleeve_outer_h, 0, 0])
                    rotate([0, -90, 0])
                        sleeve();

        // cestinhas lado a lado, giradas pra caber na largura
        for (i = [0 : lanes - 1])
            translate([basket_outer_w + i * (basket_outer_w + plate_gap),
                       sleeve_outer_h + plate_gap, 0])
                rotate([0, 0, 90])
                    basket();
    }
} else {
    // preview lado a lado (não montado), só pra visualizar as três peças
    tray();
    translate([0, tray_outer_w + 20, 0])
        sleeve();
    translate([0, tray_outer_w + sleeve_outer_w + 40, 0])
        basket();
}
