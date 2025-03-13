scr_collision();
hsp = image_xscale * 10;

if (place_meeting(x + image_xscale, y, [obj_solid, obj_slope]))
    instance_destroy();
