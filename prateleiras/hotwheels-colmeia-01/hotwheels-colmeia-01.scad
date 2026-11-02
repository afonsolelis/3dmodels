// hotwheels-colmeia-01.scad
// Modular honeycomb wall rack for 1:64 Hot Wheels / Matchbox cars. ONE print
// = one panel of 8 cells (2 columns x 4, the second column offset half a
// cell), sized to fill the AD5X 220 x 220 bed. Cells share their inner walls.
//
// Each cell is a SQUASHED hexagon: long flat floor and roof (the car's length)
// and short steep sides, so little space is wasted. The car sits sideways
// (profile showing) on the floor, behind a small front lip.
//
// Panels tile like the cells do: put the next panel above (+4 rows), beside
// (+2 columns) or diagonally. Dovetail rails run front-to-back on the panel's
// outer edges: male on faces that look up / up-left / up-right, grooves on
// the faces that look down. To add a panel, line it up with one already on
// the wall and slide it straight in until the tape touches. The back has a
// shallow recess behind each cell for double-sided foam tape.
//
// Edge walls are thicker (wall_edge) to hold the grooves; they grow inward,
// so the cell pitch stays the same across panels.
//
// Car envelope (mainline 1:64): up to ~80 long, ~35 wide, ~40 tall.
//
// Print: back on the bed, no supports. It is a big flat part: use a brim.
// Export:
//   "C:/Program Files/OpenSCAD/openscad.com" -o <abs>/hotwheels-colmeia-01.stl <abs>/hotwheels-colmeia-01.scad

part = "panel"; // "panel" | "wall" (4 panels with cars, preview)

/* [Car] */
car_l = 80;
car_w = 35;
car_h = 40;

/* [Cell] */
in_floor = 86;      // inner floor / roof length
in_h     = 45;      // inner height (cells on a panel edge lose wall_edge - wall/2)
side_a   = 70;      // side slope, degrees from horizontal
wall     = 2.4;     // shared inner walls
wall_edge = 3.0;    // panel edge walls (hold the dovetail grooves)
back_t   = 2.4;
in_depth = 42;      // back plate to the front
lip_h    = 2.5;     // front lip on each floor
lip_d    = 2.0;

/* [Panel] */
cols = 2;
rows = 4;

/* [Dovetail rails] */
dt_neck = 5;
dt_head = 7.5;
dt_d    = 1.2;
dt_tol  = 0.15;     // per side

/* [Tape recess, one per cell] */
tape_w = 60;
tape_h = 18;
tape_d = 0.6;       // foam tape ~1 mm: stands 0.4 mm proud and gets pressed

$fn = 32;

// ---------------------------------------------------------------------
depth = back_t + in_depth;
t = tan(side_a);

// Cell outline on the wall centrelines: half floor b, half height h, point a.
hc = in_h / 2 + wall / 2;
ac = in_floor / 2 + (in_h / 2) / t + (wall / 2) / sin(side_a);
bc = ac - hc / t;
function hexpts(a, b, h) = [[b, h], [-b, h], [-a, 0], [-b, -h], [b, -h], [a, 0]];
cpts = hexpts(ac, bc, hc);

// faces as vertex index pairs
ROOF = [0, 1]; UR = [5, 0]; UL = [1, 2];     // "upper": male rails
FLOOR = [3, 4]; LL = [2, 3]; LR = [4, 5];    // "lower": grooves
faces = [ROOF, UR, UL, FLOOR, LL, LR];
function mid(f) = (cpts[f[0]] + cpts[f[1]]) / 2;
function nrm(f) = let(d = cpts[f[1]] - cpts[f[0]]) [d[1], -d[0]] / norm(d);
function nbv(f) = cpts[f[0]] + cpts[f[1]];   // centre offset of the neighbour across f

col_pitch = ac + bc;
row_pitch = 2 * hc;
cells = [for (c = [0 : cols - 1]) for (r = [0 : rows - 1])
            [c * col_pitch, r * row_pitch + (c % 2) * hc]];
