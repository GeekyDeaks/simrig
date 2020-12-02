
// https://www.diy.com/departments/round-edge-spruce-c16-cls-timber-l-2-4m-w-63mm-t-38mm-pack-of-8/492781_BQ.prd
STRUT_WIDTH=38;
STRUT_HEIGHT=63;

RIG_WIDTH=500; // this is the width of space under the wheel base

BASE_WIDTH=RIG_WIDTH - (STRUT_WIDTH * 2);

//RIG_LENGTH=1500; // base length
RIG_FRONT_LENGTH=1000;
RIG_REAR_LENGTH=600;
RIG_LENGTH = RIG_FRONT_LENGTH + RIG_REAR_LENGTH;


SEAT_WIDTH = 400;
SEAT_LENGTH = 480;
SEAT_DEPTH = 20;
BACKREST_WIDTH = SEAT_WIDTH;
BACKREST_LENGTH = 700;
BACKREST_DEPTH = 20;
BACKREST_ANGLE = 100;

SEAT_ANGLE = 13;

//SEAT_REAR_HOLE_DISTANCE = 100; // from rear of seat to reat mounting holes
SEAT_HOLE_DISTANCE = 330; // between rear and front seat mounting holes
SEAT_FRONT_HOLE_DISTANCE = -130; // initial distance from front seat bolts to wheel (centre)

SEAT_REAR_HEIGHT = 320;
SEAT_FRONT_HEIGHT = SEAT_REAR_HEIGHT + (sin(SEAT_ANGLE) * SEAT_HOLE_DISTANCE);

MAIN_SUPPORT_HEIGHT = 750;
MAIN_SUPPORT_DEPTH = 250;
MAIN_SUPPORT_OFFSET = 90; // how far from the middle if the rig
MAIN_SUPPORT_FRONT_LOWER_OFFSET = 200; // how far the front lower supports are towards the pedals
MAIN_SUPPORT_REAR_LOWER_OFFSET = 400; // how far the rear lower supports are towards the pedals

WHEEL_BASE_ANGLE = 8;
WHEEL_BASE_DEPTH = 150;
WHEEL_BASE_WIDTH = 280;
WHEEL_BASE_HEIGHT = 120;
WHEEL_BASE_FRONT_DEPTH = 35; // amount the wheel base extends beyond the front mounts 

WHEEL_DIAMETER = 280;
WHEEL_DEPTH = 35;
WHEEL_TO_BASE = 50;


WHEEL_MOUNT_FRONT_DISTANCE = 90;
WHEEL_MOUNT_FRONT_ANGLE = 20;
WHEEL_MOUNT_FRONT_HEIGHT = 480 + 250;
WHEEL_MOUNT_FRONT_LENGTH = WHEEL_MOUNT_FRONT_HEIGHT / cos(WHEEL_MOUNT_FRONT_ANGLE);
WHEEL_MOUNT_FRONT_BOTTOM = WHEEL_MOUNT_FRONT_DISTANCE + (WHEEL_MOUNT_FRONT_HEIGHT * sin(WHEEL_MOUNT_FRONT_ANGLE));

WHEEL_MOUNT_REAR_ANGLE = 40;
WHEEL_MOUNT_REAR_HEIGHT =  WHEEL_MOUNT_FRONT_HEIGHT + (sin(WHEEL_BASE_ANGLE) * WHEEL_BASE_DEPTH);
WHEEL_MOUNT_REAR_LENGTH = WHEEL_MOUNT_REAR_HEIGHT / cos(WHEEL_MOUNT_REAR_ANGLE);
WHEEL_MOUNT_REAR_BOTTOM = WHEEL_MOUNT_FRONT_DISTANCE + WHEEL_BASE_DEPTH + (WHEEL_MOUNT_REAR_HEIGHT * cos(WHEEL_MOUNT_REAR_ANGLE));


WHEEL_HEIGHT = WHEEL_MOUNT_FRONT_HEIGHT + (WHEEL_BASE_HEIGHT / 2);

// 220 - initial distance from front seat bolts to front wheel mount
// 
// 800 - distance from front seat bolts to pedal face
// 640000 - 62500 = 57700

PEDAL_FACE_POSITION = 630;
PEDAL_FACE_OFFSET = 130; // middle of pedal above the pivot point
PEDAL_PIVOT_OFFSET = 50; // distance to pedal pivot from front of pedal
PEDAL_FACE_HEIGHT = 100; 
PEDAL_FACE_WIDTH = 50;
PEDAL_FACE_ANGLE = 64;

PEDAL_BOX_ANGLE = 60;
PEDAL_BOX_DEPTH = 400;
PEDAL_BOX_HEIGHT = 350;
PEDAL_BOX_POSITION = 450;
PEDAL_BOX_THICKNESS = 20;

PEDAL_BOX_WIDTH = RIG_WIDTH - (STRUT_WIDTH * 2);


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

module rounded_strut(length=1000) {

