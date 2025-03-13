function ledge_bump(argument0)
{
    old_x = x;
    old_y = y;
    x += (xscale * 4);
    var ty = try_solid(0, -1, obj_solid, argument0);
    x = old_x;
    
    if (ty != -1)
    {
        y -= ty;
        x += xscale;
        
        if (place_meeting_solid(x, y))
        {
            x = old_x;
            y = old_y;
            return 1;
        }
        
        return 0;
    }
    
    return 1;
}
