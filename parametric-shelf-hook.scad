thickness = 2;
extruded_length = 100;
hook_opening = 20;
hook_length = 30;
shelf_opening = 100;
shelf_lip_length = 50;
hanging_height = 150;

cube([hanging_height, thickness, extruded_length]);
cube([thickness, (hook_opening + thickness), extruded_length]);
translate([0, hook_opening + thickness, 0]) cube([hook_length, thickness, extruded_length]);
translate([hanging_height, -shelf_opening-thickness, 0]) cube([thickness, shelf_opening + 2*thickness, extruded_length]);
translate([hanging_height-shelf_lip_length, -shelf_opening-thickness, 0]) cube([shelf_lip_length, thickness, extruded_length]);
