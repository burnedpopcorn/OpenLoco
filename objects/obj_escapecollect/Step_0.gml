if (global.collectsound < 10)
    global.collectsound += 1;

if (distance_to_object(obj_player) < 10)
{
    if (global.timeattack == 1)
        instance_destroy();
}

if (place_meeting(x, y, obj_secretmetalblock) || place_meeting(x, y, obj_secretblock) || place_meeting(x, y, obj_secretbigblock) || place_meeting(x, y, obj_destructibles) || place_meeting(x, y, obj_bigdestructibles) || place_meeting(x, y, obj_metalblock))
    visible = false;
else
    visible = true;

if (global.panic == 1)
{
    if (!gotowardsplayer && (abs(distance_to_object(obj_player1)) < 25 || (instance_exists(obj_cappy) && abs(distance_to_object(obj_cappy)) < 25)))
    {
        gotowardsplayer = 1;
        scr_ghostcollectible();
    }
    
    if (gotowardsplayer == 1)
    {
        move_towards_point(obj_player1.x, obj_player1.y, movespeed);
        movespeed++;
    }
}
