// my second parametric OpenSCAD project, making a
// filter holder for a dust collection vacuum hose
// set the inlet and outlet diameters, use 45 degree slope
// to provide easy no-supports printing
render_filter_cube = false;
render_inlet = true;
render_outlet = true;
filter_length = 150.5;
filter_width = 101;
filter_thickness = 13;
wall_thickness = 5;
gap_for_filter_length = 1;
gap_for_filter_width = 1;
length_of_transition_on_inlet = 50; // non-zero or it won't render
length_of_transition_on_outlet = 50; // non-zero or it won't render
gap_between_input_and_output = 0.5;

inlet_outer_dia = 40.25;
inlet_inner_dia = 35.25;
inlet_length = 35;
outlet_outer_dia = 36.75;
outlet_inner_dia = 31.75;
outlet_length = 25;

inlet_outer_radius = inlet_outer_dia / 2.0;
inlet_inner_radius = inlet_inner_dia / 2.0;
outlet_outer_radius = outlet_outer_dia / 2.0;
outlet_inner_radius = outlet_inner_dia / 2.0;
// calculate the wall angle so it can be made thicker to compensate for the slope
filter_length_opening = filter_length + gap_for_filter_length;
filter_width_opening = filter_width + gap_for_filter_width;
inlet_surround_length = filter_length_opening + 2*wall_thickness;
inlet_surround_width = filter_width_opening + 2*wall_thickness;
inlet_surround_height = filter_thickness;
inlet_side_length = filter_length_opening + 2*wall_thickness;
inlet_side_width = filter_width_opening + 2*wall_thickness;
outlet_side_length = inlet_side_length + gap_between_input_and_output;
outlet_side_width = inlet_side_width + gap_between_input_and_output;
outlet_outside_length = outlet_side_length + 2*wall_thickness;
outlet_outside_width = outlet_side_width + 2*wall_thickness;
outlet_surround_height = filter_thickness;
// slope_ratio gives the z distance traveled for a given
// distance change in the x/y directions

if (render_filter_cube) {
    translate([-0.5*filter_length,-0.5*filter_width,-0.5*filter_thickness]) cube([filter_length,filter_width,filter_thickness]);
}

if (render_inlet) {
    // inlet
    translate([0, 0, (length_of_transition_on_inlet + filter_thickness/2)]) {
        difference() {
            cylinder(inlet_length, inlet_outer_radius, inlet_outer_radius);
            cylinder(inlet_length, inlet_inner_radius, inlet_inner_radius);
        }
    }
    // transition to filter
    translate([0,0,(filter_thickness/2)])
    difference() {
        hull() {
            translate([-0.5*inlet_side_length,-0.5*inlet_side_width,0]) cube([inlet_side_length,inlet_side_width,.1]);
            translate([0,0,length_of_transition_on_inlet]) cylinder(r=inlet_outer_radius,h=0.1);
        }
        hull() {
            translate([-0.5*filter_length_opening,-0.5*filter_width_opening,0]) cube([filter_length_opening,filter_width_opening,.1]);
            translate([0,0,length_of_transition_on_inlet]) cylinder(r=inlet_inner_radius,h=0.1);
        }
    }
    // surround the filter
    difference() {
        translate([-0.5*inlet_surround_length,-0.5*inlet_surround_width,-0.5*filter_thickness]) cube([inlet_surround_length,inlet_surround_width,inlet_surround_height]);
        translate([-0.5*filter_length,-0.5*filter_width,-0.5*filter_thickness]) cube([filter_length,filter_width,filter_thickness]);
    }
}

if (render_outlet) {
    translate([0, 0, 0]) {
        // outlet
        translate([0, 0, (-1.0 * (outlet_length+length_of_transition_on_outlet+0.5*filter_thickness))]) {
            difference() {
                cylinder(outlet_length, outlet_outer_radius, outlet_outer_radius);
                cylinder(outlet_length, outlet_inner_radius, outlet_inner_radius);
            }
        }    
        // transition to filter
        translate([0,0,(-1*filter_thickness/2)])
        difference() {
            hull() {
                translate([-0.5*outlet_outside_length,-0.5*outlet_outside_width,0]) cube([outlet_outside_length,outlet_outside_width,.1]);
                translate([0,0,-1*length_of_transition_on_outlet]) cylinder(r=outlet_outer_radius,h=0.1);
            }
            hull() {
                translate([-0.5*outlet_side_length,-0.5*outlet_side_width,0]) cube([outlet_side_length,outlet_side_width,.1]);
                translate([0,0,-1*length_of_transition_on_outlet]) cylinder(r=outlet_inner_radius,h=0.1);
            }
        }
        // surround the filter
        difference() {
            translate([-0.5*outlet_outside_length,-0.5*outlet_outside_width,-0.5*filter_thickness]) cube([outlet_outside_length,outlet_outside_width,outlet_surround_height]);
            translate([-0.5*outlet_side_length,-0.5*outlet_side_width,-0.5*filter_thickness]) cube([outlet_side_length,outlet_side_width,outlet_surround_height]);
        }
    }
}