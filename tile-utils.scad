inch = 25.4;
epsilon = 0.01;

LAYER = 0.2;    // mm
THICKNESS = 4;  // mm

PAINT_Z = LAYER*3;

DOMINO_X = 1.7 * inch;
DOMINO_Y = 0.5 * inch;
DOMINO_X_SPACE = 2.2 * inch;
DOMINO_Y_SPACE = 0.9 * inch;
DOMINO_X_PAD = (DOMINO_X_SPACE - DOMINO_X) / 2;
DOMINO_Y_PAD = (DOMINO_Y_SPACE - DOMINO_Y) / 2;
DOMINO_RADIUS = (1/16) * inch;

PIP_DIAM = 0.1 * inch;
PIP_X_PAD = 0.05 * inch;
PIP_Y_PAD = 0.05 * inch;
PIP_X_SPACE = 0.2 * inch;
PIP_Y_SPACE = 0.2 * inch;

TILE_COLOR = "#FFFFFF";
TILE_NEG_COLOR = "#AAAAAA";
DOMINO_COLOR = "#000000";

/* Dovetails */
DT_SIZE = 0.25 * inch;
DT_RADIUS = 0.0625 * inch;
DT_TAPER = 1.02;
DT_X_COUNT = 4;
DT_Y_COUNT = 5;


module negative_dovetails(x, y) {
    color(TILE_NEG_COLOR) {
        negative_x_dovetails(x, y);
        negative_y_dovetails(x, y);
    }
}

module negative_x_dovetails(x, y) {
    for (d = [0:DT_X_COUNT-1]) {
        translate([x/(DT_X_COUNT*2) + d * x/DT_X_COUNT, y, THICKNESS/2+epsilon]) rotate([0, 0, -90]) dovetail();
    }
}

module negative_y_dovetails(x, y) {
    for (d = [0:DT_Y_COUNT-1]) {
        translate([0, y/(DT_Y_COUNT*2) + d * y/DT_Y_COUNT, THICKNESS/2+epsilon]) dovetail();
    }
}

module positive_dovetails(x, y) {
    positive_x_dovetails(x, y);
    positive_y_dovetails(x, y);
}

module positive_x_dovetails(x, y) {
    for (d = [0:DT_X_COUNT-1]) {
        translate([x/(DT_X_COUNT*2) + d * x/DT_X_COUNT, 0, THICKNESS/2]) rotate([0, 0, -90]) dovetail();
    }
}

module positive_y_dovetails(x, y) {
    for (d = [0:DT_Y_COUNT-1]) {
        translate([x, y/(DT_Y_COUNT*2) + d * y/DT_Y_COUNT, THICKNESS/2]) dovetail();
    }
}


module dovetail() {
    color(TILE_COLOR) hull() {
        translate([0, DT_SIZE/2-DT_RADIUS, 0]) cylinder(h=THICKNESS/2, r1=DT_RADIUS*DT_TAPER, r2=DT_RADIUS);
        translate([DT_SIZE-DT_RADIUS, DT_SIZE-DT_RADIUS, 0]) cylinder(h=THICKNESS/2, r1=DT_RADIUS*DT_TAPER, r2=DT_RADIUS);
        translate([DT_SIZE-DT_RADIUS, -(DT_SIZE-DT_RADIUS), 0]) cylinder(h=THICKNESS/2, r1=DT_RADIUS*DT_TAPER, r2=DT_RADIUS);
        translate([0, -(DT_SIZE/2-DT_RADIUS), 0]) cylinder(h=THICKNESS/2, r1=DT_RADIUS*DT_TAPER, r2=DT_RADIUS);
    }
}

/* Old versions of OpenSCAD don't have bitwise &, so this is a hacky alternative */
function bitstring(x, bits) =
    bits == 1 ? x % 2 == 1 : (concat(x % 2 == 1, bitstring(floor(x/2), bits-1)));