    translate([-length / 2 + STRUT_HEIGHT / 2, 0, 0])
    rotate([90, 0, 0])
    cylinder(d=STRUT_HEIGHT, h=STRUT_WIDTH, center=true);
    strut(length - STRUT_HEIGHT);
    translate([length /2 - STRUT_HEIGHT / 2, 0, 0])
    rotate([90, 0, 0])
    cylinder(d=STRUT_HEIGHT, h=STRUT_WIDTH, center=true);

}


module seat_mount() {

    // front support
    translate([SEAT_FRONT_HOLE_DISTANCE, BASE_WIDTH / 2 - STRUT_WIDTH / 2, - STRUT_HEIGHT / 2])
    rotate([0, -90, 0])
    translate([SEAT_FRONT_HEIGHT / 2, 0, 0])
    rounded_strut(SEAT_FRONT_HEIGHT);

    translate([SEAT_FRONT_HOLE_DISTANCE, - BASE_WIDTH / 2 + STRUT_WIDTH / 2, - STRUT_HEIGHT / 2])
    rotate([0, -90 ,0])
    translate([SEAT_FRONT_HEIGHT / 2, 0, 0])
    rounded_strut(SEAT_FRONT_HEIGHT);

    // rear support
    translate([SEAT_FRONT_HOLE_DISTANCE - SEAT_HOLE_DISTANCE, BASE_WIDTH / 2 - STRUT_WIDTH / 2, - STRUT_HEIGHT / 2])
    rotate([0, -90, 0])
    translate([SEAT_REAR_HEIGHT / 2, 0, 0])
    rounded_strut(SEAT_REAR_HEIGHT);

    translate([SEAT_FRONT_HOLE_DISTANCE - SEAT_HOLE_DISTANCE, -BASE_WIDTH / 2 +  STRUT_WIDTH / 2, - STRUT_HEIGHT / 2])
    rotate([0, -90 ,0])
    translate([SEAT_REAR_HEIGHT / 2, 0, 0])
    rounded_strut(SEAT_REAR_HEIGHT);

}

module rig_base() {
    mid = (RIG_FRONT_LENGTH - RIG_REAR_LENGTH) / 2;
    translate([mid, BASE_WIDTH / 2 + STRUT_WIDTH / 2, 0])
    strut(RIG_LENGTH);
    translate([mid, - BASE_WIDTH / 2 - STRUT_WIDTH / 2, 0])
    strut(RIG_LENGTH);

    translate([mid, 0, 0])
    rotate([0, 0, 90])
    strut(BASE_WIDTH);

    translate([RIG_FRONT_LENGTH - STRUT_WIDTH / 2, 0, 0])
    rotate([0, 0, 90])
    strut(BASE_WIDTH);

    translate([-RIG_REAR_LENGTH + STRUT_WIDTH / 2, 0, 0])
    rotate([0, 0, 90])
    strut(BASE_WIDTH);
}

module wheel_base() {

    //rotate([0, 90, 0])
    //cylinder(d=WHEEL_DIAMETER, h=WHEEL_DEPTH);
    translate([0, 0, WHEEL_HEIGHT])
    rotate([0, -90 + WHEEL_BASE_ANGLE, 0])
    rotate_extrude(angle = 360)
    translate([WHEEL_DIAMETER / 2, 0, 0])
    circle(r = WHEEL_DEPTH / 2);

    translate([WHEEL_TO_BASE, 0, WHEEL_MOUNT_FRONT_HEIGHT + WHEEL_BASE_HEIGHT / 2])
    rotate([0, -WHEEL_BASE_ANGLE, 0]) {
        translate([WHEEL_BASE_DEPTH / 2, 0, 0])
        cube([WHEEL_BASE_DEPTH, WHEEL_BASE_WIDTH, WHEEL_BASE_HEIGHT], center = true);
        rotate([90, 0, 0])
        linear_extrude(WHEEL_BASE_WIDTH, center = true)
        polygon([ [0,-WHEEL_BASE_HEIGHT / 2], [-WHEEL_BASE_FRONT_DEPTH, -WHEEL_BASE_HEIGHT / 2], [0, WHEEL_BASE_HEIGHT /2]]);
    }
    


}

module tv() {
    translate([TV_POSITION, 0, WHEEL_MOUNT_REAR_HEIGHT + TV_HEIGHT / 2])
    cube([TV_DEPTH, TV_WIDTH, TV_HEIGHT], center=true);
}

module seat() {
    translate([- SEAT_LENGTH  , 0, SEAT_REAR_HEIGHT]) {
        rotate([0, -SEAT_ANGLE, 0 ])
        translate([SEAT_LENGTH / 2, 0 ,0])
        cube([SEAT_LENGTH, SEAT_WIDTH, SEAT_DEPTH], center = true);

        rotate([0, -SEAT_ANGLE - BACKREST_ANGLE, 0])
        translate([BACKREST_LENGTH / 2, 0 ,0])
        cube([BACKREST_LENGTH, BACKREST_WIDTH, BACKREST_DEPTH], center= true);
    }

}

module pedal() {

