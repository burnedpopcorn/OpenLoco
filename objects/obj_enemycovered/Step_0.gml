if (escape)
{
    visible = false;
    
    if (global.panic)
    {
        escape = 0;
        visible = true;
    }
}

if (!escape)
{
    var p = instance_nearest(x, y, obj_player);
    
    if ((p.x > (x - 200) && p.x < (x + 200)) && (y <= (p.y + 60) && y >= (p.y - 60)))
    {
        if (!active)
        {
            shake = 2;
            alarm[0] = 5;
            active = 1;
        }
    }
}