function in_panel(p) = len([for (q = cells) if (norm(q - p) < 0.01) 1]) > 0;
function boundary(cell, i) = !in_panel(cell + nbv(faces[i]));

echo(str("hotwheels-colmeia-01: panel of ", len(cells), " cells | cell pitch ",
         col_pitch, " x ", row_pitch, " | panel repeats every ",
         cols * col_pitch, " (x) / ", rows * row_pitch, " (y)"));
assert(in_floor >= car_l + 4, "floor shorter than the car");
assert(in_h - (wall_edge - wall / 2) >= car_h + 2, "edge cells too low for the car");
assert(in_depth >= car_w + 4, "too shallow for the car");
assert(wall_edge - dt_d - dt_tol >= 1.2, "groove leaves the edge wall too thin");

module cell_outline() { polygon(cpts); }
module panel_outline() { for (p = cells) translate(p) cell_outline(); }

// Inner pocket of a cell: wall/2 off shared faces, wall_edge off panel edges.
module pocket(p) {
    intersection() {
        translate(p) offset(delta = -wall / 2) cell_outline();
        offset(delta = -wall_edge) panel_outline();
    }
}

// Dovetail at face f of the cell at p: rail outward, or groove into the wall.
module dovetail(p, f, grow = 0, into = false) {
    n = nrm(f);
    translate(p + mid(f)) rotate(atan2(n[1], n[0]) + (into ? 180 : 0))
        polygon([
            [-0.5,        -dt_neck / 2 - grow],
            [dt_d + grow, -dt_head / 2 - grow],
            [dt_d + grow,  dt_head / 2 + grow],
            [-0.5,         dt_neck / 2 + grow]
        ]);
}

module lip(p) {
    floor_y = p[1] - hc + (boundary(p, 3) ? wall_edge : wall / 2);
    hull() {
        translate([0, 0, depth - lip_d - lip_h]) linear_extrude(0.01)
            intersection() { pocket(p); translate([p[0] - ac, floor_y - 1]) square([2 * ac, 1.01]); }
        translate([0, 0, depth - lip_d]) linear_extrude(lip_d)
            intersection() { pocket(p); translate([p[0] - ac, floor_y - 1]) square([2 * ac, lip_h + 1]); }
    }
}

module panel() {
    difference() {
        union() {
            linear_extrude(depth) difference() {
                panel_outline();
                for (p = cells) pocket(p);
            }
            linear_extrude(back_t) panel_outline();
            for (p = cells) lip(p);
            linear_extrude(depth)
                for (p = cells) for (i = [0 : 2]) if (boundary(p, i)) dovetail(p, faces[i]);
        }
        for (p = cells) for (i = [3 : 5]) if (boundary(p, i)) {
            translate([0, 0, -1]) linear_extrude(depth + 2) dovetail(p, faces[i], dt_tol, true);
            hull() {   // lead-in at the front
                translate([0, 0, depth - 1]) linear_extrude(0.01) dovetail(p, faces[i], dt_tol, true);
                translate([0, 0, depth]) linear_extrude(0.01) dovetail(p, faces[i], dt_tol + 0.8, true);
            }
        }
        for (p = cells) translate([p[0] - tape_w / 2, p[1] - tape_h / 2, -1])
            cube([tape_w, tape_h, tape_d + 1]);
    }
}

module car_ghost(p) {
    floor_y = p[1] - hc + (boundary(p, 3) ? wall_edge : wall / 2);
    translate([p[0] - car_l / 2, floor_y, back_t + (in_depth - car_w) / 2]) cube([car_l, car_h, car_w]);
}

module wall_preview() {
    for (o = [[0, 0], [cols * col_pitch, 0], [0, rows * row_pitch], [cols * col_pitch, rows * row_pitch]])
        translate(o) { panel(); for (p = cells) %car_ghost(p); }
}

if (part == "wall") wall_preview();
else panel();
