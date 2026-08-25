// slab-tile-01.scad
// Tile MODULAR pra UMA slab graduada. Os tiles encaixam lado a lado por
// rabo-de-andorinha e viram uma "pagina" de fichario de 2x2 (4 slabs), 3x3 ou
// 4x4. As paginas montadas empilham em torre, e cada pagina sai da torre
// inteira, na mao, com as slabs a vista pela janela da frente.
//
// POR QUE O TILE E DE UMA SLAB SO:
//   Uma pagina de 2x2 mede ~199 x 297mm. Nao existe cama que imprima isso
//   inteiro (a AD5X tem 220). Entao a peca impressa e o TILE de uma slab
//   (99.3 x 148.3mm, duas por chapa) e a pagina nasce do encaixe.
//
// ACEITA QUALQUER SLAB "PADRAO PSA" — E ESSE E O PROBLEMA DIFICIL:
//   PSA .... ~82.0 x 136.0 x 6.0    (a mais estreita)
//   CGC .... ~82.0 x 136.0 x 8.0    (mesma pegada, mais grossa)
//   TAG .... ~ igual PSA
//   SGC .... ~89.0 x 138.0 x 7.0    (a mais larga e mais alta)
//   FORA: Beckett/BGS (~87 x 133 x 9) e ARS — fora do padrao, por decisao
//   do usuario.
//   Da PSA pra SGC sao 7mm de diferenca de LARGURA. Um bolso fixo ou aperta a
//   SGC ou deixa a PSA dancando 3.5mm por lado. A solucao aqui sao MOLAS DE
//   LAMINA EM ARCO: duas nas laterais (curso 4.15mm cada) que AUTOCENTRAM a
//   slab em X, e uma no topo (curso 2.9mm) que a encosta no piso do bolso.
//   Qualquer slab da faixa fica firme e centrada na janela, sem calco.
//
// COMO SE MANUSEIA:
//   A slab entra POR TRAS, empurrada pra dentro: a rampa de entrada (6mm a
//   35 graus) abre as molas sozinha. Ela para no ressalto da frente, que a
//   segura. Pra tirar, empurra com o polegar pela janela da frente.
//   Os tiles se juntam DESLIZANDO UM PELO OUTRO EM Z (o rabo-de-andorinha nao
//   entra de lado, so por cima) e travam com um detente que da o "clique".
//   As paginas empilham por um friso perimetral que entra na canaleta da
//   pagina de cima — a frente de uma fecha o fundo da outra, e a slab de
//   baixo fica lacrada.
//
// PRINT: face da FRENTE na cama, bolso pra cima. ZERO suporte — a janela e
// furo desde a camada 1, as molas sao paredes verticais e a unica saliencia
// (a rampa de entrada) fica a 35 graus da vertical.
//
// Exports canonicos (caminhos ABSOLUTOS nesta maquina):
//   flatpak run org.openscad.OpenSCAD -o stl/slab-tile-01.stl \
//     -D 'part="tile"' slab-tile-01.scad
//   flatpak run org.openscad.OpenSCAD -o stl/slab-tile-01-gabarito.stl \
//     -D 'part="test"' slab-tile-01.scad
//   flatpak run org.openscad.OpenSCAD -o 3mf/slab-tile-01-gabarito.3mf \
//     -D 'part="test2"' slab-tile-01.scad
//   flatpak run org.openscad.OpenSCAD -o 3mf/slab-tile-01-x2.3mf \
//     -D 'part="plate2"' slab-tile-01.scad
// part="demo" (2x2 montado com slabs de mentira) so pra preview, nunca export.

/* [Peca a renderizar] */
// "tile" | "plate2" (job: 2 tiles) | "test" (gabarito) | "test2" (job do
// gabarito, 2 pecas) | "demo" (preview do 2x2 montado)
part = "tile";

/* [Envelope da slab - MAXIMO da faixa aceita] */
// Largura/altura vem da SGC (a maior); espessura vem da CGC (a mais grossa).
// NAO foram tiradas com regua pelo usuario — ver a secao do README.
slab_w_max = 89.0;  // mm, SGC
slab_h_max = 138.0; // mm, SGC
slab_t_max = 8.0;   // mm, CGC
// A MENOR da faixa (PSA/TAG): define o quanto o ressalto da frente precisa
// avancar pra ainda segurar a slab pequena.
slab_w_min = 82.0;  // mm, PSA
slab_h_min = 136.0; // mm, PSA
gen_var = 0.5;      // mm, variacao entre geracoes de encapsulamento

