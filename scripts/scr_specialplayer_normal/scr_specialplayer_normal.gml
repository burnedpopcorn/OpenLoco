function scr_specialplayer_normal()
{
    hsp = xscale * movespeed;
    move = key_right + key_left;
    
    if (grounded)
        movespeed = Approach(movespeed, 8, 0.2);
    
    if (grounded)
    {
        cantpunch = 0;
        sprite_index = spr_mach;
    }
    
    if (!grounded && sprite_index != spr_mach2jump && sprite_index != spr_fall)
        sprite_index = spr_machfreefall;
    
    if (sprite_index != spr_machfreefall && sprite_index != spr_mach2jump && sprite_index != spr_fall)
        image_speed = abs(movespeed) / 15;
    else
        image_speed = 0.35;
    
    if (move == -xscale && grounded)
    {
        if (movespeed >= 6)
        {
            image_speed = 0.35;
            image_index = 0;
            state = states.bounce;
            sprite_index = spr_machslideboost;
            fmod_studio_event_oneshot_3d("event:/sfx/player/mach/drift");
        }
        else
            xscale *= -1;
    }
    
    if (key_jump)
        input_buffer_jump = 0;
    
    if (input_buffer_jump < 8 && (grounded && (!(move == 1 && xscale == -1) && !(move == -1 && xscale == 1))))
    {
        image_index = 0;
        sprite_index = spr_mach2jump;
        fmod_studio_event_oneshot_3d("event:/sfx/player/jump");
        vsp = -11;
    }
    
    if (!key_jump2 && (jumpstop == 0 && vsp < 0.5))
    {
        vsp /= 10;
        jumpstop = 1;
    }
    
    if (grounded && vsp > 0)
        jumpstop = 0;
    
    if (grounded && (!scr_slope() && ((place_meeting_collision(x + sign(hsp), y) || place_meeting_solid(x + sign(hsp), y)) && (!place_meeting(x + hsp, y, obj_destructibles) && !place_meeting_slope(x + sign(hsp), y)))))
    {
        var _bump = ledge_bump((vsp >= 0) ? 32 : 22);
        
        if (_bump)
        {
            fmod_studio_event_oneshot_3d("event:/sfx/player/misc/bump");
            state = states.finishingblow;
            image_index = 0;
            sprite_index = get_charactersprite("spr_wallsplat");
        }
    }
    
    if (key_slap2 && input_attack_buffer == 8 && cantpunch == 0)
    {
        state = states.transitioncutscene;
        flash = 1;
        fmod_studio_event_oneshot("event:/sfx/player/grabdash");
        
        if (grounded)
            sprite_index = array_random(sprarr_kungfu);
        else
            sprite_index = array_random(sprarr_kungfuair);
        
        image_index = 0;
        image_speed = 0.35;
        input_attack_buffer = 0;
        cantpunch = 1;
    }
    
    if ((!grounded && ((place_meeting_collision(x + sign(hsp), y) || place_meeting_solid(x + sign(hsp), y)) && (!place_meeting(x + hsp, y, obj_destructibles) && !place_meeting_slope(x + sign(hsp), y)))) || (grounded && ((place_meeting_collision(x + hsp, y - 64) || place_meeting_solid(x + hsp, y - 64)) && (!place_meeting(x + hsp, y, obj_destructibles) && (!place_meeting(x + hsp, y, obj_metalblock) && place_meeting_slope(x, y + 1))))))
    {
        cantpunch = 0;
        wallspeed = movespeed;
        
        if (vsp > 0)
            vsp -= wallspeed;
        
        state = states.tumble;
    }
}
