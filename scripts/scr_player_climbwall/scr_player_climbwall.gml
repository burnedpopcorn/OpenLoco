function scr_player_climbwall()
{
    if (windingAnim < 200)
        windingAnim++;
    
    move = key_left + key_right;
    suplexmove = 0;
    vsp = upsidedown ? wallspeed : -wallspeed;
    
    if (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_climbwalldash"))
        sprite_index = get_charactersprite("spr_climbwall");
    
    if (sprite_index != get_charactersprite("spr_climbwalldash"))
    {
        if (wallspeed < 20)
            wallspeed += 0.15;
        
        if (wallspeed < 0)
        {
            if (mach4mode == 0)
                movespeed += 0.2;
            else
                movespeed += 0.4;
        }
    }
    else
        wallspeed += 0.3;
    
    crouchslideAnim = 1;
    
    if (sprite_index != get_charactersprite("spr_climbwalldash"))
        sprite_index = get_charactersprite("spr_climbwall");
    
    if (key_slap2 && sprite_index == get_charactersprite("spr_climbwall"))
    {
        flash = 1;
        var speedAccel = 3;
        wallspeed += speedAccel;
        movespeed += speedAccel;
        fmod_studio_event_instance_start(grabsnd);
        image_index = 0;
        sprite_index = get_charactersprite("spr_climbwalldash");
    }
    
    if (!key_attack && grabclimbbuffer == 0)
    {
        state = states.normal;
        movespeed = 0;
        railmovespeed = 6;
        raildir = -xscale;
        
        if (upsidedown)
            upsidedown = false;
    }
    
    if (!upsidedown)
    {
        if (scr_solid(x, y - 1) && (!place_meeting(x, y - 1, obj_destructibles) && (!place_meeting_slope(x + xscale, y) && !place_meeting_slope(x, y - 1))))
        {
            sprite_index = get_charactersprite("spr_superjumpland");
            fmod_studio_event_oneshot_3d("event:/sfx/player/bodyslam_land");
            image_index = 0;
            state = states.Sjumpland;
            machhitAnim = 0;
        }
        
        if (scr_solid(x, y - 1) && !place_meeting(x, y - 1, obj_destructibles) && place_meeting_slope(x + xscale, y))
        {
            upsidedown = true;
            vsp = 0;
            xscale *= -1;
            
            if (wallspeed < 6)
                wallspeed = 6;
            
            movespeed = wallspeed;
            
            if (wallspeed >= 6 && wallspeed < 12)
            {
                state = states.mach2;
                sprite_index = get_charactersprite("spr_mach");
            }
            else if (wallspeed >= 12)
            {
                state = states.mach3;
                sprite_index = get_charactersprite("spr_mach4");
            }
        }
        
        if ((!place_meeting_collision(x + xscale, y) && !place_meeting_collision(x, y - 1)) && (!place_meeting_slope(x - sign(hsp), y) && !place_meeting_slope(x + sign(hsp), y) && !place_meeting_slope(x, y - 1)))
        {
            instance_create(x, y, obj_jumpdust);
            vsp = 0;
            
            if (wallspeed < 6)
                wallspeed = 6;
            
            if (wallspeed >= 6 && wallspeed < 12)
            {
                state = states.mach2;
                movespeed = wallspeed;
            }
            else if (wallspeed >= 12)
            {
                state = states.mach3;
                sprite_index = get_charactersprite("spr_mach4");
                movespeed = wallspeed;
            }
        }
        
        if (wallspeed < 0 && place_meeting_collision(x, y + 12))
            wallspeed = 0;
    }
    else
    {
        if (place_meeting_collision(x, y + 1) && !place_meeting(x, y + 1, obj_destructibles))
        {
            if (place_meeting_slope(x, y + 1))
            {
                sprite_index = get_charactersprite("spr_mach4");
                state = states.mach3;
                movespeed = wallspeed;
                xscale *= -1;
            }
            else
            {
                sprite_index = get_charactersprite("spr_superjumpland");
                fmod_studio_event_oneshot_3d("event:/sfx/player/bodyslam_land");
                image_index = 0;
                state = states.Sjumpland;
                machhitAnim = 0;
                upsidedown = false;
            }
        }
        
        if (place_meeting_collision(x, y + 1) && (!place_meeting(x, y + 1, obj_destructibles) && (place_meeting_slope(x + xscale, y) && !place_meeting_slope(x, y + 1))))
        {
            trace("CLIMBWALL REVERSE");
            upsidedown = false;
            vsp = 0;
            xscale *= -1;
            
            if (wallspeed < 6)
                wallspeed = 6;
            
            if ((wallspeed >= 6 && wallspeed < 12) || genomode)
            {
                state = states.mach2;
                movespeed = wallspeed;
            }
            else if (wallspeed >= 12 && !genomode)
            {
                state = states.mach3;
                sprite_index = get_charactersprite("spr_mach4");
                movespeed = wallspeed;
            }
        }
        
        if ((!place_meeting_collision(x + xscale, y) && !place_meeting_collision(x, y + 1)) && (!place_meeting_slope(x - sign(hsp), y) && !place_meeting_slope(x + sign(hsp), y) && !place_meeting_slope(x, y + 1)))
        {
            instance_create(x, y, obj_jumpdust);
            upsidedown = false;
            vsp = 0;
            
            if (wallspeed < 6)
                wallspeed = 6;
            
            if ((wallspeed >= 6 && wallspeed < 12) || genomode)
            {
                state = states.mach2;
                movespeed = wallspeed;
            }
            else if (wallspeed >= 12 || genomode)
            {
                state = states.mach3;
                sprite_index = get_charactersprite("spr_mach4");
                movespeed = wallspeed;
            }
        }
    }
    
    if (key_jump)
    {
        key_jump = 0;
        movespeed = 10;
        state = states.mach2;
        image_index = 0;
        sprite_index = get_charactersprite("spr_walljumpstart");
        fmod_studio_event_instance_start(jumpsnd);
        
        if (upsidedown)
            upsidedown = false;
        else
            vsp = -11;
        
        xscale *= -1;
        jumpstop = 0;
    }
    
    if (sprite_index == get_charactersprite("spr_climbwall"))
        image_speed = wallspeed / 20;
    else
        image_speed = 0.35;
    
    if (!instance_exists(obj_cloudeffect))
        instance_create(x, y + 43, obj_cloudeffect);
}