/* [Folgas] */
pocket_clear = 0.4;  // mm por lado, bolso x slab (padrao do repo p/ peca solta)
joint_clear  = 0.15; // mm por lado no rabo-de-andorinha (deslize curto em Z)
nest_clear   = 0.30; // mm por lado, friso de empilhamento x canaleta

/* [Corpo do tile] */
wall      = 4.5;  // mm, parede em volta do bolso
front_t   = 2.5;  // mm, espessura da face da frente
corner_r  = 3.0;  // mm, raio do contorno
pocket_r  = 2.5;  // mm, raio do bolso
lip_min   = 5.0;  // mm, avanco minimo do ressalto sobre a slab MENOR

/* [Molas de lamina] */
springs      = true; // false = bolso liso (tile dedicado a um so tamanho)
spring_t     = 1.5;  // mm, espessura da lamina
spring_len_x = 72;   // mm, vao da mola lateral
spring_len_y = 56;   // mm, vao da mola do topo
spring_grip  = 0.40; // mm, interferencia sobre a slab MENOR (o aperto)
relief_d     = 2.0;  // mm, alivio atras da lamina, pra ela ter pra onde fletir
lead_h       = 6.0;  // mm, altura da rampa de entrada
lead_steps   = 20;   // fatias que aproximam a rampa

/* [Encaixe entre tiles] */
joint_out  = 3.0;  // mm, quanto o macho avanca sobre o vizinho (< wall!)
joint_neck = 7.0;  // mm, largura do pescoco do rabo-de-andorinha
joint_tip  = 12.0; // mm, largura da cabeca (> pescoco = nao sai de lado)
detent     = true; // clique no fim do curso
detent_r   = 2.0;  // mm, raio da esfera do detente
detent_out = 0.45; // mm, quanto ela sobressai da cabeca

/* [Empilhamento] */
nest_lip_h = 1.2;  // mm, altura do friso nas costas
nest_lip_w = 1.2;  // mm, largura do friso
nest_inset = 3.2;  // mm, recuo do friso em relacao a borda (> joint_out)

/* [Colmeia - identidade visual do repo] */
hex_on    = true;
hex_r     = 4.5;  // mm, circunraio do hexagono (ponta pra cima)
hex_gap   = 1.6;  // mm, filete entre hexagonos
hex_depth = 0.6;  // mm, profundidade do baixo relevo
hex_skip  = 2.2;  // mm, faixa solida nas bordas (anti-lasca, regra 4 do repo)

/* [Chapa] */
// Vao entre as BORDAS RETAS dos dois tiles. Eles vao ENTRELACADOS: a simetria
// C2 poe o macho de +X e o de -X em alturas diferentes, entao o macho de um
// passa exatamente na altura em que o vizinho tem FEMEA. Assim a chapa encolhe
// ~3mm e ainda sobra folga de verdade em todo ponto.
plate_gap = 4.4;

/* [Qualidade] */
$fn = 64;
eps = 0.01;

// ==========================================================================
// Derivados
// ==========================================================================
pocket_w = slab_w_max + gen_var + 2 * pocket_clear; // 90.3
pocket_h = slab_h_max + gen_var + 2 * pocket_clear; // 139.3
pocket_d = slab_t_max + gen_var + pocket_clear;     // 8.9

tile_w = pocket_w + 2 * wall;   // 99.3
tile_h = pocket_h + 2 * wall;   // 148.3
tile_t = front_t + pocket_d;    // 11.4

// Janela: centrada em X (as molas laterais centram a slab) e referenciada ao
// PISO do bolso em Y (a mola do topo empurra a slab pra baixo).
window_w = slab_w_min - 2 * lip_min;             // 72
window_h = slab_h_min - 2 * lip_min;             // 126
window_y = -pocket_h / 2 + lip_min + window_h / 2; // sobe a janela

// Molas: a lamina tem que alcancar a slab MENOR e ainda apertar.
spring_bulge_x = (pocket_w - slab_w_min) / 2 + spring_grip; // 4.55
spring_bulge_y = (pocket_h - slab_h_min) + spring_grip;     // 3.70
// Curso exigido = fechar sobre a MENOR partindo da MAIOR.
travel_x = spring_bulge_x - (pocket_w - slab_w_max - gen_var) / 2; // 4.15
travel_y = spring_bulge_y - (pocket_h - slab_h_max - gen_var);     // 2.90

