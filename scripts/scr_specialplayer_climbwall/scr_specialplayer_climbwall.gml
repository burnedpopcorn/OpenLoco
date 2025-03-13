function scr_specialplayer_climbwall()
{
    move = key_left + key_right;
    vsp = -wallspeed;
    
    if (wallspeed > -5)
        wallspeed -= 0.15;
    
    if (wallspeed < 0)
        movespeed += 0.4;
    
    if (vsp < 0)
        sprite_index = get_charactersprite("spr_climbwall");
    else
        sprite_index = get_charactersprite("spr_clingwall");
    
    if ((!place_meeting_collision(x + xscale, y) && !place_meeting_collision(x, y - 1)) && (!place_meeting_slope(x - sign(hsp), y) && !place_meeting_slope(x + sign(hsp), y) && !place_meeting_slope(x, y - 1)))
    {
        instance_create(x, y, obj_jumpdust);
        vsp = 0;
        
        if (wallspeed < 8)
            wallspeed = 8;
        
        if (wallspeed >= 8)
        {
            state = states.normal;
            movespeed = wallspeed;
        }
    }
    
    if (key_jump)
    {
        fmod_studio_event_instance_start(jumpsnd);
        key_jump = 0;
        movespeed = 6;
        state = states.normal;
        image_index = 0;
        sprite_index = spr_mach2jump;
        vsp = -11;
        xscale *= -1;
        jumpstop = 0;
    }
    
    if (wallspeed > 0 && place_meeting_collision(x, y - 12))
        wallspeed = 0;
    
    if (wallspeed < 0 && grounded)
    {
        xscale *= -1;
        instance_create(x, y, obj_jumpdust);
        vsp = 0;
        
        if (wallspeed < 6)
            wallspeed = 6;
        
        if (wallspeed >= 6)
        {
            state = states.normal;
            movespeed = wallspeed;
        }
    }
}
