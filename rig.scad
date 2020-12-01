
// https://www.diy.com/departments/round-edge-spruce-c16-cls-timber-l-2-4m-w-63mm-t-38mm-pack-of-8/492781_BQ.prd
STRUT_WIDTH=38;
STRUT_HEIGHT=63;

RIG_WIDTH=500; // this is the width of space under the wheel base

BASE_WIDTH=RIG_WIDTH - (STRUT_WIDTH * 2);

RIG_LENGTH=1500; // base length

SEAT_ANGLE = 13;

SEAT_REAR_HOLE_DISTANCE = 100; // from rear of seat to reat mounting holes
SEAT_HOLE_DISTANCE = 330; // between rear and front seat mounting holes

SEAT_REAR_HEIGHT = 320;
SEAT_FRONT_HEIGHT = SEAT_REAR_HEIGHT + (sin(SEAT_ANGLE) * SEAT_HOLE_DISTANCE);

WHEEL_MOUNT_REAR_HEIGHT = 500 + 250;
WHEEL_MOUNT_FRONT_HEIGHT = 480 + 250;

WHEEL_BASE_DEPTH = 150;
WHEEL_BASE_WIDTH = 280;
WHEEL_BASE_HEIGHT = 120;

WHEEL_DIAMETER = 280;
WHEEL_DEPTH = 35;
WHEEL_TO_BASE = 50;

// 220 - initial distance from front seat bolts to front wheel mount
// 800 - distance from front seat bolts to pedal face
// 

TV_WIDTH = 915;
TV_HEIGHT = 530;
TV_DEPTH = 80;

module strut(length=1000) {

    // extrude the profile
    translate([0, 0, STRUT_HEIGHT])
    rotate([0, 90, 0])
    linear_extrude(length)
    offset(r = 2)
    offset(delta = -2)
    square([STRUT_HEIGHT, STRUT_WIDTH]);

}


module seat_mount() {

    // rear support
    translate([SEAT_REAR_HOLE_DISTANCE, STRUT_WIDTH, SEAT_REAR_HEIGHT])
    rotate([0, 90, 0])
    strut(SEAT_REAR_HEIGHT);

    translate([SEAT_REAR_HOLE_DISTANCE, BASE_WIDTH, SEAT_REAR_HEIGHT])
    rotate([0, 90 ,0])
    strut(SEAT_REAR_HEIGHT);

    // front support
    translate([SEAT_REAR_HOLE_DISTANCE + SEAT_HOLE_DISTANCE, STRUT_WIDTH, SEAT_FRONT_HEIGHT])
    rotate([0, 90, 0])
    strut(SEAT_FRONT_HEIGHT);

    translate([SEAT_REAR_HOLE_DISTANCE + SEAT_HOLE_DISTANCE, BASE_WIDTH, SEAT_FRONT_HEIGHT])
    rotate([0, 90 ,0])
    strut(SEAT_FRONT_HEIGHT);

}

module seat_base() {
    translate([0, BASE_WIDTH + STRUT_WIDTH, 0])
    strut(RIG_LENGTH);
    strut(RIG_LENGTH);

    translate([STRUT_WIDTH, STRUT_WIDTH, 0])
    rotate([0, 0, 90])
    strut(BASE_WIDTH);

    translate([RIG_LENGTH / 2, STRUT_WIDTH, 0])
    rotate([0, 0, 90])
    strut(BASE_WIDTH);

    translate([RIG_LENGTH, STRUT_WIDTH, 0])
    rotate([0, 0, 90])
    strut(BASE_WIDTH);
}


seat_base();
seat_mount();

