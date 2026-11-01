// slab-stand-01.scad
// Low, quick-print, generic display stand for ONE graded slab, leaning 15 deg back.
// Thin-walled profile extruded across the width (2 mm base plate, low front
// lip, thin back rest with a small fillet): prints on its base, no supports,
// no bridges. The slab's bottom edge drops into a short tilted slot and rests
// against the back wedge; the slab is wider than the stand on purpose (less
// plastic, faster print, edges stay free to grab).
//
// Fits any slab up to 9.8 mm thick: the slot is sized for the THICKEST slab
// measured in this repo (ARS 9.8; BGS 8.8, PCG 7.5, CGC 7.4, GBA 7.1,
// PSA/GRADD 6.2). A slot sized for the thinnest would not take the thick ones;
// thinner slabs just lean back on the rest, the extra play doesn't show.
// Width and height don't matter: the slab only sits on its bottom edge.
//
// Export:
//   "C:/Program Files/OpenSCAD/openscad.com" -o <abs>/slab-stand-01.stl <abs>/slab-stand-01.scad

part = "stand"; // "stand" | "check" (stand + ghost slab)

/* [Slab] */
slab_t = 9.8;   // thickest slab to fit (ARS); sets the slot
slab_w = 80.0;  // only used for the ghost and the tip check
slab_h = 135.0;

/* [Fit] */
fit_t = 0.5;          // per side, on thickness (short drop-in, no long slide)

/* [Shape] */
lean     = 15;        // degrees back
width    = 70;        // narrower than every slab (80-84 mm): all stick out 5-7 mm per side
floor_z  = 2;         // base plate / solid under the slot
lip_h    = 8;         // front lip height above the slot floor
lip_t    = 2.4;       // front lip thickness
back_h   = 25;        // how far up the slab the back rest reaches
panel_t  = 3;         // back rest plate thickness
fillet   = 3;         // gusset where the back rest meets the base plate
base_back = 30;       // base plate length behind the slot (anti-tip backwards)
ch       = 1.0;       // chamfer on the slot mouth

// ---------------------------------------------------------------------
slot_t  = slab_t + 2 * fit_t;
lip_top = floor_z + lip_h;

// Slab frame -> world XZ. du = along the slab (up), dn = forward (toward the
// viewer, -X). Origin = bottom/back corner of the slot.
function pt(du, dn) = [ du * sin(lean) - dn * cos(lean),
                        floor_z + du * cos(lean) + dn * sin(lean) ];
function x_at_z(z, dn) = ((z - floor_z - dn * sin(lean)) / cos(lean)) * sin(lean)
                         - dn * cos(lean);

front_x = x_at_z(lip_top, slot_t) - lip_t;
back_x  = base_back;
depth   = back_x - front_x;

// Slab seated: on the slot floor, against the back face (dn = 0..slab_t).
cg_x      = pt(slab_h / 2, slab_t / 2)[0];
pivot_fwd = pt(0, slab_t)[0];            // tips forward around this edge
assert(cg_x > pivot_fwd, "slab would tip forward");
assert(cg_x < back_x - 10, "base too short: stand would tip backward");

echo(str("slab-stand-01: ", depth, " x ", width, " x ", pt(back_h, 0)[1],
         " mm | slot ", slot_t, " mm | slab CG ", cg_x - pivot_fwd,
         " mm behind front edge, ", back_x - cg_x, " mm ahead of base back"));

function profile() = [
    [front_x, 0],
    [front_x, lip_top],
    [x_at_z(lip_top, slot_t), lip_top],   // top of the front lip
    pt(0, slot_t),                        // front face of the slot
    pt(0, 0),                             // slot floor
    pt(back_h, 0),                        // back rest, slab side
    pt(back_h, -panel_t),                 // back rest top
    [x_at_z(floor_z + fillet, -panel_t), floor_z + fillet],  // back face of the plate
    [x_at_z(floor_z + fillet, -panel_t) + fillet, floor_z],  // fillet onto the base
    [back_x, floor_z],                    // base plate top
    [back_x, 0]
];

module xz_extrude(h) {
    translate([0, h, 0]) rotate([90, 0, 0]) linear_extrude(h) children();
}

module in_slab_frame() {
    translate([0, 0, floor_z]) rotate([0, lean, 0]) children();
}

// Opens the slot mouth by `ch` (front lip edge) and the back rest top edge.
module mouth_chamfer() {
    xz_extrude(width + 2) translate([0, 0]) polygon([
        [x_at_z(lip_top, slot_t) - ch, lip_top + 0.01],
        [x_at_z(lip_top, slot_t), lip_top - ch],
        [x_at_z(lip_top, slot_t) + 0.5, lip_top + 0.01]
    ]);
}

module stand() {
    difference() {
        xz_extrude(width) polygon(profile());
        translate([0, -1, 0]) mouth_chamfer();
    }
}

module slab_ghost() {
    in_slab_frame()
        translate([-slab_t, (width - slab_w) / 2, 0]) cube([slab_t, slab_w, slab_h]);
}

stand();
if (part == "check") %slab_ghost();
