TILE_NUM = 4;

/* [Hidden] */

include <tile-utils.scad>
include <tile-bits-4x10.scad>

$fn = 100;

assert(TILE_NUM > 0 && TILE_NUM <= len(TILE_BITS), str("Tile number must be between 1 and ", len(TILE_BITS)));

tile_bits = TILE_BITS[TILE_NUM-1];

TILE = [COLUMNS * DOMINO_X_SPACE, ROWS * DOMINO_Y_SPACE, THICKNESS];
echo(str("Tile dimenstions: ", TILE));

center = [-TILE.x/2, TILE.y/2-20, THICKNESS];
dominos_up = [180, 0, 0];
        
translate(center) rotate(dominos_up)        
    union() {
        // Body of tile, with negative dovetails removed
        difference() {
            color(TILE_COLOR) translate([0, 0, 0]) cube(TILE);
            
            negative_dovetails(TILE.x, TILE.y);
            
            // Marker so we know which tile this is
            color(TILE_NEG_COLOR) translate([20, TILE.y-30, THICKNESS-LAYER*5+epsilon])
                linear_extrude(LAYER*5+epsilon) text(str("Tile ", TILE_NUM), size=10);
        }

        positive_dovetails(TILE.x, TILE.y);

        // Add pips for dominos
        for (c = [0:COLUMNS-1]) {
            for (r = [0:ROWS-1]) {
                translate([DOMINO_X_SPACE * c, DOMINO_Y_SPACE * r, 0]) domino_pips(tile_bits[c + r*COLUMNS]);
            }
        }
    }

translate(center)  rotate(dominos_up)
    difference() {
        // Add black parts of dominos
        union() {
            for (c = [0:COLUMNS-1]) {
                for (r = [0:ROWS-1]) {
                    translate([DOMINO_X_SPACE * c, DOMINO_Y_SPACE * r, 0]) domino_outline(offset = -epsilon);
                }
            }
        }
        // Subtract space for pips
        for (c = [0:COLUMNS-1]) {
            for (r = [0:ROWS-1]) {
                translate([DOMINO_X_SPACE * c, DOMINO_Y_SPACE * r, -epsilon*2]) domino_pips(tile_bits[c + r*COLUMNS]);
            }
        }
    }

module domino_outline(offset = 0) {
    color(DOMINO_COLOR) translate([DOMINO_X_PAD, DOMINO_Y_PAD, offset - PAINT_Z]) {
        hull() {
            translate([DOMINO_RADIUS, DOMINO_RADIUS, PAINT_Z]) cylinder(PAINT_Z, r = DOMINO_RADIUS, center = false);
            translate([DOMINO_X - DOMINO_RADIUS, DOMINO_RADIUS, PAINT_Z]) cylinder(PAINT_Z, r = DOMINO_RADIUS, center = false);
            translate([DOMINO_RADIUS, DOMINO_Y - DOMINO_RADIUS, PAINT_Z]) cylinder(PAINT_Z, r = DOMINO_RADIUS, center = false);
            translate([DOMINO_X - DOMINO_RADIUS, DOMINO_Y - DOMINO_RADIUS, PAINT_Z]) cylinder(PAINT_Z, r = DOMINO_RADIUS, center = false);
        }
    }
}

module domino_pips(d_bits) {
        color("#FFFFFF") {
            bits = bitstring(d_bits, 12);
            pips = concat(true, [ for (i = [0:5]) bits[i] ], true);
            draw_pips(DOMINO_X_PAD + PIP_X_PAD + PIP_X_SPACE/2, DOMINO_Y_PAD + PIP_Y_PAD + PIP_Y_SPACE/2, pips, -2*epsilon);
            pips2 = concat(true, [ for (i = [6:11]) bits[i] ], true);
            draw_pips(DOMINO_X_PAD + PIP_X_PAD + PIP_X_SPACE/2, DOMINO_Y_PAD*2 + PIP_Y_PAD + PIP_Y_SPACE/2, pips2, -2*epsilon);
        }
}

module draw_pips(x, y, pips, offset=0) {
    for (i = [0:len(pips)-1]) {
        draw = pips[i];
        if (draw) {
            translate([x + PIP_X_SPACE*i, y, offset]) cylinder(h = PAINT_Z, d = PIP_DIAM, center = false);
        }
    }
}

