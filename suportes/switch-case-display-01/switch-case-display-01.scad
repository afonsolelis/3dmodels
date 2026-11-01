// switch-case-display-01.scad
// Display box for ONE sealed Nintendo Switch game case, standing upright.
// An open-top sleeve with a floor: the case drops in from the top. The front
// is a U frame (sides and bottom only), so the cover shows all the way up and
// the upright print has no bridges. A low flared foot (12 mm front and back)
// keeps it from tipping.
//
// Optional clear sheet: set sheet_t (e.g. 0.5-1 mm PET/acrylic about
// 105 x 168 mm) and drop it in before the case; the case holds it against
// the inside of the frame.
//
// Case size: nominal Switch / Switch 2 case, ~105 x 170 x 11 mm. NOT measured
// on the user's sealed case yet: measure it (shrink wrap included) and adjust
// case_w / case_h / case_t before printing.
//
// Print: one part, upright on its foot, no supports. Export:
//   "C:/Program Files/OpenSCAD/openscad.com" -o <abs>/switch-case-display-01.stl <abs>/switch-case-display-01.scad

part = "print"; // "print" | "check" (with the case ghost)

/* [Case - nominal, measure yours] */
case_w = 105;   // X, width
case_h = 170;   // Z, height (standing)
case_t = 11;    // Y, thickness

/* [Fit] */
fit_w = 1.5;    // total play in width
fit_h = 1.5;    // walls stand this much above the case
fit_t = 1.0;    // total play in thickness
sheet_t = 0;    // optional clear sheet behind the window (0 = none)

/* [Shape] */
wall    = 3.2;  // all walls (8 lines of a 0.4 nozzle)
floor_t = 2.0;
r       = 2.0;  // outer corner radius
foot    = 12;   // foot sticks out this much front and back
foot_h  = 4;
foot_ch = 2;    // chamfer on the foot top edge

/* [Window] */
window_border = 5;  // frame covers this much of the case on each side
window_r      = 3;  // bottom corner radius

$fn = 40;

// ---------------------------------------------------------------------
in_w = case_w + fit_w;
in_t = case_t + fit_t + sheet_t;
in_h = case_h + fit_h;

body_w = in_w + 2 * wall;
body_t = in_t + 2 * wall;

body_h = floor_t + in_h;

window_w  = case_w - 2 * window_border;
window_z0 = foot_h + 2;

echo(str("switch-case-display-01: sleeve ", body_w, " x ", body_t + 2 * foot, " (foot) x ", body_h,
         " | window ", window_w, " wide, open at the top | ", body_h - floor_t - case_h,
         " mm of wall above the case"));

module rbox(w, t, h, rr) {
    translate([rr, rr, 0]) linear_extrude(h) offset(r = rr) square([w - 2 * rr, t - 2 * rr]);
}

module foot_block() {
    hull() {
        translate([0, -foot, 0]) rbox(body_w, body_t + 2 * foot, foot_h - foot_ch, r);
        translate([0, -foot + foot_ch, 0]) rbox(body_w, body_t + 2 * foot - 2 * foot_ch, foot_h, r);
    }
}

module window_cut() {
    translate([(body_w - window_w) / 2, wall + 1, window_z0])
        rotate([90, 0, 0])
            linear_extrude(wall + 2)
                translate([window_r, window_r])
                    offset(r = window_r)
                        square([window_w - 2 * window_r, body_h]);  // runs out the top: U
}

module body() {
    difference() {
        union() {
            rbox(body_w, body_t, body_h, r);
            foot_block();
        }
        // cavity, open on top
        translate([wall, wall, floor_t]) cube([in_w, in_t, body_h]);
        window_cut();
    }
}

module case_ghost() {
    translate([wall + fit_w / 2, wall + sheet_t + fit_t / 2, floor_t]) cube([case_w, case_t, case_h]);
}

if (part == "check") { body(); %case_ghost(); }
else body();