// Posicao dos encaixes: fora do vao das molas, dentro do contorno.
q_y = 52;  // encaixes das bordas X, em |y|
q_x = 39;  // encaixes das bordas Y, em |x|

// ==========================================================================
// Guardas (regra 7 do repo: ecoar e travar o que nao pode passar)
// ==========================================================================
assert(joint_out < wall,
       "joint_out >= wall: a cavidade femea fura o bolso");
assert(joint_tip > joint_neck,
       "rabo-de-andorinha invertido: a cabeca tem que ser mais larga");
assert(q_y - joint_tip / 2 > spring_len_x / 2 + 4,
       "encaixe lateral invade o vao da mola lateral");
assert(q_y + joint_tip / 2 < tile_h / 2 - corner_r,
       "encaixe lateral perto demais do canto");
assert(q_x - joint_tip / 2 > spring_len_y / 2 + 2,
       "encaixe do topo invade o vao da mola do topo");
assert(q_x + joint_tip / 2 < tile_w / 2 - corner_r,
       "encaixe do topo perto demais do canto");
assert(window_w / 2 < pocket_w / 2 - spring_bulge_x,
       "a janela passa por baixo da mola lateral");
assert(window_y + window_h / 2 < pocket_h / 2 - spring_bulge_y,
       "a janela passa por baixo da mola do topo");
assert(spring_bulge_x - spring_t + relief_d > travel_x,
       "a mola lateral nao tem espaco pra fletir o curso todo");
assert(spring_bulge_y - spring_t + relief_d > travel_y,
       "a mola do topo nao tem espaco pra fletir o curso todo");
assert(nest_inset > joint_out,
       "o friso de empilhamento cruza a cavidade femea");
assert(pocket_d - lead_h > 2.0,
       "sobrou pouco trecho reto de aperto abaixo da rampa");
assert(relief_d < wall - 1.5, "alivio deixa a parede externa fina demais");
assert(plate_w_total <= 210,
       "a chapa de 2 tiles passou do alvo confortavel de 210mm da AD5X");
assert(plate_min_gap >= 0.8,
       "na chapa, a ponta do macho de um tile encosta na borda do outro");

echo(str("slab-tile-01: tile ", tile_w, " x ", tile_h, " x ", tile_t, " mm"));
echo(str("  bolso ", pocket_w, " x ", pocket_h, " x ", pocket_d, " mm"));
echo(str("  janela ", window_w, " x ", window_h, " mm"));
echo(str("  curso das molas: X ", travel_x, " mm / Y ", travel_y, " mm"));
plate_pitch   = tile_w + plate_gap;
bbox_w        = tile_w + 2 * (joint_out + detent_out);
bbox_h        = tile_h + 2 * (joint_out + detent_out);
plate_w_total = plate_pitch + bbox_w;
// Onde os dois tiles chegam mais perto: a ponta do macho de um contra a borda
// reta do outro.
plate_min_gap = plate_pitch - tile_w - (joint_out + detent_out);
echo(str("  chapa de 2 tiles: ", plate_w_total, " x ", bbox_h, " mm"));
echo(str("  aperto minimo entre os dois tiles da chapa: ", plate_min_gap, " mm"));
echo(str("  pagina 2x2 montada: ", 2 * tile_w, " x ", 2 * tile_h, " mm"));
echo(str("  torre de 4 paginas: ", 4 * tile_t, " mm de altura"));

// ==========================================================================
// 2D basico
// ==========================================================================
module rrect(w, h, r) {
    offset(r = r) square([w - 2 * r, h - 2 * r], center = true);
}

// Rabo-de-andorinha macho na borda +X, centrado em y0.
module male_x_pos(y0, grow = 0) {
    offset(delta = grow) polygon([
        [tile_w / 2 - eps, y0 - joint_neck / 2],
        [tile_w / 2 + joint_out, y0 - joint_tip / 2],
        [tile_w / 2 + joint_out, y0 + joint_tip / 2],
        [tile_w / 2 - eps, y0 + joint_neck / 2],
    ]);
}

