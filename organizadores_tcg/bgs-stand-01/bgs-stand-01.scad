// bgs-stand-01.scad
// Suporte de mesa pra UMA slab graduada BECKETT (BGS), inclinada pra trás.
// DUAS peças: o suporte e uma TAMPA que encaixa por cima. Nenhuma das duas
// precisa de suporte de impressão.
//
// MEDIDA REAL: slab Beckett medida com PAQUÍMETRO pelo usuário em 2026-08-11:
// 82.5 x 130.2 x 8.5 mm. Não é estimativa nem catálogo. Pra outra marca (PSA,
// CGC), medir de novo e mexer só em slab_w/slab_h/slab_t — a peça inteira é
// derivada desses três números.
//
// DE ONDE VEIO: ../display-box-graded/psa/my_psa_slab.3mf (Functional3D,
// MakerWorld, Standard Digital File License) — arquivo de terceiro, sem fonte.
// Dele veio só o CONCEITO, medido na malha: painel inclinado 11.9°, canal na
// base, canal de slab de 81.0mm. A geometria aqui é toda nova.
//
// POR QUE A TAMPA MUDA TUDO. O original prende a slab com um gancho fixo no
// topo, e isso obriga a slab a BASCULAR pra entrar por baixo dele — daí o
// gancho ser um balanço de ~11mm quase horizontal, e daí o 3MF dele vir com
// suporte ligado. Com a tampa REMOVÍVEL, a slab entra deslizando por cima,
// direto. Três coisas saem de graça:
//   1. Os trilhos laterais podem ter ABA de novo (avançam 2mm sobre cada borda
//      lateral da slab), porque não precisa mais de espaço pra bascular. A
//      slab fica presa nos quatro lados: aba dos trilhos na frente, lábio da
//      base embaixo, painel atrás, tampa em cima.
//   2. A ETIQUETA FICA 100% LIVRE. A tampa fecha ACIMA do topo da slab — ela
//      encosta na aresta de cima, não na face. Nada cobre a tag de nota.
//   3. TUDO IMPRIME SEM SUPORTE. Trilho é parede vertical; a tampa é peça
//      separada e imprime deitada, com o teto na mesa e a ranhura pra cima.
//
// COMO A TAMPA ENCAIXA (dois apoios, não um):
//   - uma RANHURA na tampa desce sobre os `cap_zone` mm de painel que sobram
//     acima da slab — é o que centra e segura;
//   - a face de baixo da tampa SENTA nos topos dos dois trilhos — é o batente
//     que define a altura e fecha o vão por onde a slab sairia.
//   Ajuste deslizante de cap_fit por lado. Sai puxando; a slab sai atrás.
//
// Exports canônicos:
//   openscad -o stl/bgs-stand-01-stand.stl -D 'part="stand"' bgs-stand-01.scad
//   openscad -o stl/bgs-stand-01-cap.stl   -D 'part="cap"'   bgs-stand-01.scad
//   openscad -o 3mf/bgs-stand-01.3mf       -D 'part="plate"' bgs-stand-01.scad
// A chapa "plate" traz as duas peças já na orientação de impressão.

/* [Peça a renderizar] */
part = "plate"; // "stand" | "cap" | "plate" (chapa com as duas) | "check" (montado + slab fantasma)

/* [Slab - medida REAL de paquímetro, 2026-08-11] */
slab_w = 82.5;  // mm, largura
slab_h = 130.2; // mm, altura
slab_t = 8.5;   // mm, espessura

/* [Folgas] */
fit_w = 0.4; // mm por lado, na largura (slab desliza entre os trilhos)
fit_t = 0.4; // mm por lado, na espessura
fit_h = 0.5; // mm de sobra no comprimento, no fundo do canal

/* [Postura] */
lean = 12; // graus de inclinação pra trás (o de referência tinha 11.9)

/* [Painel e trilhos] */
panel_t  = 3;   // mm, espessura do painel de trás
wall     = 2;   // mm, espessura da parede lateral do trilho
rail_lip = 2;   // mm, quanto a aba do trilho avança sobre a face da slab (por lado)
lip_t    = 2.5; // mm, espessura da aba do trilho e do lábio frontal da base

