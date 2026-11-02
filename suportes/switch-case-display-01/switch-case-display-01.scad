// switch-case-display-01.scad
// Display box for ONE sealed Nintendo Switch game case, standing upright.
// A sleeve with a floor: the case drops in from the top. The front is a U
// frame (sides and bottom only), so the cover shows all the way up and the
// upright print has no bridges. A low flared foot (12 mm front and back)
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
// L lid, built in: a top panel plus a front tab (lid_leg) that fills the top
// of the U. It slides in from the FRONT along grooves cut on the INSIDE of the
// side walls and stops on the back wall. Closed, it is flush with the top and
// the front, so the outside reads as one plain box. The groove edges are a
// flat step plus a 45-degree face (a dovetail), so the panel cannot lift out
// and nothing hangs in the air when printing.
//
// Print: no supports. The STL holds both parts on the bed: the sleeve upright
// on its foot and the lid upside down (top panel on the bed). Export:
//   "C:/Program Files/OpenSCAD/openscad.com" -o <abs>/switch-case-display-01.stl <abs>/switch-case-display-01.scad

part = "print"; // "print" (both parts) | "body" | "lid" | "check" (assembled, with the case ghost)

/* [Case - nominal, measure yours] */
case_w = 105;   // X, width
case_h = 170;   // Z, height (standing)
case_t = 11;    // Y, thickness

/* [Fit] */
fit_w = 1.5;    // total play in width
fit_h = 1.5;    // gap between the case top and the lid
fit_t = 1.0;    // total play in thickness
sheet_t = 0;    // optional clear sheet behind the window (0 = none)

/* [Shape] */
wall    = 4.0;  // all walls (10 lines of a 0.4 nozzle)
floor_t = 2.4;
r       = 2.0;  // outer corner radius
foot    = 12;   // foot sticks out this much front and back
foot_h  = 4;
foot_ch = 2;    // chamfer on the foot top edge

/* [Window] */
window_border = 5;  // frame covers this much of the case on each side
window_r      = 3;  // bottom corner radius

/* [Lid] */
lid_t    = 3.2;  // top panel thickness (flush with the wall tops)
groove_d = 1.6;  // how far the panel edges sink into each side wall (wall - groove_d stays solid)
lid_leg  = 20;   // front tab goes down this much from the top
lid_clr  = 0.3;  // play between lid and sleeve

$fn = 40;

// ---------------------------------------------------------------------
in_w = case_w + fit_w;
in_t = case_t + fit_t + sheet_t;
in_h = case_h + fit_h;

body_w = in_w + 2 * wall;
body_t = in_t + 2 * wall;

body_h = floor_t + in_h + lid_t;

window_w  = case_w - 2 * window_border;
window_x0 = (body_w - window_w) / 2;
window_z0 = foot_h + 2;

lid_z0  = body_h - lid_t;        // panel underside / groove step
lid_y1  = body_t - wall - lid_clr; // panel back edge, stops on the back wall
groove_flat = lid_t - groove_d;  // vertical part of the panel edge

echo(str("switch-case-display-01: box ", body_w, " x ", body_t + 2 * foot, " (foot) x ", body_h,
         " | window ", window_w, " wide | lid ", body_w - 2 * wall + 2 * groove_d, " x ", lid_y1,
         " + front tab ", lid_leg));

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
    translate([window_x0, wall + 1, window_z0])
        rotate([90, 0, 0])
            linear_extrude(wall + 2)
                translate([window_r, window_r])
                    offset(r = window_r)
                        square([window_w - 2 * window_r, body_h]);  // runs out the top: U
}

// Panel cross-section in X/Z. Edges: vertical, then 45 degrees in to the top.
// c = play: the edges move in by c (the 45-degree face by c * sqrt 2 sideways,
// which is c square to the face). The bottom stays on the groove step and the
// top stays flush.
module panel_2d(c, top_extra = 0) {
    xl = wall - groove_d + c;
    xr = body_w - wall + groove_d - c;
    zk = lid_z0 + groove_flat - c * sqrt(2) + c;  // where the vertical edge meets the 45
    polygon([
        [xl, lid_z0], [xr, lid_z0], [xr, zk],
        [body_w - wall - c * sqrt(2), body_h], [body_w - wall - c * sqrt(2), body_h + top_extra],
        [wall + c * sqrt(2), body_h + top_extra], [wall + c * sqrt(2), body_h], [xl, zk]]);
}

// Extrude an X/Z profile along Y over [y0, y1].
module along_y(y0, y1) {
    translate([0, y1, 0]) rotate([90, 0, 0]) linear_extrude(y1 - y0) children();
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
        // lid track: open at the front, blind at the back wall
        along_y(-1, body_t - wall) panel_2d(0, 1);
    }
}

// Lid in the assembled position.
module lid() {
    union() {
        along_y(0, lid_y1) panel_2d(lid_clr);
        // front tab: fills the top of the U, flush with the front face
        translate([window_x0 + lid_clr, 0, body_h - lid_leg]) cube([window_w - 2 * lid_clr, wall, lid_leg]);
    }
}

// Lid flipped for printing: top panel on the bed.
module lid_print() {
    translate([0, 0, body_h]) mirror([0, 0, 1]) lid();
}

module case_ghost() {
    translate([wall + fit_w / 2, wall + sheet_t + fit_t / 2, floor_t]) cube([case_w, case_t, case_h]);
}

if (part == "check") { body(); lid(); %case_ghost(); }
else if (part == "body") body();
else if (part == "lid") lid_print();
else {
    body();
    translate([0, body_t + foot + 10, 0]) lid_print();  // behind the sleeve
}
