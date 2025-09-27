var playerid = obj_player1;

if (obj_player1.spotlight == 0)
    playerid = obj_player2;

if (image_alpha == 1)
{
    var dir = point_direction(x, y, playerid.x, playerid.y);
    x += lengthdir_x(maxspeed, dir);
    y += lengthdir_y(maxspeed, dir);
}
else
    image_alpha += 0.01;

if (place_meeting(x, y, playerid) && !playerid.cutscene && playerid.state != states.actor && playerid.state != states.backbreaker && !instance_exists(obj_fadeout) && !instance_exists(obj_endlevelfade) && image_alpha == 1)
{
    with (playerid)
    {
        instance_destroy(obj_fadeout);
        TUx = 20;
        TUy = 20;
        targetDoor = "A";
        room = timesuproom;
        state = states.timesup;
        sprite_index = spr_Timesup;
        image_index = 0;
        audio_stop_all();
    }
    
    instance_destroy();
}

if (maxspeed < 3 && image_alpha == 1)
    maxspeed += 0.01;
