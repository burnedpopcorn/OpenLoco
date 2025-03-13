if (global.collectsound < 10)
    global.collectsound += 1;

if (global.timeattack == 1)
    instance_destroy();

if (abs(distance_to_object(obj_playerspecialstage)) < 25 && !place_meeting(x, y, obj_destructibles) && !place_meeting(x, y, obj_iceblock))
    gotowardsplayer = 1;

if (gotowardsplayer == 1)
{
    move_towards_point(obj_playerspecialstage.x, obj_playerspecialstage.y, movespeed);
    movespeed++;
}
