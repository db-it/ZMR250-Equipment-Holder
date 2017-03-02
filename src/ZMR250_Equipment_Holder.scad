module holderPart(holderLength) {
    holderHeight = 7;
    /* Distanz von Lochmittelpunkt zur geraden Kante
     * = translationY + cubeY
     */
    difference() {
        hull() {
            cylinder(h = holderHeight, d = 9.0);
            translate([-4.5, 3 + holderLength, 0]) cube([9, 0.1, holderHeight]);
        }
        cylinder(h = holderHeight, d = 5.6); // Loch
    }
}

module basePlate(basePlateHoleWidth, basePlateHoleDepth, basePlateHoleHeight) {
    difference() {
        cube([basePlateLength, basePlateDepth, basePlateHeight]);
        // connectorSpace
        translate([0, 2, 1]) cube([(basePlateLength - basePlateHoleWidth) / 2, 22, basePlateHoleHeight]);
    }
}

module strapHolder() {
    length = 5;
    depth = 3;
    height = 3;
    cube([length, 1, height]);
    translate([0, 1, height-1]) cube([length, depth, 1]);
    translate([0, depth, height-2]) cube([length, 1, 1]);
}

module main() {
    basePlateAlignY = 4;
    basePlateHoleWidth = 49.0;
    basePlateHoleDepth = 24.0;
    basePlateHoleHeight = 6;
    difference() {
        union() {
            translate([0, basePlateAlignY, 0]) basePlate(basePlateHoleWidth, basePlateHoleDepth, basePlateHoleHeight);
            
            // mid-back left
            translate([4.5, 0, 0]) holderPart(holderLengthFront);
            // mid-back right
            translate([4.5, innerSpacerBoltDistance, 0]) rotate(180) holderPart(holderLengthFront);

            // back left
            translate([56.1, innerToOuterSpacerBoltPositionDifferenceY, 0]) holderPart(holderLengthBack);
            // back right
            translate([56.2, outerSpacerBoltDistance + innerToOuterSpacerBoltPositionDifferenceY, 0]) rotate(180) holderPart(holderLengthBack);
        }
        translate([(basePlateLength - basePlateHoleWidth) / 2, basePlateAlignY + 1, 1]) {
            cube([basePlateHoleWidth, basePlateHoleDepth, basePlateHoleHeight]);
        }
    }
    translate([32.5, 4, 3]) rotate(180) strapHolder();
    translate([28.5, 30, 3]) strapHolder();
}

basePlateLength = 60.7;
basePlateDepth = 26.0;
basePlateHeight = 7;

innerSpacerBoltDistance = 34;
outerSpacerBoltDistance = 31.6;
innerToOuterSpacerBoltPositionDifferenceY = 1.225;

holderLengthFront = 1.3;
holderLengthBack = 0.8;

main();