// Cavidade FEMEA na borda +X: e o macho ESPELHADO no plano da borda, entao
// ela escava pra DENTRO do tile — pescoco estreito na borda, cabeca larga la
// no fundo. E isso que faz o rabo-de-andorinha nao sair de lado.
module female_x_pos(y0) {
    offset(delta = joint_clear) polygon([
        [tile_w / 2 + eps, y0 - joint_neck / 2],
        [tile_w / 2 - joint_out, y0 - joint_tip / 2],
        [tile_w / 2 - joint_out, y0 + joint_tip / 2],
        [tile_w / 2 + eps, y0 + joint_neck / 2],
    ]);
}

// Idem na borda +Y, centrado em x0.
module male_y_pos(x0, grow = 0) {
    offset(delta = grow) polygon([
        [x0 - joint_neck / 2, tile_h / 2 - eps],
        [x0 - joint_tip / 2, tile_h / 2 + joint_out],
        [x0 + joint_tip / 2, tile_h / 2 + joint_out],
        [x0 + joint_neck / 2, tile_h / 2 - eps],
    ]);
}

// Cavidade femea na borda +Y.
module female_y_pos(x0) {
    offset(delta = joint_clear) polygon([
        [x0 - joint_neck / 2, tile_h / 2 + eps],
        [x0 - joint_tip / 2, tile_h / 2 - joint_out],
        [x0 + joint_tip / 2, tile_h / 2 - joint_out],
        [x0 + joint_neck / 2, tile_h / 2 + eps],
    ]);
}

// Contorno do tile com os 4 machos e as 4 femeas.
// Simetria C2: macho em +X/-q_y e em -X/+q_y — assim um tile encaixa nele
// mesmo, em qualquer posicao da grade.
module outline2d() {
    difference() {
        union() {
            rrect(tile_w, tile_h, corner_r);
            male_x_pos(-q_y);
            mirror([1, 0, 0]) male_x_pos(q_y);
            male_y_pos(-q_x);
            mirror([0, 1, 0]) male_y_pos(q_x);
        }
        female_x_pos(q_y);
        mirror([1, 0, 0]) female_x_pos(-q_y);
        female_y_pos(q_x);
        mirror([0, 1, 0]) female_y_pos(-q_x);
    }
}

// ==========================================================================
// Molas de lamina: arco de circulo que estufa `b` no meio do vao `L`.
// R = (L^2/4 + b^2) / (2b) — deducao no README.
// ==========================================================================
function arc_R(L, b) = (L * L / 4 + b * b) / (2 * b);

// Lamina na parede +X (estufa pra -X). side = +1 ou -1.
module spring_x_2d(side, b) {
    R = arc_R(spring_len_x, b);
    cx = side * (pocket_w / 2 - b + R);
    intersection() {
        difference() {
            translate([cx, 0]) circle(r = R, $fn = 260);
            translate([cx, 0]) circle(r = R - spring_t, $fn = 260);
        }
        translate([side * (pocket_w / 2 - b / 2), 0])
            square([b + 4, spring_len_x], center = true);
    }
}

// Lamina na parede +Y (estufa pra -Y).
module spring_y_2d(b) {
    R = arc_R(spring_len_y, b);
    cy = pocket_h / 2 - b + R;
    intersection() {
        difference() {
            translate([0, cy]) circle(r = R, $fn = 260);
            translate([0, cy]) circle(r = R - spring_t, $fn = 260);
        }
        translate([0, pocket_h / 2 - b / 2])
            square([spring_len_y, b + 4], center = true);
    }
}

module springs_2d(bx, by) {
    if (springs) {
        spring_x_2d(1, bx);
        spring_x_2d(-1, bx);
        spring_y_2d(by);
    }
}

// Solido das molas com a RAMPA DE ENTRADA: nos ultimos `lead_h` mm o estufo
// diminui ate quase zero, entao a slab que desce vai abrindo as laminas
// sozinha em vez de bater de topo.
module springs_3d() {
    straight = pocket_d - lead_h;
    // trecho reto (o que de fato aperta a slab)
    translate([0, 0, front_t])
        linear_extrude(straight + eps) springs_2d(spring_bulge_x, spring_bulge_y);
    // rampa
    step = lead_h / lead_steps;
    for (i = [0 : lead_steps - 1]) {
        f = 1 - (i + 0.5) / lead_steps; // 1 -> 0 subindo
        bx = max(0.2, spring_bulge_x - travel_x * (1 - f));
        by = max(0.2, spring_bulge_y - travel_y * (1 - f));
        translate([0, 0, front_t + straight + i * step])
            linear_extrude(step + eps) springs_2d(bx, by);
    }
}

