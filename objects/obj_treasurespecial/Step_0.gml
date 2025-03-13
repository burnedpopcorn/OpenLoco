visible = (global.collectspecial == global.collectspecialmax) ? true : false;

if (gotcaught)
{
    with (obj_playerspecialstage)
    {
        x = other.x + 16;
        y = other.y - 16;
        xx = Wave(-50, 50, other.speedxplayer, 15);
        
        if (xx >= 48)
            depth = other.depth + 1;
        
        if (xx <= -48)
            depth = other.depth - 1;
    }
}

if (y < -500 && gotcaught)
{
    if (!instance_exists(obj_fadeout))
    {
        with (obj_player1)
        {
            visible = true;
            targetRoom = roombefore;
            targetDoor = other.targetDoor;
            state = states.normal;
        }
        
        instance_create(x, y, obj_fadeout);
    }
}
