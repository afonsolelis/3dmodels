// porta-caneta-passa-cabo-01.scad
// Pen holder that drops into a 50 mm desk cable grommet hole: a tube that
// hangs 80 mm deep under the desk top, with a flange (aba) that rests on the
// desk. The bottom is a 45 deg cone (pens settle in the middle), so the part
// prints UPSIDE DOWN, flange on the bed, with no supports and no bridges.
//
// Export (already in print orientation):
//   "C:/Program Files/OpenSCAD/openscad.com" -o <abs>/porta-caneta-passa-cabo-01.stl <abs>/porta-caneta-passa-cabo-01.scad

part = "print"; // "print" (flange down) | "installed" (flange up)

/* [Desk hole] */
hole_d    = 50;    // measured hole diameter
hole_fit  = 0.4;   // play per side in the hole

/* [Holder] */
depth     = 80;    // usable depth, from the flange top to the bottom of the cone
wall      = 2.0;
flange_d  = 62;    // 6 mm of flange around the hole
flange_t  = 2.5;
edge_ch   = 0.8;   // chamfer on the flange edges

$fn = 120;

// ---------------------------------------------------------------------
tube_r = hole_d / 2 - hole_fit;
in_r   = tube_r - wall;
cone_h = in_r;                 // 45 deg inner cone
// tube body length (flat part) so the inner cone tip sits at `depth`
straight = depth - cone_h;
// outer cone ends wall*sqrt(2) past the inner tip, so the cone wall is `wall` thick
outer_cone_h = in_r + wall * sqrt(2);

echo(str("porta-caneta: tube OD ", 2 * tube_r, " / ID ", 2 * in_r,
         " | depth ", depth, " (", straight, " straight + ", cone_h, " cone)",
         " | hangs ", straight + outer_cone_h - flange_t, " mm under the desk top",
         " | flange ", flange_d, " x ", flange_t));

// Modelled in print orientation: flange on z = 0, tube going up.
module holder() {
    difference() {
        union() {
            // flange, chamfered on both edges
            hull() {
                cylinder(r = flange_d / 2 - edge_ch, h = flange_t);
                translate([0, 0, edge_ch]) cylinder(r = flange_d / 2, h = flange_t - 2 * edge_ch);
            }
            // tube + outer 45 deg cone (wall measured square to the cone)
            outer_straight = straight + outer_cone_h - tube_r;
            cylinder(r = tube_r, h = outer_straight);
            translate([0, 0, outer_straight])
                cylinder(r1 = tube_r, r2 = 0, h = tube_r);
        }
        // bore + inner cone
        translate([0, 0, -1]) cylinder(r = in_r, h = straight + 1);
        translate([0, 0, straight - 0.01]) cylinder(r1 = in_r, r2 = 0, h = cone_h);
        // lead-in chamfer at the mouth (flange top, which is on the bed here)
        translate([0, 0, -0.01]) cylinder(r1 = in_r + 1, r2 = in_r, h = 1);
    }
}

if (part == "installed") translate([0, 0, flange_t]) mirror([0, 0, 1]) holder();
else holder();
