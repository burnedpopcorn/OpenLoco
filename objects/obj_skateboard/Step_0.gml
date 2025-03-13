if (vsp < 30)
    vsp += grav;

image_speed = 0.35;
scr_collision();

if (obj_player1.state == states.lawnmower || obj_player1.state == states.lawnmowerslide)
    image_alpha = 0.5;
else
    image_alpha = 1;
