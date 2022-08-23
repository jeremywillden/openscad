// my first parametric OpenSCAD project, making couplers
// for a dust collection vacuum hose
// set the inlet and outlet diameters, use 45 degree slope
// to provide easy no-supports printing
inlet_outer_dia = 50;
inlet_inner_dia = 45;
inlet_length = 40;
outlet_outer_dia = 39.5;
outlet_inner_dia = 34.5;
outlet_length = 40;
max_slope_angle_deg = 45; // stay above 45 degrees for no-supports printing

inlet_outer_radius = inlet_outer_dia / 2.0;
inlet_inner_radius = inlet_inner_dia / 2.0;
outlet_outer_radius = outlet_outer_dia / 2.0;
outlet_inner_radius = outlet_inner_dia / 2.0;
// slope_ratio gives the z distance traveled for a given
// distance change in the x/y directions
max_slope_ratio = tan(max_slope_angle_deg);
inner_length = abs(max_slope_ratio * (inlet_outer_radius - outlet_outer_radius));
outer_length = abs(max_slope_ratio * (inlet_inner_radius - outlet_inner_radius));
cone_length = (inner_length > outer_length)?inner_length:outer_length;

translate([0, 0, outlet_length]) {
    // transition cone
    difference() {
        cylinder(cone_length, outlet_outer_radius, inlet_outer_radius);
        cylinder(cone_length, outlet_inner_radius, inlet_inner_radius);
    }

    // inlet
    translate([0, 0, cone_length]) {
        difference() {
            cylinder(inlet_length, inlet_outer_radius, inlet_outer_radius);
            cylinder(inlet_length, inlet_inner_radius, inlet_inner_radius);
        }
    }


    // outlet
    translate([0, 0, (-1.0 * outlet_length)]) {
        difference() {
            cylinder(outlet_length, outlet_outer_radius, outlet_outer_radius);
            cylinder(outlet_length, outlet_inner_radius, outlet_inner_radius);
        }
    }    
}
