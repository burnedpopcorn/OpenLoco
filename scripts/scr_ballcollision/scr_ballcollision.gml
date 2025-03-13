function scr_ballcollision()
{
    if (anglevertx == 0)
    {
        if (vsp < 15)
            vsp += grav;
        
        if (place_meeting(x + floor(hsp), y, obj_solid))
        {
            x = floor(x);
            
            while (!place_meeting(x + sign(hsp), y, obj_solid))
                x += sign(hsp);
            
            hsp = 0;
        }
        
        x += floor(hsp);
        
        if (place_meeting(x, y + floor(vsp), obj_solid))
        {
            y = floor(y);
            
            while (!place_meeting(x, y + sign(vsp), obj_solid))
                y += sign(vsp);
            
            vsp = 0;
        }
        
        y += floor(vsp);
    }
    
    if (anglevertx == 180)
    {
        if (vsp > -15)
            vsp -= grav;
        
        if (place_meeting(x + floor(hsp), y, obj_solid))
        {
            x = floor(x);
            
            while (!place_meeting(x + sign(hsp), y, obj_solid))
                x += sign(hsp);
            
            hsp = 0;
        }
        
        x += floor(hsp);
        
        if (place_meeting(x, y + floor(vsp), obj_solid))
        {
            y = floor(y);
            
            while (!place_meeting(x, y + sign(vsp), obj_solid))
                y += sign(vsp);
            
            vsp = 0;
        }
        
        y += floor(vsp);
    }
}
