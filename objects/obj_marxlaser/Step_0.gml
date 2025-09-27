if (instance_exists(obj_marx))
{
    x = obj_marx.x + 125;
    y = obj_marx.y;
}

image_xscale = 20;

if (!parried && !endbuffering)
{
    if (place_meeting(x, y, obj_player1) && obj_player.state != states.backbreaker && obj_player.state != states.parrying && obj_player.state != states.door && obj_player.state != states.comingoutdoor)
    {
        with (obj_player1)
        {
            if (state != states.timesup)
            {
                other.alarm[0] = 1;
                visible = false;
                state = states.timesup;
            }
        }
    }
}
else { }
