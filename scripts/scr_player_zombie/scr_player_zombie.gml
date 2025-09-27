function scr_player_zombie()
{
    key_particles = 0;
    mach2 = 0;
    alarm[5] = 2;
    alarm[7] = 60;
    move = key_left + key_right;
    hsp = xscale * movespeed;
    
    if (key_jump)
        input_buffer_jump = 0;
    
    if (grounded && move != 0 && sprite_index == get_charactersprite("spr_zombieidle"))
        sprite_index = get_charactersprite("spr_zombiewalk");
    else if (grounded && move == 0 && sprite_index == get_charactersprite("spr_zombiewalk"))
        sprite_index = get_charactersprite("spr_zombieidle");
    
    if (move != 0 && sprite_index != get_charactersprite("spr_zombiejumpstart"))
    {
        if (xscale != move)
        {
            if (movespeed > 2)
                movespeed = -movespeed;
            
            xscale = move;
        }
        
        movespeed = Approach(movespeed, 6, 0.4);
    }
    else
        movespeed = Approach(movespeed, 0, 0.25);
    
    if (sprite_index == get_charactersprite("spr_zombiewalk"))
        image_speed = abs(movespeed) / 11;
    else
        image_speed = 0.35;
    
    if (!grounded)
    {
        state = states.zombiejump;
        sprite_index = get_charactersprite("spr_zombiefall");
        jumpstop = 1;
        movespeed = xscale * movespeed;
    }
    
    if (floor(image_index) == (image_number - 1))
    {
        if (sprite_index == get_charactersprite("spr_zombieland"))
        {
            if (move != 0)
                sprite_index = get_charactersprite("spr_zombiewalk");
            else
                sprite_index = get_charactersprite("spr_zombieidle");
        }
    }
    
    if (input_buffer_jump < 8 && grounded)
    {
        jumpstop = 0;
        vsp = -10;
        image_index = 0;
        sprite_index = get_charactersprite("spr_zombiejump");
        state = states.zombiejump;
        movespeed *= xscale;
        fmod_studio_event_instance_start(jumpsnd);
    }
    
    if (sprite_index == get_charactersprite("spr_zombieland"))
    {
        if ((place_meeting(x, y + 1, obj_platform) || place_meeting(x, y + 1, obj_slopePlatform)) && !place_meeting_solid(x, y + 1))
            y += 1;
    }
    
    if (place_meeting(x, y, obj_water) || place_meeting(x, y, obj_waterunder) || place_meeting(x, y, obj_watercurrent))
    {
        instance_create(x, y, obj_genericpoofeffect);
        
        if (!grounded)
            state = states.jump;
        else
            state = states.normal;
    }
    
    if (grounded)
    {
        if (key_slap2 || input_buffer_slap > 0)
        {
            input_buffer_slap = 0;
            
            if (movespeed < 8)
                movespeed = 8;
            
            sprite_index = get_charactersprite("spr_zombieattack");
            image_index = 0;
            state = states.zombieattack;
            fmod_studio_event_instance_start(grabsnd);
        }
    }
}