// Alivio atras de cada lamina, pra ela ter pra onde fletir.
module relief_2d() {
    if (springs) {
        anchor = 8; // mm de parede solida em cada ponta, onde a lamina ancora
        for (s = [-1, 1])
            translate([s * (pocket_w / 2 + relief_d / 2), 0])
                square([relief_d, spring_len_x - 2 * anchor], center = true);
        translate([0, pocket_h / 2 + relief_d / 2])
            square([spring_len_y - 2 * anchor, relief_d], center = true);
    }
}

// ==========================================================================
// Colmeia em baixo relevo na moldura da frente (regra 5: ponta pra cima)
// ==========================================================================
module hex_field() {
    pitch = 2 * hex_r * cos(30) + hex_gap;
    rows = ceil(tile_h / (pitch * 0.87)) + 2;
    cols = ceil(tile_w / pitch) + 2;
    for (r = [-rows : rows], c = [-cols : cols]) {
        x = c * pitch + (r % 2 == 0 ? 0 : pitch / 2);
        y = r * pitch * 0.866;
        translate([x, y]) rotate(30) circle(r = hex_r, $fn = 6);
    }
}

module hex_mask() {
    // so na moldura: dentro do contorno (menos a faixa anti-lasca) e fora da
    // janela (mais a faixa).
    difference() {
        offset(delta = -hex_skip) rrect(tile_w, tile_h, corner_r);
        offset(delta = hex_skip) translate([0, window_y])
            rrect(window_w, window_h, corner_r);
    }
}

module hex_engrave() {
    if (hex_on)
        translate([0, 0, -eps])
            linear_extrude(hex_depth + eps)
                intersection() { hex_field(); hex_mask(); }
}

// ==========================================================================
// Empilhamento: friso nas costas, canaleta na frente
// ==========================================================================
module nest_path_2d(w) {
    difference() {
        offset(delta = -nest_inset) rrect(tile_w, tile_h, corner_r);
        offset(delta = -(nest_inset + w)) rrect(tile_w, tile_h, corner_r);
    }
}

module nest_lip() {
    translate([0, 0, tile_t - eps])
        linear_extrude(nest_lip_h + eps) nest_path_2d(nest_lip_w);
}

module nest_groove() {
    translate([0, 0, -eps])
        linear_extrude(nest_lip_h + nest_clear + eps)
            offset(delta = nest_clear) nest_path_2d(nest_lip_w);
}

// ==========================================================================
// Detente do encaixe (o "clique")
// ==========================================================================
module detent_ball(cx, cy, grow) {
    translate([cx, cy, tile_t / 2]) sphere(r = detent_r + grow, $fn = 32);
}

module detents_add() {
    if (detent) {
        // na cabeca de cada macho, sobressaindo detent_out
        d = tile_w / 2 + joint_out - detent_r + detent_out;
        detent_ball(d, -q_y, 0);
        detent_ball(-d, q_y, 0);
        e = tile_h / 2 + joint_out - detent_r + detent_out;
        detent_ball(-q_x, e, 0);
        detent_ball(q_x, -e, 0);
    }
}

module detents_cut() {
    if (detent) {
        // covinha no fundo de cada femea, na mesma posicao absoluta
        d = tile_w / 2 + joint_out - detent_r + detent_out;
        // O macho do vizinho chega na MESMA coordenada transversal do
        // macho daqui (a simetria C2 garante isso): y = -q_y pro macho que
        // sai em +X, y = +q_y pro que entra vindo de -X.
        detent_ball(-(tile_w - d), -q_y, joint_clear);
        detent_ball(tile_w - d, q_y, joint_clear);
        e = tile_h / 2 + joint_out - detent_r + detent_out;
        detent_ball(-q_x, -(tile_h - e), joint_clear);
        detent_ball(q_x, tile_h - e, joint_clear);
    }
}