    rotate([0, - (180 - PEDAL_FACE_ANGLE), 0]) {
        translate([PEDAL_FACE_OFFSET, 0 ,0]) 
        cube([PEDAL_FACE_HEIGHT, PEDAL_FACE_WIDTH, 5], center = true);
        translate([PEDAL_FACE_OFFSET / 2, 0, 5])
        cube([PEDAL_FACE_OFFSET, 10, 5], center=true);
    }

}

module pedal_box() {

    translate([PEDAL_BOX_POSITION, 0, STRUT_HEIGHT/2 + PEDAL_BOX_THICKNESS / 2]) {

        translate([PEDAL_BOX_DEPTH / 2, 0, 0])
        cube([PEDAL_BOX_DEPTH, PEDAL_BOX_WIDTH , PEDAL_BOX_THICKNESS], center = true);
        
        // upper part of pedal box
        translate([PEDAL_BOX_DEPTH, 0, 0])
        rotate([0, - (180 - PEDAL_BOX_ANGLE), 0]) {
            translate([PEDAL_BOX_HEIGHT / 2, 0, 0]) {
                cube([PEDAL_BOX_HEIGHT, PEDAL_BOX_WIDTH, PEDAL_BOX_THICKNESS], center = true);
                translate([PEDAL_BOX_HEIGHT / 2 - PEDAL_PIVOT_OFFSET, 0, 0])
                pedal();
                translate([PEDAL_BOX_HEIGHT / 2 - PEDAL_PIVOT_OFFSET, PEDAL_BOX_WIDTH / 3, 0])
                pedal();
                translate([PEDAL_BOX_HEIGHT / 2 - PEDAL_PIVOT_OFFSET, - PEDAL_BOX_WIDTH / 3, 0])
                pedal();
            }
            
        }

    }
    
}

module main_support() {

    // front supports
    front_length = sqrt(pow(MAIN_SUPPORT_FRONT_LOWER_OFFSET, 2) + pow(MAIN_SUPPORT_HEIGHT, 2));
    front_angle = atan(MAIN_SUPPORT_FRONT_LOWER_OFFSET / MAIN_SUPPORT_HEIGHT);

    front_offset = MAIN_SUPPORT_OFFSET + MAIN_SUPPORT_FRONT_LOWER_OFFSET;
    width_offset = RIG_WIDTH / 2 + STRUT_WIDTH / 2;
    
    translate([front_offset, -width_offset, - STRUT_HEIGHT / 2])
    rotate([0, -90 - front_angle, 0])
    translate([MAIN_SUPPORT_HEIGHT/2, 0, 0])
    rounded_strut(front_length);

    translate([front_offset, width_offset, - STRUT_HEIGHT / 2])
    rotate([0, -90 - front_angle, 0])
    translate([front_length/2, 0, 0])
    rounded_strut(front_length);

    // rear supports
    rear_length = sqrt(pow(MAIN_SUPPORT_REAR_LOWER_OFFSET, 2) + pow(MAIN_SUPPORT_HEIGHT, 2));
    rear_angle = atan(MAIN_SUPPORT_REAR_LOWER_OFFSET / MAIN_SUPPORT_HEIGHT);
    rear_offset = MAIN_SUPPORT_OFFSET + MAIN_SUPPORT_DEPTH + MAIN_SUPPORT_REAR_LOWER_OFFSET;

    translate([rear_offset, width_offset, - STRUT_HEIGHT / 2])
    rotate([0, -90 - rear_angle, 0])
    translate([rear_length/2, 0, 0])
    rounded_strut(rear_length);

    translate([rear_offset, -width_offset, - STRUT_HEIGHT / 2])
    rotate([0, -90 - rear_angle, 0])
    translate([rear_length/2, 0, 0])
    rounded_strut(rear_length);

    // 
    translate([MAIN_SUPPORT_OFFSET + MAIN_SUPPORT_DEPTH / 2, -width_offset + STRUT_WIDTH, MAIN_SUPPORT_HEIGHT - STRUT_HEIGHT])
    rotate([0, -WHEEL_BASE_ANGLE, 0])
    rounded_strut(MAIN_SUPPORT_DEPTH + STRUT_WIDTH);

    translate([MAIN_SUPPORT_OFFSET + MAIN_SUPPORT_DEPTH / 2, +width_offset - STRUT_WIDTH, MAIN_SUPPORT_HEIGHT - STRUT_HEIGHT])
    rotate([0, -WHEEL_BASE_ANGLE, 0])
    rounded_strut(MAIN_SUPPORT_DEPTH + STRUT_WIDTH);

    translate([MAIN_SUPPORT_OFFSET + WHEEL_BASE_DEPTH / 2, 0, MAIN_SUPPORT_HEIGHT - STRUT_HEIGHT / 2])
    rotate([0, -WHEEL_BASE_ANGLE, 0])
    cube([WHEEL_BASE_DEPTH, RIG_WIDTH, 20], center=true);

}


rig_base();
seat_mount();
tv();
wheel_base();
seat();
main_support();
pedal_box();

