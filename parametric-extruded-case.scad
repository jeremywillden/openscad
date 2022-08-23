wall_thickness = 3;
edge_radius = 5;
box_height = 30;
box_width = 50;
box_length = 100;
corner_circle_div = 64;
slot_depth = 3;
slot_support_thickness = 2.5;
screw_inner_dia = 2;
screw_outer_dia = 4;

slot_heights_and_ypos = [
    [1.8, -5], [1.8, 5]
];

screw_hpos_and_ypos = [
    [-20, 10], [20, 10], [-20, -10], [20, -10]
];

module roundedRectangle(fullwidth,fullheight,zoffset,cornerradius) {
    width = abs(fullwidth) - 2*cornerradius;
    height = abs(fullheight) - 2*cornerradius;
    translate([0,0,zoffset])
    hull() {
        translate([-width/2,-height/2,0])
        circle(r=cornerradius,$fn=corner_circle_div);
        translate([width/2,-height/2,0])
        circle(r=cornerradius,$fn=corner_circle_div);
        translate([width/2,height/2,0])
        circle(r=cornerradius,$fn=corner_circle_div);
        translate([-width/2,height/2,0])
        circle(r=cornerradius,$fn=corner_circle_div);
    }
}

module roundedBox(fullwidth,fullheight,zoffset,cornerradius) {
    width = abs(fullwidth) - 2*cornerradius;
    height = abs(fullheight) - 2*cornerradius;
    translate([0,0,zoffset])
    hull() {
        translate([-width/2,-height/2,0])
        circle(r=cornerradius,$fn=corner_circle_div);
        translate([width/2,-height/2,0])
        circle(r=cornerradius,$fn=corner_circle_div);
        translate([width/2,height/2,0])
        circle(r=cornerradius,$fn=corner_circle_div);
        translate([-width/2,height/2,0])
        circle(r=cornerradius,$fn=corner_circle_div);
    }
}

module multiRods(rod_dia) {
    for (b = [ 0 : len(screw_hpos_and_ypos) - 1]) {
        screw = screw_hpos_and_ypos[b];
        translate([screw[0],screw[1]]) cylinder(h = box_length, r1 = rod_dia, r2 = rod_dia, center = true);
    }
}

module multiBoard() {
    for (a = [ 0 : len(slot_heights_and_ypos) - 1 ]) {
        board = slot_heights_and_ypos[a];
        translate([0,board[1],0]) cube(size=[box_width-2*wall_thickness, board[0], box_length], center=true);
    }
}

module multiBoardSupports() {
    for (a = [ 0 : len(slot_heights_and_ypos) - 1 ]) {
        board = slot_heights_and_ypos[a];
        translate([0,board[1],0]) cube(size=[box_width-2*wall_thickness, (board[0]+2*slot_support_thickness), box_length], center=true);
    }
}

difference() {
    linear_extrude(height = box_length, center = true) {
        roundedRectangle(box_width,box_height,(-0.5*box_length),edge_radius);
    }
    linear_extrude(height = box_length, center = true) { 
        roundedRectangle(box_width-2*wall_thickness,box_height-2*wall_thickness,(-0.5*box_length),edge_radius);
    }
}

difference() {
    difference() {
        multiBoardSupports();
        multiBoard();
    }
    cube(size=[box_width-2*wall_thickness-2*slot_depth, box_height, box_length], center=true);
}
difference() {
    multiRods(screw_outer_dia);
    multiRods(screw_inner_dia);
}


/*
hull() {
    translate([50,25,30])
    sphere(10);
    translate([25,30,10])
    cube(10);
}

    hull() {
      translate([0, 10])
      circle(10);
      translate([0, -10])
      circle(10);
    }
*/