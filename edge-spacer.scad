include <tile-utils.scad>
include <tile-bits-4x10.scad>

TILE = [COLUMNS * DOMINO_X_SPACE, 1 * DOMINO_Y_SPACE, THICKNESS];

difference() {
    color(TILE_COLOR) translate([0, 0, 0]) cube(TILE);
    negative_x_dovetails(TILE.x, TILE.y);
}

union() {
    color(TILE_COLOR) rotate([180, 0, 0]) translate([0, 50, 0]) {
        cube(TILE);
        positive_x_dovetails(TILE.x, TILE.y);
    }
}