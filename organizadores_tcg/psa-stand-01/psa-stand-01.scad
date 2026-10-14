// psa-stand-01.scad
// Suporte de mesa pra UMA slab graduada PSA, inclinada 12° pra trás.
// UMA peça só, ABERTA EM CIMA, imprime sem suporte.
// derived_from: ../ars-stand-01 e ../bgs-stand-01 (mesmo desenho, aprovados no print-review,
// ainda sem teste físico),
// só com a medida da slab PSA.
//
// COMO SE USA: a slab desce POR CIMA, entre os dois trilhos, e escorrega até
// o fundo do canal. Pra tirar, pinça a faixa de cima da slab que fica acima
// dos trilhos (~14.5mm, ver slab_livre) e puxa pra cima. Não há trava.
// A ETIQUETA da PSA fica no TOPO da slab: a faixa de cima sai totalmente
// livre acima dos trilhos e, abaixo dela, a aba só toca 1.0-2.0mm das bordas
// laterais (a moldura de plástico da slab, fora da etiqueta).
//
// O QUE SEGURA A SLAB:
//   - atrás: o PAINEL. A inclinação de 12° joga o peso da slab contra ele;
//     o centro de massa da slab (assentada) fica atrás da aresta de
//     baixo/frente dela (ver echo cg_atras_pivo), então não tomba pra frente
//     nem sem aba nenhuma;
//   - na frente: a ABA dos trilhos, que cobre 1.0-2.0mm de cada borda lateral
//     (1.5 com a slab centrada) da face ao longo de toda a altura do trilho;
//   - dos lados: as paredes dos trilhos;
//   - embaixo: o piso do canal e o LÁBIO frontal da base (ver echo
//     labio_cobre, medido com a slab assentada contra o painel).
//   Pra cima só a gravidade segura — de propósito, é por onde ela sai.
//
// MEDIDA REAL: slab PSA medida pelo usuário, confirmada e remedida em
// 2026-10-13: 80.1 x 135.1 x 6.1 mm (largura x altura x espessura). Não é
// estimativa nem catálogo (as estimativas antigas do repo, 83.6-85.4 de
// largura, NÃO valem aqui).
//
// Exports canônicos (caminhos ABSOLUTOS; nesta máquina Windows o binário é
// "C:/Program Files/OpenSCAD/openscad.com"; no Linux, flatpak run org.openscad.OpenSCAD):
//   openscad -o <abs>/stl/psa-stand-01-stand.stl -D 'part="stand"' <abs>/psa-stand-01.scad
//   openscad -o <abs>/3mf/psa-stand-01.3mf       -D 'part="stand"' <abs>/psa-stand-01.scad
// O job de impressão é a própria peça, em pé (base na mesa), sem suporte.

/* [Peça a renderizar] */
part = "stand"; // "stand" | "check" (suporte + slab fantasma)

/* [Slab PSA - medida REAL do usuário, remedida 2026-10-13] */
slab_w = 80.1;  // mm, largura
slab_h = 135.1; // mm, altura (a etiqueta fica no topo)
slab_t = 6.1;   // mm, espessura

/* [Folgas] */
fit_w = 0.5; // mm por lado, na largura (deslize longo: padrão 0.5/lado do repo)
fit_t = 0.5; // mm por lado, na espessura (idem)
fit_h = 0.5; // mm de sobra no comprimento, no fundo do canal
mouth_ch = 1; // mm, chanfro de entrada na boca do canal (topo dos trilhos e do painel)

/* [Postura] */
lean = 12; // graus de inclinação pra trás (o de referência tinha 11.9)

/* [Painel e trilhos] */
panel_t  = 3;   // mm, espessura do painel de trás
wall     = 2;   // mm, espessura da parede lateral do trilho
rail_lip = 2;   // mm, quanto a aba do trilho avança pra dentro do vão (por lado)
lip_t    = 2.5; // mm, espessura da aba do trilho e do lábio frontal da base
grip     = 15;  // mm do canal (L) que ficam acima dos trilhos e do painel; com a
                // slab assentada no piso sobram slab_livre = 14.5mm dela pra pinçar
rail_sink = 1;  // mm que o pé dos trilhos afunda na base (só fusão, não muda o vão)

/* [Base] */
floor_z   = 3;  // mm, material sólido abaixo do canal
lip_h     = 9;  // mm, altura do lábio frontal acima do piso do canal
base_back = 18; // mm, quanto a base avança atrás do pé do painel (é o que
                // impede o conjunto de cair pra trás — o centro de massa fica
                // atrás do painel por causa da inclinação)

/* [Qualidade] */
$fn = 48;

// ---------------------------------------------------------------------
// Derivados
// ---------------------------------------------------------------------
slot_t  = slab_t + 2 * fit_t; // vão pra espessura da slab
slot_w  = slab_w + 2 * fit_w; // vão pra largura da slab
outer_w = slot_w + 2 * wall;  // largura externa
L       = slab_h + fit_h;     // comprimento útil do canal, ao longo da slab

