// PCG graded card holder with removable lid - 20 slabs
// Derived from 20_cgc_slab_box, re-dimensioned for PCG slabs
// (measured: 7.5 x 80 x 135 mm) with "PCG" engraved on all four outer walls.
//
// The slabs stand on edge in 20 slots, guided by short side ribs. The lid
// slides over the top 7 mm of the holder and rests on the external lip.
//
// Export (combined STL = holder + lid side by side, print orientation):
//   "C:/Program Files/OpenSCAD/openscad.com" -o <abs>/20_pcg_slab_box.stl <abs>/20_pcg_slab_box.scad

render_mode = "print"; // "print", "holder", "lid", "assembled", or "section"

// --- PCG SLAB (measured) ---
slab_w = 80.0;
slab_t = 7.5;
slab_h = 135.0;

// --- SLOTS ---
clearance_w = 0.6;        // 0.3/side, same as the tested PSA box
clearance_t = 1.2;        // 0.6/side
slot_t = slab_t + clearance_t;
slot_depth = 100.0;
divider = 1.2;            // 1.6 on the PSA box; 1.2 (3 lines @ 0.4) keeps 20 slots within 210 mm
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
slab_top_gap = 3.0;       // clearance between slab top and lid ceiling
section_slab_h = slab_h;
lid_tol = 0.4;
lid_w = box_w + (lid_tol * 2) + (wall * 2);
lid_l = box_l + (lid_tol * 2) + (wall * 2);
lid_h = (wall + slab_h + slab_top_gap) - lip_seat_z + wall;

// --- ENGRAVE ---
engrave_text = "PCG";
engrave_font = "Liberation Sans:style=Bold";
engrave_size = 36;        // long walls
engrave_end_size = 24;    // short walls (front/back), ~55 mm wide on an 86.8 mm face
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

        // The cut overlaps the neighbouring slots by `eps`: with a 9.8 mm
        // pitch, float rounding left a zero-thickness wall at slot 14.
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
    linear_extrude(engrave_depth + 1)
        text(engrave_text, size=size, font=engrave_font,
             halign="center", valign="center");
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

module slab_proxy(i=9, proxy_h=slab_h) {
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
    section_slot = 9;
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
