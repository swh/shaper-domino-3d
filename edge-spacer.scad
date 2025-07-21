include <tile-utils.scad>
include <tile-bits-4x10.scad>
include <BOSL2/std.scad>

TILE = [COLUMNS * DOMINO_X_SPACE, 1 * DOMINO_Y_SPACE, THICKNESS];

difference() {
    color(TILE_COLOR) translate([0, 0, THICKNESS/2]) cuboid(TILE, anchor=FRONT+LEFT);
    negative_x_dovetails(TILE.x, TILE.y);
}

union() {
    color(TILE_COLOR) rotate([180, 0, 0]) translate([0, 10, -THICKNESS]) {
        cuboid(TILE, chamfer=THICKNESS-1, edges=BOTTOM+BACK, anchor=BOTTOM+LEFT+FRONT);
        positive_x_dovetails(TILE.x, TILE.y);
    }
}