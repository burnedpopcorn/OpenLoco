function scr_specialplayer_death()
{
    if (fall == 0)
        vsp = 0;
    
    hsp = 0;
    sprite_index = spr_deathend;
    image_speed = 0;
    
    if (place_meeting(x + floor(hsp), y, obj_null))
    {
        x = floor(x);
        
        while (!place_meeting(x + sign(hsp), y, obj_null))
            x += sign(hsp);
        
        hsp = 0;
    }
    
    x += hsp;
    
    if (place_meeting(x, y + floor(vsp), obj_null))
    {
        y = floor(y);
        
        while (!place_meeting(x, y + sign(vsp), obj_null))
            y += sign(vsp);
        
        vsp = 0;
    }
    
    y += floor(vsp);
    
    if (vsp < 30)
        vsp += grav;
}
