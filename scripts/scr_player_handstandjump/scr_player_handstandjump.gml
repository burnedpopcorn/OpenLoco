function scr_player_handstandjump()
{
    landAnim = 0;
    hsp = xscale * movespeed;
    move = key_left + key_right;
    momemtum = 1;
    dir = xscale;
    
    if (movespeed < 10)
        movespeed += 0.5;
    
    if ((!key_jump2 && (jumpstop == 0 && (vsp < 0.5 && stompAnim == 0))) && sprite_index != get_charactersprite("spr_shoulderbashstart"))
    {
        vsp /= 10;
        jumpstop = 1;
    }
    
    if (move != xscale && move != 0)
    {
        image_index = 0;
        
        if (!grounded)
        {
            sprite_index = get_charactersprite("spr_suplexcancel");
            jumpAnim = 1;
            grav = 0.5;
            state = states.jump;
        }
        else
        {
            state = states.normal;
            movespeed = 2;
            grav = 0.5;
        }
    }
    
    if (sprite_index == get_charactersprite("spr_shoulderbashstart"))
    {
        vsp = 0;
        
        if (floor(image_index) == (image_number - 1))
        {
            image_speed = 0.35;
            state = key_attack ? states.mach2 : states.normal;
            grav = 0.5;
        }
    }
    
    if ((floor(image_index) == (image_number - 1) || (sprite_index == get_charactersprite("spr_suplexgrabjump") || sprite_index == get_charactersprite("spr_suplexgrabjumpstart"))) && (grounded && (!key_attack && vsp > 0)))
    {
        image_speed = 0.35;
        state = states.normal;
        grav = 0.5;
    }
    
    if ((floor(image_index) == (image_number - 1) || (sprite_index == get_charactersprite("spr_suplexgrabjump") || sprite_index == get_charactersprite("spr_suplexgrabjumpstart"))) && (grounded && key_attack))
    {
        image_speed = 0.35;
        state = states.mach2;
        grav = 0.5;
    }
    
    if (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_suplexgrabjumpstart"))
        sprite_index = get_charactersprite("spr_suplexgrabjump");
    
    if (key_down && grounded)
        scr_doslidekick();
    
    if (!grounded && (sprite_index == get_charactersprite("spr_suplexdash") || sprite_index == get_charactersprite("spr_secondjump1") || sprite_index == get_charactersprite("spr_secondjump2") || sprite_index == get_charactersprite("spr_shotgunsuplexdash")))
    {
        image_index = 0;
        sprite_index = get_charactersprite("spr_suplexgrabjump");
    }
    
    if (key_jump)
        input_buffer_jump = 0;
    
    if (grounded && input_buffer_jump < 8)
    {
        jumpstop = 0;
        image_index = 0;
        vsp = -11;
        state = states.mach2;
        fmod_studio_event_instance_start(rollgetupsnd);
        sprite_index = get_charactersprite("spr_longjump");
    }
    
    if (grounded && place_meeting(x + hsp, y, obj_solid) && !place_meeting(x + sign(hsp), y, obj_destructibles) && (!place_meeting_slope(x - sign(hsp), y) && !place_meeting_slope(x + sign(hsp), y)))
    {
        var _bump = slope_check_up(x + sign(hsp), y, 32);
        
        if (_bump != 0)
            y -= _bump;
        else
        {
            fmod_studio_event_oneshot_3d("event:/sfx/player/misc/bump");
            jumpstop = 1;
            state = states.jump;
            vsp = -4;
            sprite_index = get_charactersprite("spr_suplexbump");
            instance_create(x + (xscale * 10), y + 10, obj_bumpeffect);
        }
    }
    else if ((!grounded && (place_meeting(x + hsp, y, obj_solid) && (!place_meeting(x + hsp, y, obj_destructibles) && !place_meeting_slope(x + sign(hsp), y)))) || (grounded && (place_meeting(x + hsp, y - 64, obj_solid) && (!place_meeting(x + hsp, y, obj_destructibles) && (!place_meeting(x + hsp, y, obj_metalblock) && place_meeting_slope(x, y + 1))))))
    {
        if (character == "T")
        {
            wallspeed = movespeed;
            
            if (vsp > 0)
                wallspeed -= vsp;
            
            state = states.climbwall;
        }
        else
        {
            wallspeed = 6;
            grabclimbbuffer = 10;
            state = states.climbwall;
        }
    }
    
    if (!instance_exists(obj_slidecloud) && (grounded && movespeed > 5))
    {
        with (instance_create(x, y, obj_slidecloud))
            image_xscale = other.xscale;
    }
    
    image_speed = 0.35;
}
