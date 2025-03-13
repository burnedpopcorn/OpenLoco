if (other.state != states.bubble && other.state != states.debugstate)
{
    with (other)
    {
        state = states.bubble;
        hsp = 0;
        movespeed = 0;
        
        with (instance_create(x, y, obj_bubbleplayer))
            playerid = other.id;
    }
    
    instance_destroy();
}
