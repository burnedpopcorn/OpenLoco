function scr_ball_air()
{
    if (place_meeting(x, y - 1, obj_solid) && anglevertx == 180)
    {
        state = ballstates.land;
        vspinvert = 1;
        alarm[0] = 5;
    }
    else if (place_meeting(x, y + vsp, obj_solid) && vsp > 0.5)
    {
        state = ballstates.land;
        vspinvert = 1;
        alarm[0] = 5;
    }
    
    if (place_meeting(x + hsp, y, obj_solid))
    {
        state = ballstates.land;
        hspinvert = 1;
        alarm[0] = 5;
    }
    
    if (anglevertx == 0)
        move = key_left + key_right;
    else
        move = -(key_left + key_right);
    
    hsp = xscale * movespeed;
    
    if (move != 0)
    {
        if (movespeed < 9)
            movespeed += 0.2;
        
        if (movespeed > 9)
            movespeed -= 0.05;
    }
    
    if (move == 0)
    {
        if (movespeed < 0)
            movespeed += 0.1;
        
        if (movespeed > 0)
            movespeed -= 0.1;
        
        if (movespeed > -0.5 && movespeed < 0.5)
            movespeed = 0;
    }
    
    if (movespeed > 17)
        movespeed = 17;
    
    if (move == -xscale)
    {
        movespeed = -movespeed;
        xscale = -xscale;
    }
}
