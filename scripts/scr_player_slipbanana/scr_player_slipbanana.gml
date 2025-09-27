function scr_player_slipbanana()
{
    hsp = xscale * movespeed;
    
    if (grounded)
        movespeed = Approach(movespeed, 0, 0.5);
    
    if (floor(image_index) == (image_number - 1) && sprite_index != get_charactersprite("spr_rockethitwall"))
        image_speed = 0;
    else
        image_speed = 0.35;
    
    if (sprite_index == get_charactersprite("spr_slipbanan2"))
    {
        scr_player_addslopemomentum(0.095, 0.085, true, -4, noone);
        
        if (!grounded)
        {
            sprite_index = get_charactersprite("spr_slipbanan1");
            image_index = 3;
        }
    }
    
    if (grounded && vsp > -1 && sprite_index != get_charactersprite("spr_slipbanan2") && !place_meeting(x, y + 1, obj_metalblock) && !place_meeting(x, y + 1, obj_destructibles))
    {
        if (sprite_index == get_charactersprite("spr_rockethitwall"))
        {
            fmod_studio_event_instance_start(slipendsnd);
            sprite_index = get_charactersprite("spr_slipbanan2");
            image_index = 0;
            image_speed = 0.35;
        }
        else
        {
            fmod_studio_event_oneshot_3d("event:/sfx/player/slip/bump");
            vsp = -6;
            movespeed = Approach(movespeed, 0, 3);
            sprite_index = get_charactersprite("spr_rockethitwall");
            instance_create(x, y + 43, obj_bangeffect);
        }
    }
    
    if (sprite_index == get_charactersprite("spr_slipbanan2"))
    {
        if (floor(image_index) == (image_number - 1) && abs(hsp) <= 2)
        {
            state = states.normal;
            
            if (is_hub())
                obj_camera.lock = false;
        }
    }
    
    if (place_meeting_collision(x + xscale, y) && !scr_slope() && (place_meeting_slope(x + sign(hsp), y) || place_meeting_solid(x + sign(hsp), y)) && !place_meeting(x + sign(hsp), y, obj_destructibles))
    {
        fmod_studio_event_oneshot_3d("event:/sfx/player/slip/bump");
        
        if (sprite_index == get_charactersprite("spr_slipbanan1"))
            movespeed = Approach(movespeed, 0, 3);
        
        sprite_index = get_charactersprite("spr_rockethitwall");
        instance_create(x + 30, y, obj_bangeffect);
        xscale *= -1;
        scr_sleep(1);
    }
}
