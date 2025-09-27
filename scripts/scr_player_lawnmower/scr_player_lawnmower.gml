function scr_player_lawnmower()
{
    image_speed = 0.35;
    machhitAnim = 0;
    crouchslideAnim = 1;
    hsp = xscale * movespeed;
    move = key_left + key_right;
    
    if (grounded)
    {
        if (movespeed <= 10)
            movespeed = approach(movespeed, 10, 0.2);
        else
            movespeed = approach(movespeed, 10, 0.035);
        
        scr_player_addslopemomentum(0.095, 0.085, true, 8, noone);
        
        if (vsp >= 0)
        {
            if (sprite_index == get_charactersprite("spr_mowerjump") || sprite_index == get_charactersprite("spr_mowerfall"))
            {
                image_index = 0;
                sprite_index = get_charactersprite("spr_mowerland");
            }
            else if (sprite_index != get_charactersprite("spr_mowerland") && sprite_index != get_charactersprite("spr_mowerturnend") && !(move == -xscale))
                sprite_index = get_charactersprite("spr_mower");
        }
        
        if (move == -xscale && movespeed >= 6)
        {
            fmod_studio_event_instance_start(machdriftsnd);
            image_index = 0;
            sprite_index = get_charactersprite("spr_mowerturn");
            state = states.lawnmowerslide;
        }
        
        if (input_buffer_jump < 8 && move != -xscale)
        {
            if (movespeed >= 8)
                movespeed -= 2;
            
            vsp = -10;
            image_index = 0;
            sprite_index = get_charactersprite("spr_mowerjump");
            fmod_studio_event_instance_start(jumpsnd);
        }
        
        jumpstop = 0;
    }
    else
    {
        scr_dotaunt();
        
        if ((sprite_index == get_charactersprite("spr_mower") || sprite_index == get_charactersprite("spr_mowerturnend")) && vsp >= 0)
        {
            image_index = 0;
            sprite_index = get_charactersprite("spr_mowerfall");
        }
    }
    
    if (floor(image_index) == (image_number - 1))
    {
        if (sprite_index == get_charactersprite("spr_mowerjump"))
            sprite_index = get_charactersprite("spr_mowerfall");
        
        if (sprite_index == get_charactersprite("spr_mowerland") || sprite_index == get_charactersprite("spr_mowerturnend"))
            sprite_index = get_charactersprite("spr_mower");
    }
    
    if (!key_jump2 && (jumpstop == 0 && vsp < 0.5))
    {
        vsp /= 10;
        jumpstop = 1;
    }
    
    if (key_jump)
        input_buffer_jump = 0;
    
    if (place_meeting_collision(x + xscale, y) && (!place_meeting(x + hsp, y, obj_destructibles) && !place_meeting_slope(x + sign(hsp), y)))
    {
        var _bump = ledge_bump((vsp >= 0) ? 32 : 22);
        
        if (_bump)
        {
            if (grounded)
            {
                fmod_studio_event_oneshot_3d("event:/sfx/player/misc/bump");
                state = states.bump;
                image_index = 0;
                sprite_index = get_charactersprite("spr_wallsplat");
                instance_create(x, y + 10, obj_skateboarddebris1);
                instance_create(x, y + 10, obj_skateboarddebris2);
            }
            else
            {
                fmod_studio_event_oneshot_3d("event:/sfx/player/misc/bump");
                state = states.bump;
                hsp = -xscale * 5;
                vsp = -2;
                sprite_index = get_charactersprite("spr_bump");
                instance_create(x, y + 10, obj_skateboarddebris1);
                instance_create(x, y + 10, obj_skateboarddebris2);
            }
        }
    }
    
    if (!instance_exists(obj_slidecloud) && (grounded && movespeed > 5))
    {
        with (instance_create(x, y, obj_slidecloud))
            image_xscale = other.xscale;
    }
}

function scr_player_lawnmowerOLD()
{
    image_speed = 0.35;
    machhitAnim = 0;
    crouchslideAnim = 1;
    hsp = xscale * movespeed;
    move = key_left + key_right;
    
    if (grounded)
    {
        if (movespeed <= 10)
            movespeed = approach(movespeed, 10, 0.2);
        else
            movespeed = approach(movespeed, 10, 0.035);
    }
    
    scr_player_addslopemomentum(0.095, 0.085, true, 8, noone);
    
    if (grounded)
    {
        if (move == -xscale && movespeed >= 6)
        {
            fmod_studio_event_instance_start(machdriftsnd);
            image_index = 0;
            sprite_index = get_charactersprite("spr_mowerturn");
            state = states.lawnmowerslide;
        }
    }
    
    if (input_buffer_jump < 8 && grounded)
    {
        if (movespeed >= 8)
            movespeed -= 2;
        
        vsp = -10;
        image_index = 0;
        sprite_index = get_charactersprite("spr_mowerjump");
    }
    
    if (!grounded)
    {
        if ((sprite_index == get_charactersprite("spr_mower") || sprite_index == get_charactersprite("spr_mowerturnend")) && vsp >= 0)
        {
            image_index = 0;
            sprite_index = get_charactersprite("spr_mowerfall");
        }
    }
    
    if (grounded && vsp >= 0)
    {
        if (sprite_index == get_charactersprite("spr_mowerjump") || sprite_index == get_charactersprite("spr_mowerfall"))
        {
            image_index = 0;
            sprite_index = get_charactersprite("spr_mowerland");
        }
        else if (sprite_index != get_charactersprite("spr_mowerland"))
            sprite_index = get_charactersprite("spr_mower");
    }
    
    if (floor(image_index) == (image_number - 1))
    {
        if (sprite_index == get_charactersprite("spr_mowerjump"))
            sprite_index = get_charactersprite("spr_mowerfall");
        
        if (sprite_index == get_charactersprite("spr_mowerland") || sprite_index == get_charactersprite("spr_mowerturnend"))
            sprite_index = get_charactersprite("spr_mower");
    }
    
    if (!key_jump2 && (jumpstop == 0 && vsp < 0.5))
    {
        vsp /= 10;
        jumpstop = 1;
    }
    
    if (key_jump)
        input_buffer_jump = 0;
    
    if (grounded)
        jumpstop = 0;
    
    if (place_meeting_collision(x + xscale, y) && (!place_meeting(x + hsp, y, obj_destructibles) && !place_meeting_slope(x + sign(hsp), y)))
    {
        var _bump = ledge_bump((vsp >= 0) ? 32 : 22);
        
        if (_bump)
        {
            if (grounded)
            {
                state = states.bump;
                image_index = 0;
                sprite_index = get_charactersprite("spr_wallsplat");
                instance_create(x, y + 10, obj_skateboarddebris1);
                instance_create(x, y + 10, obj_skateboarddebris2);
            }
            else
            {
                state = states.bump;
                hsp = -xscale * 5;
                vsp = -2;
                sprite_index = get_charactersprite("spr_bump");
                instance_create(x, y + 10, obj_skateboarddebris1);
                instance_create(x, y + 10, obj_skateboarddebris2);
            }
        }
    }
    
    if (!instance_exists(obj_slidecloud) && (grounded && movespeed > 5))
    {
        with (instance_create(x, y, obj_slidecloud))
            image_xscale = other.xscale;
    }
    
    if (!grounded)
        scr_dotaunt();
}
