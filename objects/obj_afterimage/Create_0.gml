type = afterimgs.grabimg;
playerid = undefined;
len = 5;
dir = 5;
invert = 1;
image_speed = 0;
depth = obj_player.depth + 30;
output_modifier = noone;
output_resetter = noone;
output_add = noone;

if (!object_exists(playerid))
    exit;

if (variable_instance_exists(playerid, "angle"))
    image_angle = playerid.angle;

if (type == afterimgs.grabimg)
    depth = playerid.depth + 30;
else
    depth = playerid.depth + 45;
