function scr_player_zombiejump()
{
    image_speed = 0.35;
    
    if (floor(image_index) == (image_number - 1))
    {
        if (sprite_index == get_charactersprite("spr_zombiejumpstart"))
            sprite_index = get_charactersprite("spr_zombiejump");
        else if (sprite_index == get_charactersprite("spr_zombiejump") && vsp > 0)
            sprite_index = get_charactersprite("spr_zombiefall");
    }
    
    if (key_slap2 || input_buffer_slap > 0)
    {
        input_buffer_slap = 0;
        vsp = -6;
        sprite_index = get_charactersprite("spr_zombieattackairtrans1");
        image_index = 0;
        state = states.zombieattack;
        fmod_studio_event_instance_start(grabsnd);
    }
    
    hsp = movespeed;
    move = key_left + key_right;
    
    if (!key_jump2 && !jumpstop && vsp < 0.5)
    {
        vsp /= 10;
        jumpstop = 1;
    }
    
    if (key_jump)
        input_buffer_jump = 0;
    
    if (move != 0)
        movespeed = Approach(movespeed, move * 6, 0.5);
    else
        movespeed = Approach(movespeed, 0, 0.25);
    
    if (grounded && vsp >= 0)
    {
        if (move != 0)
            xscale = move;
        
        movespeed = abs(movespeed);
        state = states.zombie;
        sprite_index = get_charactersprite("spr_zombieland");
        image_index = 0;
        jumpstop = 0;
    }
    
    if (place_meeting(x, y, obj_water) || place_meeting(x, y, obj_waterunder) || place_meeting(x, y, obj_watercurrent))
    {
        instance_create(x, y, obj_genericpoofeffect);
        jumpstop = 0;
        
        if (!grounded)
            state = states.jump;
        else
            state = states.normal;
    }
}
