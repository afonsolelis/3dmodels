// Collector's League order: GBA graded card holder with removable lid - 20 slabs
// IN SLEEVES. 20-slot version of organizadores_tcg/gba_slab_box/10pc, with
// sleeve_play extra on every slot side, and the Collector's League logo
// (logo_engrave.scad, generated from logo.png by logo_to_scad.py) engraved on
// all four outer walls instead of text.
//
// 20 slots is long (~203 mm): print with a brim, the 20-slot boxes warped before.
//
// The slabs stand on edge in 20 slots, guided by short side ribs. The lid
// slides over the top 7 mm of the holder and rests on the external lip.
//
// Export (combined STL = holder + lid side by side, print orientation):
//   "C:/Program Files/OpenSCAD/openscad.com" -o <abs>/collectors_league_gba_20_slab_box.stl <abs>/collectors_league_gba_20_slab_box.scad

include <logo_engrave.scad>

render_mode = "print"; // "print", "holder", "lid", "assembled", or "section"

// --- SLAB (GBA) ---
// Measured GBA slab (2026-11-01): 80 x 135 x 7.1 mm. slab_t gets +0.2 mm of
// margin, like the GRADD box (6.2 -> 6.4), since a tight first print jammed.
slab_w = 80.0;
slab_t = 7.3;
slab_h = 135.0;

// --- SLOTS ---
sleeve_play = 0.1;        // extra per side for the sleeve (asked by the user)
clearance_w = 1.3 + 2 * sleeve_play;  // 81.3 proven on the GRADD box, + sleeve
clearance_t = 1.2 + 2 * sleeve_play;  // 0.6/side, + sleeve
slot_t = slab_t + clearance_t;
slot_depth = 100.0;
divider = 1.2;            // 3 lines; thinner than the 10-slot box so the lid fits 210 mm
wall = 3.0;
slots = 20;
fn = 60;
tab_length = 8.0;

inner_l = (slot_t * slots) + (divider * (slots - 1));
box_w = (slab_w + clearance_w) + (wall * 2);
box_l = inner_l + (wall * 2);
box_h = slot_depth + wall;

// --- LIP ---
lip_projection = 1.8;
lid_overlap = 7.0;
lip_seat_z = box_h - lid_overlap;
lip_band_h = 1.2;
lip_chamfer_h = lip_projection; // approximately 45 degrees
lip_full_z = lip_seat_z - lip_band_h;
lip_start_z = lip_full_z - lip_chamfer_h;

// --- LID ---
slab_top_gap = 2.75;      // clearance above a 136.5 mm fit-check slab
section_slab_h = 136.5;   // the fit-check slab, used for the lid height
lid_tol = 0.4;
lid_w = box_w + (lid_tol * 2) + (wall * 2);
lid_l = box_l + (lid_tol * 2) + (wall * 2);
lid_h = (wall + section_slab_h + slab_top_gap) - lip_seat_z + wall; // = 49.25, as the original

// --- ENGRAVE (logo, diameter in mm) ---
engrave_size = 80;        // long walls (~203 mm face, ~93 mm tall below the lip)
engrave_end_size = 76;    // short walls (front/back), 87.5 mm face
engrave_depth = 0.8;      // leaves 2.2 mm of the 3 mm wall
engrave_z = lip_start_z / 2;

echo(str("slot_t=", slot_t, " inner_l=", inner_l));
echo(str("holder=", box_w, " x ", box_l, " x ", box_h,
         " (with lip ", box_w + lip_projection*2, " x ", box_l + lip_projection*2, ")"));
echo(str("lid=", lid_w, " x ", lid_l, " x ", lid_h));
echo(str("slab top z=", wall + slab_h, " lid ceiling z=", lip_seat_z + lid_h - wall));

module rounded_box_solid(w, l, h, r) {
    translate([r, r, 0])
    minkowski() {
        cube([w - r*2, l - r*2, h - 0.1]);
        cylinder(r=r, h=0.1, $fn=fn);
    }
}

