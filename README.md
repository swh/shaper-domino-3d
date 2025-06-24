# shaper-domino-3d

CAD files to create 3D printable tiles of dominos compatible with the Shaper Origin CNC machine.

To render a tile, open `domino-tiles.3mf` in OpenSCAD, edit the `TILE_NUM = `
line at the top, render (F6), and export to 3MF.

There are some example tiles in the models/ directory.

The SCAD files are:

* `domino-tiles.scad` - the main file to print tiles
* `tile-utils.scad` - some constants, maths and shapes that are common to multiple models
* `edge-spacer.scad` - dovetails into the top/bottom edge of the tiles, but give a bit more working room
* `spacer-dog.scad` - vertical spacer, designed to fit a MFT table - used to bring the tiles up to a level with your workpiece. Parametric.
* `tile-bits-4x10.scad` - raw data for the domino bitstrings, for 256x256mm build plates
* `tile-bits-5x13.scad` - row data for the domino bitstrings, for larger build plates (untested)
