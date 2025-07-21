include <BOSL2/std.scad>

// Size of shim obove table surface, in mm
space = 4.0; // [1:0.1:40]
// Length of dog below surface, excluding 1mm chamfer
dog_height = 18; // [12:1:25]

/* [Hidden ] */

epsilon=0.01;
$fn=100;
dog_diameter = 20.05;
dog_chamfer = 1;
text_depth = 0.4;

difference() {
    union() {
        up(space/2) cuboid([25, 25, space], chamfer=min(0.5, space/4));
        up(space) cylinder(h=dog_height, d=dog_diameter);
        up(dog_height+space) cylinder(h=dog_chamfer, d1 = dog_diameter, d2 = dog_diameter-2*dog_chamfer);
    }
    up(dog_height+space+dog_chamfer-text_depth+epsilon) linear_extrude(height=text_depth)
        text(str(space), size=5, halign="center", valign="center");
}