/*
Card-mailer-01: estojos internos de transporte, 3/10 sleeves ou UMA slab BGS.
Colocar fita macia de retirada sob o conteudo, forro removivel de 1 mm embaixo
 e em cima; dobrar pontas da fita para dentro. Retirar levantando ambas pontas,
sem curvar os cards. Tampa sobreposta solta: LACRAR com fita em dois sentidos.
Usar dentro de embalagem externa de papelao com amortecimento; nao estanque.
Medidas reutilizadas por autorizacao do usuario: deckbox-03, 60 cards 68x93x45;
espessuras 2.25/7.5 sao ESTIMATIVAS proporcionais. BGS: bgs-stand-01, medida
real 82.5x130.2x8.5. Nao afirma compatibilidade PSA/CGC nem toploader.
Comandos canonicos (caminhos absolutos, repetir variant para cards3/cards10/bgs):
flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/card-mailer-01/stl/cards3-base.stl -D 'variant="cards3"' -D 'part="base"' /home/afonsolelis/repos/3dmodels/deckboxes/card-mailer-01/card-mailer-01.scad
flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/card-mailer-01/stl/cards3-lid.stl -D 'variant="cards3"' -D 'part="lid"' /home/afonsolelis/repos/3dmodels/deckboxes/card-mailer-01/card-mailer-01.scad
flatpak run org.openscad.OpenSCAD -o /home/afonsolelis/repos/3dmodels/deckboxes/card-mailer-01/3mf/cards3.3mf -D 'variant="cards3"' -D 'part="plate"' /home/afonsolelis/repos/3dmodels/deckboxes/card-mailer-01/card-mailer-01.scad
Base boca para cima; tampa teto na mesa e boca para cima. Sem suportes.
Curso vertical total = overlap: nao ha gancho nem trava, folga constante;
levantamento >= overlap libera tampa. Batente e o aro superior da base.
*/
/* [Selecao] */
variant = is_undef(variant_override) ? "cards3" : variant_override; // cards3, cards10, bgs
part = "plate"; // base, lid, plate, assembled
/* [Objeto medido] */
card_w = 68; // mm, largura sleeved real
card_l = 93; // mm, comprimento sleeved real
card_t = 45/60; // mm/card ESTIMADO a partir de deck real de 60
slab_w = 82.5; // mm, BGS real
slab_l = 130.2; // mm, BGS real
slab_t = 8.5; // mm, BGS real
/* [Protecao e encaixe] */
content_clear = 1; // mm/lado, folga horizontal do conteudo
padding = 1; // mm POR FACE: duas folhas macias removiveis
headroom = 1; // mm, reserva vertical para fita de retirada e folga
wall = 2.4; // mm, parede da base
floor_t = 2.4; // mm, fundo rigido
roof_t = 2.4; // mm, teto rigido
skirt_t = 2; // mm, saia da tampa
fit = 0.5; // mm/lado, folga de deslize
mouth = 0.6; // mm, chanfro de entrada 45 graus
base_grip = 3; // mm, faixa inferior exposta para segurar base
plate_gap = 6; // mm, vao entre base e tampa
/* [Hidden] */
$fn=48;
eps=0.01;
// Derivados
is_slab = variant == "bgs";
n = variant == "cards10" ? 10 : 3;
w = is_slab ? slab_w : card_w;
l = is_slab ? slab_l : card_l;
t = is_slab ? slab_t : n*card_t;
iw=w+2*content_clear;
il=l+2*content_clear;
depth=t+2*padding+headroom;
bw=iw+2*wall;
bl=il+2*wall;
bh=floor_t+depth;
br=wall+1;
lw=bw+2*(fit+skirt_t);
ll=bl+2*(fit+skirt_t);
lr=br+fit+skirt_t;
overlap=bh-base_grip;
lh=roof_t+overlap;
assert(variant=="cards3" || variant=="cards10" || variant=="bgs");
assert(fit>=0.5 && overlap>mouth && skirt_t-mouth>=1.2);
assert(lw+bw+plate_gap<=210 && ll<=210);
echo(variant=variant, content=[w,l,t], cavity=[iw,il,depth], base=[bw,bl,bh], lid=[lw,ll,lh], assembled=[lw,ll,bh+roof_t], opening_stroke=overlap, plate=[bw+plate_gap+lw,ll,max(bh,lh)], fit_per_side=fit);
module rr(w,l,r) { translate([r,r]) offset(r=r) square([w-2*r,l-2*r]); }
module prism(w,l,r,h) { linear_extrude(height=h) rr(w,l,r); }
module base() {
 difference() {
  prism(bw,bl,br,bh);
  translate([wall,wall,floor_t]) prism(iw,il,1,depth+eps);
 }
}
module lid() {
 difference() {
  prism(lw,ll,lr,lh);
  translate([skirt_t,skirt_t,roof_t]) prism(bw+2*fit,bl+2*fit,br+fit,overlap+eps);
  hull() {
   translate([skirt_t,skirt_t,lh-mouth]) prism(bw+2*fit,bl+2*fit,br+fit,eps);
   translate([skirt_t-mouth,skirt_t-mouth,lh]) prism(bw+2*fit+2*mouth,bl+2*fit+2*mouth,br+fit+mouth,eps);
  }
 }
}
if(part=="base") base();
else if(part=="lid") lid();
else if(part=="plate") { base(); translate([bw+plate_gap,0,0]) lid(); }
else if(part=="assembled") { base(); translate([-fit-skirt_t,ll-fit-skirt_t,bh+roof_t]) rotate([180,0,0]) lid(); }
else assert(false,"part desconhecida");