// ==========================================================================
// O tile
// ==========================================================================
module tile(h_override = undef, with_front = true) {
    zt = is_undef(h_override) ? tile_t : h_override;
    ft = with_front ? front_t : 0;
    union() {
        difference() {
            union() {
                linear_extrude(zt) outline2d();
                if (with_front) nest_lip();
                detents_add();
            }
            // janela da frente
            if (with_front)
                translate([0, 0, -eps])
                    linear_extrude(ft + 2 * eps)
                        translate([0, window_y]) rrect(window_w, window_h, corner_r);
            // bolso (menos as molas, que ficam de pe dentro dele)
            difference() {
                translate([0, 0, ft])
                    linear_extrude(zt - ft + eps) rrect(pocket_w, pocket_h, pocket_r);
                springs_3d();
            }
            // alivio das laminas
            translate([0, 0, ft])
                linear_extrude(zt - ft + eps) relief_2d();
            if (with_front) { nest_groove(); hex_engrave(); }
            detents_cut();
        }
    }
}

// Gabarito: fatia fina do tile, mesma pegada em XY. Serve pra (a) enfiar a
// slab de verdade e sentir o aperto/centragem das molas e (b) encaixar dois
// e conferir o rabo-de-andorinha ANTES de mandar os tiles grandes.
// A mola aqui e mais baixa, entao empurra MENOS que a real — o que se testa
// e a geometria e o curso, nao a forca.
test_h = 6.0;
module test_piece() { tile(h_override = test_h, with_front = false); }

// ==========================================================================
// Slab de mentira, so pra preview
// ==========================================================================
module fake_slab(w = slab_w_max, h = slab_h_max, t = slab_t_max) {
    color("#cfd8dc", 0.75)
        translate([0, 0, front_t])
            linear_extrude(t) rrect(w, h, 4);
}

// ==========================================================================
// Saidas
// ==========================================================================
if (part == "tile") {
    tile();
} else if (part == "test") {
    test_piece();
} else if (part == "test2") {
    for (i = [0, 1]) translate([i * plate_pitch, 0, 0]) test_piece();
} else if (part == "plate2") {
    for (i = [0, 1]) translate([i * plate_pitch, 0, 0]) tile();
} else if (part == "fit_x") {
    // Dois tiles vizinhos em X. TEM QUE SAIR VAZIO (Volumes: 1 no sumario
    // CGAL). Nao-vazio = os solidos se atravessam e a pagina nao fecha.
    intersection() { tile(); translate([tile_w, 0, 0]) tile(); }
} else if (part == "fit_y") {
    // Idem em Y. TEM QUE SAIR VAZIO.
    intersection() { tile(); translate([0, tile_h, 0]) tile(); }
} else if (part == "gap_x") {
    // O macho DENTRO da femea do vizinho: TEM QUE SAIR NAO-VAZIO, senao o
    // encaixe nao pegou nada e os tiles so encostam.
    intersection() {
        translate([tile_w, 0, 0]) tile();
        translate([tile_w / 2 + joint_out / 2, -q_y, tile_t / 2])
            cube([joint_out * 3, joint_tip * 2, tile_t], center = true);
    }
} else if (part == "probe_gap") {
    // O VAO DE FLEXAO atras da lamina lateral, no meio do vao (y=0), no
    // trecho reto. TEM QUE SAIR VAZIO — se sair solido, a mola nao tem pra
    // onde fletir e o bolso vira rigido.
    gap_a = pocket_w / 2 - spring_bulge_x + spring_t; // face EXTERNA da lamina
    gap_b = pocket_w / 2;                        // face interna da parede
    intersection() {
        tile();
        translate([-(gap_a + gap_b) / 2, 0, 4.0])
            cube([(gap_b - gap_a) - 0.6, 9, 1.6], center = true);
    }
} else if (part == "probe_blade") {
    // A LAMINA em si, no mesmo corte. TEM QUE SAIR NAO-VAZIO.
    bl = pocket_w / 2 - spring_bulge_x;
    intersection() {
        tile();
        translate([-(bl + spring_t / 2), 0, 4.0])
            cube([spring_t - 0.6, 20, 1.6], center = true);
    }
} else if (part == "cut") {
    // Corte no meio do vao da mola lateral: mostra o perfil ressalto/bolso/
    // rampa. So preview.
    difference() { tile(); translate([-200, -200, -50]) cube([400, 200, 100]); }
} else if (part == "demo") {
    for (cx = [0, 1], cy = [0, 1])
        translate([cx * tile_w, cy * tile_h, 0]) {
            tile();
            fake_slab();
        }
} else {
    assert(false, str("part desconhecido: ", part));
}
