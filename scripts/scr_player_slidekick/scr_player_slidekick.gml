function scr_player_slidekick()
{
    grav = 0.5;
    hsp = movespeed * xscale;
    
    if (grounded && sprite_index == get_charactersprite("spr_mach2jump"))
        sprite_index = get_charactersprite("spr_backslideland");
    
    if (sprite_index == get_charactersprite("spr_backslideland") && animation_end())
        sprite_index = get_charactersprite("spr_backslide");
    
    scr_player_addslopemomentum(0.095, 0.085, true, -4, noone);
    
    if (abs(movespeed) <= 1)
    {
        state = states.normal;
        grav = 0.5;
        movespeed = 0;
        hsp = 0;
        sprite_index = get_charactersprite("spr_land");
    }
    
    if (!scr_slope() && ((place_meeting_collision(x + sign(hsp), y) || place_meeting_solid(x + sign(hsp), y)) && (!place_meeting(x + hsp, y, obj_destructibles) && !place_meeting_slope(x + sign(hsp), y))))
    {
        fmod_studio_event_oneshot_3d("event:/sfx/player/bodyslam_land");
        xscale *= -1;
        movespeed -= 1;
    }
    
    if (key_jump && (!scr_solid(x, y - 16) && !scr_solid(x, y - 32)))
    {
        key_down2 = false;
        vsp = -8;
        state = states.mach2;
        sprite_index = get_charactersprite("spr_mach2jump");
    }
    
    if (!key_down && grounded && (!scr_solid(x, y - 16) && !scr_solid(x, y - 32)))
    {
        image_index = 0;
        sprite_index = get_charactersprite("spr_rollgetup");
        
        if (abs(movespeed) >= 12 && key_attack)
            state = states.mach3;
        else if (abs(movespeed) < 12 && abs(movespeed) > 5 && key_attack)
            state = states.mach2;
        else if (abs(movespeed) <= 5 || !key_attack)
        {
            sprite_index = get_charactersprite("spr_land");
            state = states.normal;
        }
    }
    
    if (!grounded && sprite_index != get_charactersprite("spr_mach2jump"))
    {
        previous_state = states.slidekick;
        particle_set_scale(5, xscale, 1);
        create_particle(x, y, 5, 0);
        flash = 0;
        state = states.tumble;
        vsp = 10;
        image_index = 0;
        sprite_index = get_charactersprite("spr_dive");
    }
}