/* [Base] */
floor_z   = 3;  // mm, material sólido abaixo do canal
lip_h     = 9;  // mm, altura do lábio frontal acima do piso do canal
base_back = 18; // mm, quanto a base avança atrás do pé do painel (é o que
                // impede o conjunto de cair pra trás — o centro de massa fica
                // atrás do painel por causa da inclinação)

/* [Tampa] */
cap_zone = 12;   // mm de painel que sobram acima da slab, pra ranhura da tampa
cap_wall = 1.8;  // mm, parede da tampa dos dois lados da ranhura
cap_top  = 3;    // mm, teto da tampa acima do topo do painel
cap_fit  = 0.25; // mm por lado, folga deslizante da ranhura (padrão do repo)

/* [Qualidade] */
$fn = 48;

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
slot_t  = slab_t + 2 * fit_t; // vão pra espessura da slab
slot_w  = slab_w + 2 * fit_w; // vão pra largura da slab
outer_w = slot_w + 2 * wall;  // largura externa das duas peças
L       = slab_h + fit_h;     // comprimento do vão, ao longo da slab

rail_d       = slot_t + lip_t;   // quanto o trilho avança à frente do painel
panel_top_du = L + cap_zone;     // o painel sobe além da slab, pra receber a tampa
lip_top      = floor_z + lip_h;  // topo do lábio frontal da base

cap_h     = cap_zone + cap_top;              // altura total da tampa
cap_front = rail_d;                          // frente da tampa alinhada com a dos trilhos
cap_back  = panel_t + cap_wall + cap_fit;    // quanto a tampa avança atrás do painel
cap_depth = cap_front + cap_back;            // espessura total da tampa

// Referencial da slab -> XZ do mundo.
// du = ao longo da slab (pra cima), dn = pra frente (saindo da face do painel).
// A origem (du=0, dn=0) é o canto de baixo/de trás do vão.
function pt(du, dn) = [ du * sin(lean) - dn * cos(lean),
                        floor_z + du * cos(lean) + dn * sin(lean) ];
// x da linha de dn constante, na altura z
function x_at_z(z, dn) = ((z - floor_z - dn * sin(lean)) / cos(lean)) * sin(lean)
                         - dn * cos(lean);

// A frente da base fica alinhada com o ponto mais avançado do trilho.
lip_front_x  = -rail_d * cos(lean);
base_back_x  = x_at_z(0, -panel_t) + base_back;
total_h      = floor_z + panel_top_du * cos(lean);
base_depth   = base_back_x - lip_front_x;
env_back_x   = pt(panel_top_du, -panel_t)[0];
env_depth    = max(base_back_x, env_back_x) - lip_front_x;
face_visivel = slot_w - 2 * rail_lip;

echo(str("bgs-stand-01 SUPORTE: envelope ", env_depth, " x ", outer_w, " x ", total_h,
         " mm | base na mesa ", base_depth, " mm de profundidade"));
echo(str("  slab ", slab_w, " x ", slab_h, " x ", slab_t,
         " -> vao ", slot_w, " x ", L, " x ", slot_t));
echo(str("  TAMPA: ", cap_depth, " x ", outer_w, " x ", cap_h,
         " mm | ranhura ", panel_t + 2 * cap_fit, " mm, desce ", cap_zone, " mm"));
echo(str("  face da slab visivel: ", face_visivel, " de ", slab_w,
         " mm de largura | topo da slab: LIVRE (a tampa fecha acima da aresta)"));

// ---------------------------------------------------------------------
// Suporte
// ---------------------------------------------------------------------
module stand() {
    // corpo: base + painel, em toda a largura
    xz_extrude(outer_w) polygon(body_profile());

    // dois trilhos em C, um em cada borda (o da direita é espelhado, senão a
    // aba cresceria pra FORA da peça em vez de avançar sobre a slab)
    rail(0);
    rail(outer_w, true);
}

