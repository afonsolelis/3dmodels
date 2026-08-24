// emergency-nfc-card-01.scad
// Cartao de emergencia fino, no formato ISO/IEC 7810 ID-1 (cartao bancario),
// com informacoes medicas essenciais gravadas na frente e um rebaixo aberto
// no verso para colar uma tag NFC circular de 27mm.
//
// A tag e adesiva e entra DEPOIS da impressao. O rebaixo tem 27.4mm para nao
// raspar a borda da tag e um pequeno entalhe lateral para permitir a troca.
// O cartao imprime em uma peca, com a FRENTE apoiada na mesa e o rebaixo da
// NFC virado para cima. Os textos sao rebaixados para nao aumentar a espessura.
// Usar placa lisa e Arachne para preservar letras pequenas. Sem suporte.
//
// Exports canonicos (usar o Flatpak nesta maquina):
//   flatpak run org.openscad.OpenSCAD -o stl/emergency-nfc-card-01.stl emergency-nfc-card-01.scad
//   flatpak run org.openscad.OpenSCAD -o 3mf/emergency-nfc-card-01.3mf emergency-nfc-card-01.scad

/* [Peca a renderizar] */
part = "card"; // "card" | "preview-front" | "preview-back"

/* [Cartao ISO ID-1] */
card_w = 85.60; // mm
card_h = 53.98; // mm
card_t = 1.20;  // mm; 6 camadas a 0.20mm, fino mas ainda manuseavel em PLA/PETG
corner_r = 3.18; // mm, raio nominal do cartao bancario

/* [Tag NFC - medida real informada pelo usuario em 2026-08-23] */
tag_d = 27.00;          // mm, diametro real da tag adesiva
tag_clearance = 0.20;   // mm por lado; o adesivo nao e press-fit
tag_recess_depth = 0.30; // mm, rebaixo raso; ajustar se a tag ficar muito alta/baixa
peel_notch_w = 6.0;     // mm, largura do entalhe para unha
peel_notch_l = 3.5;     // mm, quanto o entalhe passa da borda do rebaixo

/* [Gravacao] */
engrave_depth = 0.24; // mm, aproximadamente uma camada fina
font = "DejaVu Sans:style=Bold";

/* [Qualidade] */
$fn = 96;
eps = 0.02;

// ---------------------------------------------------------------------
// Derivados e verificacoes
// ---------------------------------------------------------------------
tag_pocket_d = tag_d + 2 * tag_clearance;
tag_floor_t = card_t - tag_recess_depth;
minimum_web_t = card_t - tag_recess_depth - engrave_depth;

assert(card_t >= 1.0, "card_t abaixo de 1mm fica fragil demais para FDM");
assert(tag_floor_t >= 0.75, "Piso sob a tag fino demais; aumente card_t ou reduza tag_recess_depth");
assert(minimum_web_t >= 0.60, "Parede fina demais onde texto frontal e rebaixo NFC se sobrepoem");
assert(tag_pocket_d + 8 < card_h, "Tag/rebaixo nao cabe na altura do cartao");

echo(str("emergency-nfc-card-01: cartao ", card_w, " x ", card_h, " x ", card_t, " mm"));
echo(str("  tag medida Ø", tag_d, " | rebaixo Ø", tag_pocket_d, " x ", tag_recess_depth, " mm"));
echo(str("  piso sob a tag ", tag_floor_t, " mm | texto rebaixado ", engrave_depth, " mm"));
echo(str("  parede minima sob letras que cruzam a tag ", minimum_web_t, " mm"));

// ---------------------------------------------------------------------
// Geometria principal
// ---------------------------------------------------------------------
module rounded_card_2d(inset = 0) {
    w = card_w - 2 * inset;
    h = card_h - 2 * inset;
    r = max(0.01, corner_r - inset);
    assert(w > 2 * r && h > 2 * r, "Inset invalido no retangulo arredondado");
    hull()
        for (x = [-w / 2 + r, w / 2 - r],
             y = [-h / 2 + r, h / 2 - r])
            translate([x, y]) circle(r = r);
}

module text_cut(label, size, x, y, z0, depth, halign = "center") {
    translate([x, y, z0])
        linear_extrude(depth + 2 * eps, convexity = 10)
            text(label, size = size, font = font,
                 halign = halign, valign = "center", spacing = 1.0);
}

module front_engraving() {
    // Frente: somente o que ajuda mesmo se o NFC/celular nao funcionar.
    text_cut("CARTÃO DE EMERGÊNCIA",       4.15, 0,  21.1, -eps, engrave_depth);
    text_cut("AFONSO CESAR LELIS BRANDÃO", 3.15, 0,  14.9, -eps, engrave_depth);

    // Separador fino, tambem rebaixado.
    translate([-35.8, 11.4, -eps])
        cube([71.6, 0.36, engrave_depth + 2 * eps]);

    text_cut("A+  •  MARCAPASSO CARDÍACO",  3.55, 0,   7.9, -eps, engrave_depth);
    text_cut("BIOTRONIK  •  ENTOVIS DR-T",  3.25, 0,   2.3, -eps, engrave_depth);

    text_cut("CONTATO DE EMERGÊNCIA",       2.75, 0,  -4.0, -eps, engrave_depth);
    text_cut("CATARINNE — ESPOSA",          3.25, 0,  -8.9, -eps, engrave_depth);
    text_cut("+55 11 97810-1179",           4.15, 0, -14.2, -eps, engrave_depth);

    text_cut("DETALHES MÉDICOS NA TAG NFC", 2.45, 0, -21.1, -eps, engrave_depth);
}

module tag_recess() {
    // Cavidade circular aberta no verso (face superior na orientacao de
    // impressao). A folga serve apenas para centralizar o adesivo.
    translate([0, 0, card_t - tag_recess_depth])
        cylinder(h = tag_recess_depth + eps, d = tag_pocket_d);

    // Entalhe tangente no lado direito: deixa uma pequena borda da tag
    // acessivel sem furar o piso que a sustenta.
    translate([tag_pocket_d / 2 - eps, -peel_notch_w / 2,
               card_t - tag_recess_depth])
        cube([peel_notch_l + eps, peel_notch_w,
              tag_recess_depth + eps]);
}

module back_engraving() {
    z0 = card_t - engrave_depth;
    text_cut("NFC  •  APROXIME O CELULAR", 3.55, 0,  20.7,
             z0, engrave_depth);
    text_cut("TAG ADESIVA Ø27 mm",         2.65, 0, -19.3,
             z0, engrave_depth);
}

module emergency_card() {
    difference() {
        linear_extrude(card_t) rounded_card_2d();
        // A frente fica na face INFERIOR durante a impressao. Espelhar em Y
        // aqui compensa a virada fisica do cartao: depois de tirar da mesa e
        // virar pelo eixo horizontal, todas as letras ficam legiveis.
        mirror([0, 1, 0]) front_engraving();
        tag_recess();
        back_engraving();
    }
}

// ---------------------------------------------------------------------
// Render
// ---------------------------------------------------------------------
if (part == "preview-front") {
    // So muda a orientacao de visualizacao: a geometria do export continua
    // sendo exatamente a mesma do cartao canonico.
    rotate([180, 0, 0]) emergency_card();
} else {
    // "card" e "preview-back" mostram o verso para cima, que tambem e a
    // orientacao correta de impressao (frente na placa, NFC para cima).
    emergency_card();
}