rail_d       = slot_t + lip_t;  // quanto o trilho avança à frente do painel
top_du       = L - grip;        // trilhos e painel terminam aqui (ao longo da slab)
lip_top      = floor_z + lip_h; // topo do lábio frontal da base

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
total_h      = pt(top_du, slot_t + lip_t)[1];   // ponto mais alto: frente do trilho no topo
base_depth   = base_back_x - lip_front_x;
env_back_x   = pt(top_du, -panel_t)[0];
env_depth    = max(base_back_x, env_back_x) - lip_front_x;
face_visivel = slot_w - 2 * rail_lip;
lip_sobre_slab = wall + rail_lip - (wall + fit_w); // aba cobrindo a borda da slab, por lado
// Slab ASSENTADA: apoiada no piso (du=0) e deitada contra o painel (dn=0..slab_t),
// que é onde a gravidade e a inclinação deixam ela.
slab_livre   = slab_h - top_du;                    // mm de slab acima dos trilhos, pra pinçar
slab_cg_du   = slab_h / 2;                         // centro da slab ao longo do canal
// recuo horizontal do CG da slab atrás da aresta de baixo/frente dela (pivô de tombar pra frente)
cg_atras_pivo = pt(slab_cg_du, slab_t / 2)[0] - pt(0, slab_t)[0];
montado_h    = pt(slab_h, slab_t)[1];              // altura do conjunto: canto de cima/frente da slab
// quanto o lábio da base cobre da parte de baixo da face da slab, medido ao longo da slab
labio_cobre  = (lip_top - floor_z - slab_t * sin(lean)) / cos(lean);

assert(grip > 0 && grip < slab_h / 2, "grip tem que deixar a maior parte da slab nos trilhos");
assert(top_du > slab_cg_du, "o centro da slab precisa ficar abaixo do topo dos trilhos");
assert(lip_sobre_slab > 0, "a aba tem que cobrir a borda da slab");

echo(str("psa-stand-01 SUPORTE: envelope ", env_depth, " x ", outer_w, " x ", total_h,
         " mm | base na mesa ", base_depth, " mm de profundidade"));
echo(str("  slab ", slab_w, " x ", slab_h, " x ", slab_t,
         " -> vao ", slot_w, " x ", L, " x ", slot_t, " | folga/lado ", fit_w, "/", fit_t));
echo(str("  trilhos/painel ate ", top_du, " mm ao longo da slab; ", slab_livre,
         " mm da slab livres acima pra pinçar | curso de insercao ", top_du, " mm"));
echo(str("  montado com slab: ", montado_h, " mm de altura | labio da base cobre ", labio_cobre,
         " mm da parte de baixo da face"));
echo(str("  aba cobre ", lip_sobre_slab, " mm de cada borda | face visivel ", face_visivel,
         " de ", slab_w, " mm | CG da slab ", cg_atras_pivo, " mm atras do pivo frontal"));

// ---------------------------------------------------------------------
// Suporte
// ---------------------------------------------------------------------
module stand() {
    difference() {
        // a intersecao apara o que o pe afundado dos trilhos passaria da frente da base
        intersection() {
            union() {
                // corpo: base + painel, em toda a largura
                xz_extrude(outer_w) polygon(body_profile());
                // dois trilhos em C, um em cada borda (o da direita espelhado)
                rail(0);
                rail(outer_w, true);
            }
            translate([lip_front_x, -1, 0]) cube([500, outer_w + 2, 500]);
        }
        mouth_chamfer();
    }
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
    pt(top_du, 0),                           // sobe a face frontal do painel
    pt(top_du, -panel_t),                    // topo do painel
    [x_at_z(lip_top, -panel_t), lip_top],    // desce a face de trás do painel
    [base_back_x, lip_top],                  // topo da base, atrás do painel
    [base_back_x, 0]                         // face de trás da base, na mesa
];

// Trilho em C numa borda: parede lateral + aba que avança sobre a face da
// slab. Tudo parede vertical: a cada camada a seção é a de baixo deslocada
// 0.04mm pela inclinação, então não existe balanço nenhum.
module rail(y0, flip = false) {
    in_slab_frame()
        translate([0, y0, 0]) {
            if (flip) mirror([0, 1, 0]) rail_body();
            else rail_body();
        }
}

module rail_body() {
    // começa rail_sink abaixo do piso do canal pra fundir de verdade com a base
    // (com o pé exatamente no plano do piso sobrava uma lasca de 1e-5mm)
    translate([-rail_d, 0, -rail_sink]) cube([rail_d, wall, top_du + rail_sink]);           // parede lateral
    translate([-rail_d, 0, -rail_sink]) cube([lip_t, wall + rail_lip, top_du + rail_sink]); // aba sobre a face da slab
}

// Chanfro de entrada na boca: tronco de pirâmide que abre o vão em mouth_ch
// pra cada lado no topo (aba, paredes e painel), guiando a slab pra dentro.
module mouth_chamfer() {
    in_slab_frame()
        hull() {
            translate([-slot_t, wall, top_du - mouth_ch])
                cube([slot_t, slot_w, 0.01]);
            translate([-slot_t - mouth_ch, wall - mouth_ch, top_du])
                cube([slot_t + 2 * mouth_ch, slot_w + 2 * mouth_ch, 1]);
        }
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

// A slab, só pra conferência visual de encaixe (part="check"), assentada.
module slab_ghost() {
    in_slab_frame()
        translate([-slab_t, wall + fit_w, 0])  // assentada: no piso, contra o painel
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
if (part == "check") {
    stand();
    %slab_ghost();
} else {
    stand();
}