// Silhueta lateral do corpo (base + painel). O vão da slab NÃO faz parte dela
// — é o recorte entre o lábio frontal e a face do painel; quem devolve as
// paredes desse canal são os trilhos.
function body_profile() = [
    [lip_front_x, 0],                        // frente, na mesa
    [lip_front_x, lip_top],                  // sobe a face do lábio
    [x_at_z(lip_top, slot_t), lip_top],      // topo do lábio
    pt(0, slot_t),                           // desce a face frontal do canal
    pt(0, 0),                                // piso do canal (inclinado, casa com a base da slab)
    pt(panel_top_du, 0),                     // sobe a face frontal do painel
    pt(panel_top_du, -panel_t),              // topo do painel (onde a tampa encaixa)
    [x_at_z(lip_top, -panel_t), lip_top],    // desce a face de trás do painel
    [base_back_x, lip_top],                  // topo da base, atrás do painel
    [base_back_x, 0]                         // face de trás da base, na mesa
];

// Trilho em C numa borda: parede lateral + aba que avança sobre a face da
// slab. Sobe até o topo da slab, onde a tampa senta. Tudo parede vertical: a
// cada camada a seção é a de baixo deslocada 0.04mm pela inclinação, então
// não existe balanço nenhum.
module rail(y0, flip = false) {
    in_slab_frame()
        translate([0, y0, 0]) {
            if (flip) mirror([0, 1, 0]) rail_body();
            else rail_body();
        }
}

module rail_body() {
    translate([-rail_d, 0, 0]) cube([rail_d, wall, L]);           // parede lateral
    translate([-rail_d, 0, 0]) cube([lip_t, wall + rail_lip, L]); // aba sobre a face da slab
}

// ---------------------------------------------------------------------
// Tampa
// ---------------------------------------------------------------------
// Bloco com uma ranhura no fundo: a ranhura desce sobre o painel e a face de
// baixo senta nos topos dos dois trilhos. Fecha ACIMA da aresta de cima da
// slab — não encosta na face, então não cobre a etiqueta.
// Orientação local: X = pra trás (0 = frente, alinhada com a frente do
// trilho), Y = largura, Z = ao longo da slab (0 = face que senta no trilho).
module cap_local() {
    difference() {
        cube([cap_depth, outer_w, cap_h]);
        // a ranhura tem que cair EM CIMA do painel: no local da tampa o painel
        // começa em X = cap_front (a origem local está na frente do trilho)
        translate([cap_front - cap_fit, -1, -1])
            cube([panel_t + 2 * cap_fit, outer_w + 2, cap_zone + 1]);
    }
}

// A tampa na orientação de IMPRESSÃO: de cabeça pra baixo, teto na mesa e
// ranhura pra cima. Assim as paredes da ranhura são verticais e não sobra
// nenhuma face pendurada.
module cap() {
    translate([0, 0, cap_h]) mirror([0, 0, 1]) cap_local();
}

// A tampa montada no suporte.
module cap_placed() {
    in_slab_frame()
        translate([-cap_front, 0, L])
            cap_local();
}

// ---------------------------------------------------------------------
// Comuns
// ---------------------------------------------------------------------
// Coloca os filhos no referencial da slab: X = pra TRÁS, Y = largura,
// Z = ao longo da slab. A origem fica no canto de baixo/de trás do vão.
module in_slab_frame() {
    translate([0, 0, floor_z])
        rotate([0, lean, 0])
            children();
}

// A slab, só pra conferência visual de encaixe (part="check").
module slab_ghost() {
    in_slab_frame()
        translate([-(slot_t - fit_t), wall + fit_w, fit_h / 2])
            cube([slab_t, slab_w, slab_h]);
}

// Extrusão de um perfil do plano XZ ao longo de Y (0..h).
module xz_extrude(h) {
    translate([0, h, 0])
        rotate([90, 0, 0])
            linear_extrude(h)
                children();
}

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
if (part == "stand") {
    stand();
} else if (part == "cap") {
    cap();
} else if (part == "check") {
    stand();
    cap_placed();
    slab_ghost();
} else {
    // chapa: suporte em pé + tampa deitada ao lado, ambos na orientação de
    // impressão. Cabe folgado na cama da A1 mini.
    plate_gap = 8;
    stand();
    translate([base_back_x + plate_gap, 0, 0]) cap();
}
