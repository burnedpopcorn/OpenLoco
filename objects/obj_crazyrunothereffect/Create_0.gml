playerid = obj_player1;
image_speed = 0.5;

if (image_angle != 90 && image_angle != -90)
    image_xscale = playerid.xscale;
else
    image_xscale = 1;

depth = -99;
