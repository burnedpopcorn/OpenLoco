if (vsp < 12)
    vsp += grav;

if (place_meeting(x, y - 1, obj_player) && ((obj_player.x >= (x - 8) && obj_player.x <= (x + 8)) && (obj_player.state == states.normal || (obj_player.state == states.crouch || obj_player.state == states.mach1))))
{
    obj_player.state = states.barrelcrouch;
    obj_player.image_index = 0;
    obj_player.barrel = 1;
    obj_player.vsp = 10;
    instance_destroy();
}

if (grounded)
{
    hsp = 0;
    bounce = 0;
}

if (place_meeting(x - 5, y, obj_player) && (obj_player.image_xscale == 1 && ((obj_player.state == states.mach1 || (obj_player.state == states.mach2 || obj_player.state == states.mach3)) && bounce == 0)))
{
    vsp = -3;
    hsp = 3;
    bounce = 1;
    obj_player.state = states.tackle;
    obj_player.image_index = 0;
    obj_player.mach2 = 0;
}

if (place_meeting(x + 5, y, obj_player) && (obj_player.image_xscale == -1 && ((obj_player.state == states.mach1 || obj_player.state == states.mach2) && bounce == 0)))
{
    vsp = -3;
    hsp = -3;
    bounce = 1;
    obj_player.state = states.tackle;
    obj_player.image_index = 0;
}

scr_collide();
