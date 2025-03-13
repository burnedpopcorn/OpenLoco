if (place_meeting(x, y, obj_secretmetalblock) || place_meeting(x, y, obj_secretblock) || place_meeting(x, y, obj_secretbigblock) || place_meeting(x, y, obj_destructibles) || place_meeting(x, y, obj_bigdestructibles) || place_meeting(x, y, obj_metalblock))
    visible = false;
else
    visible = true;

if (global.collectsound < 10)
    global.collectsound += 1;

if (global.timeattack == 1)
    instance_destroy();

if ((abs(distance_to_object(obj_player1)) < 25 || (instance_exists(obj_cappy) && abs(distance_to_object(obj_cappy)) < 25)) && !place_meeting(x, y, obj_destructibles))
{
    if (!gotowardsplayer)
        scr_ghostcollectible();
    
    gotowardsplayer = 1;
}

if (gotowardsplayer == 1)
{
    move_towards_point(obj_player1.x, obj_player1.y, movespeed);
    movespeed++;
}
