function scr_player_tumble()
{
    hsp = xscale * movespeed;
    
    if (sprite_index != get_charactersprite("spr_dive"))
        previous_state = states.tumble;
    
    if (!groundedSlope && (sprite_index == get_charactersprite("spr_tumblestart") && floor(image_index) < 11))
        image_index = 11;
    
    if ((sprite_index == get_charactersprite("spr_crouchslip") || sprite_index == get_charactersprite("spr_crouchslidestart")) && grounded && !place_meeting(x, y + 1, obj_solid) && scr_slope() && movespeed < 1)
    {
        with (instance_place(x, y + 1, obj_slope))
            other.xscale = -sign(image_xscale);
        
        movespeed = 1;
    }
    
    if ((!grounded && sprite_index != get_charactersprite("spr_dive")) && (sprite_index == get_charactersprite("spr_machroll") || sprite_index == get_charactersprite("spr_mach2jump") || sprite_index == get_charactersprite("spr_backslide") || sprite_index == get_charactersprite("spr_backslideland") || sprite_index == get_charactersprite("spr_crouchslip") || sprite_index == get_charactersprite("spr_crouchslidestart")))
    {
        vsp = 10;
        fmod_studio_event_oneshot_3d("event:/sfx/player/dive");
        sprite_index = get_charactersprite("spr_dive");
    }
    
    if (grounded && sprite_index == get_charactersprite("spr_dive"))
    {
        image_index = 0;
        
        if (previous_state == states.slidekick)
        {
            state = states.slidekick;
            sprite_index = get_charactersprite("spr_backslideland");
            image_index = 0;
        }
        else
            sprite_index = get_charactersprite("spr_machroll");
    }
    
    if (sprite_index == get_charactersprite("spr_dive") && key_jump)
    {
        do_groundpound();
        sprite_index = get_charactersprite("spr_poundcancel1");
    }
    
    if (grounded && sprite_index == get_charactersprite("spr_jumpdive2"))
    {
        sprite_index = get_charactersprite("spr_crouchslip");
        image_index = 0;
    }
    
    if (sprite_index == get_charactersprite("spr_mach2jump") && grounded)
    {
        image_index = 0;
        sprite_index = get_charactersprite("spr_machroll");
    }
    
    if (sprite_index == get_charactersprite("spr_tumblestart") && floor(image_index) == (image_number - 1))
        sprite_index = get_charactersprite("spr_tumble");
    
    if (sprite_index == get_charactersprite("spr_crouchslidestart") && floor(image_index) == (image_number - 1))
        sprite_index = get_charactersprite("spr_crouchslip");
    
    if (sprite_index == get_charactersprite("spr_machroll") && !grounded)
        sprite_index = get_charactersprite("spr_mach2jump");
    
    if (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_backslideland"))
        sprite_index = get_charactersprite("spr_backslide");
    
    if (key_jump)
        input_buffer_jump = 0;
    
    if (!key_jump2 && (jumpstop == 0 && (vsp < 0.5 && stompAnim == 0)))
    {
        vsp /= 2;
        jumpstop = 1;
    }
    
    if (crouchslipbuffer > 0)
        crouchslipbuffer--;
    
    if (!key_down && key_attack && grounded && sprite_index != get_charactersprite("spr_jumpdive2") && sprite_index != get_charactersprite("spr_tumble") && !scr_solid(x, y - 16) && !scr_solid(x, y - 32))
    {
        if (crouchslipbuffer == 0)
        {
            fmod_studio_event_instance_start(rollgetupsnd);
            particle_set_scale(5, xscale, 1);
            create_particle(x, y, 5, 0);
            
            if (movespeed >= 12 && !genomode)
                state = states.mach3;
            else
                state = states.mach2;
            
            image_index = 0;
            sprite_index = get_charactersprite("spr_rollgetup");
        }
    }
    
    if (!key_down && !key_attack && grounded && sprite_index != get_charactersprite("spr_jumpdive2") && sprite_index != get_charactersprite("spr_tumble") && !scr_solid(x, y - 16) && !scr_solid(x, y - 32))
    {
        if (crouchslipbuffer == 0)
        {
            if (movespeed > 6)
            {
                state = states.machslide;
                sprite_index = get_charactersprite("spr_machslidestart");
                image_index = 0;
            }
            else
                state = states.normal;
        }
    }
    
    if (input_buffer_jump < 8 && grounded && (sprite_index == get_charactersprite("spr_crouchslip") || sprite_index == get_charactersprite("spr_crouchslidestart") || sprite_index == get_charactersprite("spr_jumpdive2")) && !scr_solid(x, y - 16) && !scr_solid(x, y - 32))
    {
        state = states.mach2;
        vsp = -11;
        
        if (movespeed < 6)
            movespeed = 6;
        else
            movespeed += 1;
        
        sprite_index = get_charactersprite("spr_secondjump1");
        image_index = 0;
        input_down_buffer = 30;
        
        with (instance_create(x, y, obj_superdashcloud))
            image_xscale = other.xscale;
    }
    
    if (grounded && vsp > 0)
        jumpstop = 0;
    
    if (input_buffer_jump < 8 && (grounded && sprite_index == get_charactersprite("spr_tumble") && hsp != 0))
        vsp = -9;
    
    if (!instance_exists(dashcloudid) && grounded)
    {
        with (instance_create(x, y, obj_dashcloud))
        {
            image_xscale = other.xscale;
            other.dashcloudid = id;
        }
    }
    
    if (scr_solid(x + sign(hsp), y) && !place_meeting(x + hsp, y, obj_destructibles))
    {
        hsp = 0;
        movespeed = 0;
        
        if (sprite_index == get_charactersprite("spr_tumble") || sprite_index == get_charactersprite("spr_tumblestart"))
        {
            state = states.bump;
            landAnim = 0;
            sprite_index = get_charactersprite("spr_tumbleend");
            image_index = 0;
            hsp = -xscale * 2;
            vsp = -3;
            jumpstop = 1;
        }
        else
        {
            fmod_studio_event_oneshot_3d("event:/sfx/player/misc/wallsplat");
            state = states.bump;
            image_index = 0;
            sprite_index = get_charactersprite("spr_wallsplat");
        }
    }
    
    image_speed = abs(movespeed) / 15;
}