module slotted_body() {
    difference() {
        rounded_box_solid(box_w, box_l, box_h, 3);

        for (i = [0 : slots - 1]) {
            translate([wall, wall + i * (slot_t + divider), wall])
                cube([slab_w + clearance_w, slot_t, slot_depth + 1]);
        }

        // The cut overlaps the neighbouring slots by `eps`: float rounding of
        // the pitch can leave a zero-thickness wall (it did on the CGC box).
        eps = 0.01;
        for (i = [0 : slots - 2]) {
            divider_y = wall + slot_t + i * (slot_t + divider);

            translate([wall + tab_length, divider_y - eps, wall])
                cube([(slab_w + clearance_w) - (tab_length * 2), divider + eps*2, slot_depth + 1]);
        }
    }
}

// Simple external ring with a short 45-degree underside transition.
module concept_lip() {
    difference() {
        union() {
            hull() {
                translate([0, 0, lip_start_z])
                    rounded_box_solid(box_w, box_l, 0.2, 3);

                translate([-lip_projection, -lip_projection, lip_full_z])
                    rounded_box_solid(
                        box_w + lip_projection*2,
                        box_l + lip_projection*2,
                        0.2,
                        3 + lip_projection
                    );
            }

            translate([-lip_projection, -lip_projection, lip_full_z])
                rounded_box_solid(
                    box_w + lip_projection*2,
                    box_l + lip_projection*2,
                    lip_band_h,
                    3 + lip_projection
                );
        }

        // Keep the added material at the exterior perimeter only.
        translate([0.1, 0.1, lip_start_z - 0.1])
            rounded_box_solid(
                box_w - 0.2,
                box_l - 0.2,
                lip_seat_z - lip_start_z + 0.3,
                2.9
            );
    }
}

module engrave_label(size) {
    linear_extrude(engrave_depth + 1) logo_2d(size);
}

// One label per wall, readable from outside.
module engraves() {
    translate([engrave_depth, box_l/2, engrave_z])
        rotate([90, 0, -90]) engrave_label(engrave_size);

    translate([box_w - engrave_depth, box_l/2, engrave_z])
        rotate([90, 0, 90]) engrave_label(engrave_size);

    translate([box_w/2, engrave_depth, engrave_z])
        rotate([90, 0, 0]) engrave_label(engrave_end_size);

    translate([box_w/2, box_l - engrave_depth, engrave_z])
        rotate([90, 0, 180]) engrave_label(engrave_end_size);
}

module holder() {
    difference() {
        union() {
            slotted_body();
            concept_lip();
        }
        engraves();
    }
}

module lid() {
    difference() {
        rounded_box_solid(lid_w, lid_l, lid_h, 4);

        translate([wall, wall, wall])
            rounded_box_solid(
                box_w + (lid_tol * 2),
                box_l + (lid_tol * 2),
                lid_h,
                3
            );
    }
}

module seated_lid() {
    translate([box_w/2, box_l/2, lip_seat_z + lid_h])
        rotate([180, 0, 0])
            translate([-lid_w/2, -lid_l/2, 0])
                lid();
}

module slab_proxy(i=19, proxy_h=slab_h) {
    translate([
        wall + clearance_w/2,
        wall + i*(slot_t + divider) + clearance_t/2,
        wall
    ])
        cube([slab_w, slab_t, proxy_h]);
}

// Lid centered on the holder's length so the pair stays within 210 mm in Y.
module print_layout() {
    holder();
    translate([box_w + 15, -(lid_l - box_l)/2, 0]) lid();
}

module assembled_view() {
    holder();
    seated_lid();
}

module section_view() {
    section_slot = 19;
    section_y = wall + section_slot*(slot_t + divider) + slot_t/2;
    section_thickness = 1.0;

    module slice() {
        translate([-10, section_y - section_thickness/2, -1])
            cube([box_w + 20, section_thickness, lip_seat_z + lid_h + 3]);
    }

    intersection() {
        holder();
        slice();
    }

    intersection() {
        seated_lid();
        slice();
    }

    intersection() {
        slab_proxy(section_slot, section_slab_h);
        slice();
    }
}

if (render_mode == "print") {
    print_layout();
} else if (render_mode == "holder") {
    holder();
} else if (render_mode == "lid") {
    lid();
} else if (render_mode == "assembled") {
    assembled_view();
} else if (render_mode == "section") {
    section_view();
}
