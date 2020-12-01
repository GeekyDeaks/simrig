
// https://www.diy.com/departments/round-edge-spruce-c16-cls-timber-l-2-4m-w-63mm-t-38mm-pack-of-8/492781_BQ.prd
STRUT_WIDTH=38;
STRUT_HEIGHT=63;

RIG_WIDTH=500; // this is the width of space under the wheel base

BASE_WIDTH=RIG_WIDTH - (STRUT_WIDTH * 2);

RIG_LENGTH=1500; // base length


SEAT_WIDTH = 480;
SEAT_LENGTH = 480;
SEAT_DEPTH = 20;
BACKREST_WIDTH = SEAT_WIDTH;
BACKREST_LENGTH = 600;
BACKREST_DEPTH = 20;


SEAT_ANGLE = 13;

//SEAT_REAR_HOLE_DISTANCE = 100; // from rear of seat to reat mounting holes
SEAT_HOLE_DISTANCE = 330; // between rear and front seat mounting holes
SEAT_FRONT_HOLE_DISTANCE = -190; // initial distance from front seat bolts to wheel (centre)

SEAT_REAR_HEIGHT = 320;
SEAT_FRONT_HEIGHT = SEAT_REAR_HEIGHT + (sin(SEAT_ANGLE) * SEAT_HOLE_DISTANCE);

WHEEL_BASE_ANGLE = 8;
WHEEL_BASE_DEPTH = 150;
WHEEL_BASE_WIDTH = 280;
WHEEL_BASE_HEIGHT = 120;

WHEEL_DIAMETER = 280;
WHEEL_DEPTH = 35;
WHEEL_TO_BASE = 50;

WHEEL_MOUNT_FRONT_DISTANCE = 90;
WHEEL_MOUNT_FRONT_HEIGHT = 480 + 250;
WHEEL_MOUNT_REAR_HEIGHT =  WHEEL_MOUNT_FRONT_HEIGHT + (sin(WHEEL_BASE_ANGLE) * WHEEL_BASE_DEPTH);
WHEEL_HEIGHT = WHEEL_MOUNT_FRONT_HEIGHT + (WHEEL_BASE_HEIGHT / 2);

// 220 - initial distance from front seat bolts to front wheel mount
// 
// 800 - distance from front seat bolts to pedal face
// 

TV_WIDTH = 915;
TV_HEIGHT = 530;
TV_DEPTH = 80;

TV_POSITION = WHEEL_DEPTH / 2 + WHEEL_TO_BASE + WHEEL_BASE_DEPTH + TV_DEPTH / 2;

module strut(length=1000) {

    // extrude the profile
    rotate([0, 90, 0])
    linear_extrude(length, center=true)
    offset(r = 2)
    offset(delta = -2)
    square([STRUT_HEIGHT, STRUT_WIDTH], center=true);

}


module seat_mount() {

    // front support
    translate([SEAT_FRONT_HOLE_DISTANCE, BASE_WIDTH / 2, - STRUT_HEIGHT / 2])
    rotate([0, -90, 0])
    translate([SEAT_FRONT_HEIGHT / 2, 0, 0])
    strut(SEAT_FRONT_HEIGHT);

    translate([SEAT_FRONT_HOLE_DISTANCE, - BASE_WIDTH / 2, - STRUT_HEIGHT / 2])
    rotate([0, -90 ,0])
    translate([SEAT_FRONT_HEIGHT / 2, 0, 0])
    strut(SEAT_FRONT_HEIGHT);

    // rear support
    translate([SEAT_FRONT_HOLE_DISTANCE - SEAT_HOLE_DISTANCE, BASE_WIDTH / 2, - STRUT_HEIGHT / 2])
    rotate([0, -90, 0])
    translate([SEAT_REAR_HEIGHT / 2, 0, 0])
    strut(SEAT_REAR_HEIGHT);

    translate([SEAT_FRONT_HOLE_DISTANCE - SEAT_HOLE_DISTANCE, -BASE_WIDTH / 2, - STRUT_HEIGHT / 2])
    rotate([0, -90 ,0])
    translate([SEAT_REAR_HEIGHT / 2, 0, 0])
    strut(SEAT_REAR_HEIGHT);

}

module seat_base() {
    translate([0, BASE_WIDTH / 2 + STRUT_WIDTH / 2, 0])
    strut(RIG_LENGTH);
    translate([0, - BASE_WIDTH / 2 - STRUT_WIDTH / 2, 0])
    strut(RIG_LENGTH);

    translate([0, 0, 0])
    rotate([0, 0, 90])
    strut(BASE_WIDTH);

    translate([RIG_LENGTH / 2 - STRUT_WIDTH / 2, 0, 0])
    rotate([0, 0, 90])
    strut(BASE_WIDTH);

    translate([-RIG_LENGTH / 2 + STRUT_WIDTH / 2, 0, 0])
    rotate([0, 0, 90])
    strut(BASE_WIDTH);
}

module wheel_base() {

    //rotate([0, 90, 0])
    //cylinder(d=WHEEL_DIAMETER, h=WHEEL_DEPTH);
    translate([0, 0, WHEEL_HEIGHT])
    rotate([0, 90, 0])
    rotate_extrude(angle = 360)
    translate([WHEEL_DIAMETER / 2, 0, 0])
    circle(r = WHEEL_DEPTH / 2);

    translate([WHEEL_TO_BASE + WHEEL_BASE_DEPTH / 2, 0, WHEEL_MOUNT_FRONT_HEIGHT + WHEEL_BASE_HEIGHT / 2])
    rotate([0, -WHEEL_BASE_ANGLE, 0])
    cube([WHEEL_BASE_DEPTH, WHEEL_BASE_WIDTH, WHEEL_BASE_HEIGHT], center = true);


}

module tv() {
    translate([TV_POSITION, 0, WHEEL_MOUNT_REAR_HEIGHT + TV_HEIGHT / 2])
    cube([TV_DEPTH, TV_WIDTH, TV_HEIGHT], center=true);
}

module seat() {
    translate([-SEAT_FRONT_HOLE_DISTANCE - SEAT_LENGTH  - SEAT_HOLE_DISTANCE, 0, SEAT_REAR_HEIGHT]) {
        rotate([0, -SEAT_ANGLE, 0 ])
        translate([SEAT_LENGTH / 2, 0 ,0])
        cube([SEAT_LENGTH, SEAT_WIDTH, SEAT_DEPTH], center = true);

        rotate([0, -SEAT_ANGLE - 100, 0])
        translate([BACKREST_LENGTH / 2, 0 ,0])
        cube([BACKREST_LENGTH, BACKREST_WIDTH, BACKREST_DEPTH], center= true);
    }

}

module wheel_mount() {

    translate([ WHEEL_MOUNT_FRONT_DISTANCE, RIG_WIDTH / 2 + STRUT_WIDTH / 2, - STRUT_HEIGHT / 2])
    rotate([0, -90, 0])
    translate([WHEEL_MOUNT_FRONT_HEIGHT/2, 0, 0])
    strut(WHEEL_MOUNT_FRONT_HEIGHT);

    translate([ WHEEL_MOUNT_FRONT_DISTANCE, -RIG_WIDTH / 2 - STRUT_WIDTH / 2, - STRUT_HEIGHT / 2])
    rotate([0, -90, 0])
    translate([WHEEL_MOUNT_FRONT_HEIGHT/2, 0, 0])
    strut(WHEEL_MOUNT_FRONT_HEIGHT);

}


seat_base();
seat_mount();
tv();
wheel_base();
seat();
wheel_mount();

