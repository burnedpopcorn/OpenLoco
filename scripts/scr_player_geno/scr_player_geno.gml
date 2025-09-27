function do_genoshoot()
{
    if (key_slap2)
    {
        image_index = 0;
        sprite_index = get_charactersprite("spr_genoshoot");
        fmod_studio_event_oneshot_3d("event:/sfx/player/geno/genoshoot");
        
        with (instance_create(x, y, obj_genobullet))
            spd = 10 * other.xscale;
        
        hsp = -3 * xscale;
        state = states.geno_shoot;
    }
}

function scr_geno_normal()
{
    image_speed = 0.35;
    move = key_left + key_right;
    
    if (sign(hsp) != move && abs(hsp) >= 1)
    {
        if (sprite_index != get_charactersprite("spr_genoturn"))
        {
            fmod_studio_event_oneshot_3d("event:/sfx/player/geno/genoturn");
            image_index = 0;
        }
        
        sprite_index = get_charactersprite("spr_genoturn");
        hsp = approach(hsp, 7 * move, 0.75);
    }
    else
        hsp = approach(hsp, 7 * move, 0.35);
    
    if (!grounded)
    {
        can_jump = true;
        state = states.geno_jump;
        sprite_index = get_charactersprite("spr_genofall");
        exit;
    }
    else if (grounded && key_jump)
    {
        can_jump = true;
        input_buffer_jump = 0;
        state = states.geno_jump;
        vsp = -11;
        image_index = 0;
        sprite_index = get_charactersprite("spr_genojump");
        landAnim = 1;
        fmod_studio_event_oneshot_3d("event:/sfx/player/geno/genojump");
        exit;
    }
    
    if (sprite_index == get_charactersprite("spr_genoturn"))
    {
        if (fmod_studio_event_instance_is_playing(genowalksnd))
            fmod_studio_event_instance_stop(genowalksnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
        
        if (animation_end())
            sprite_index = get_charactersprite("spr_genowalk");
    }
    else if (move != 0)
    {
        sprite_index = get_charactersprite("spr_genowalk");
        xscale = move;
    }
    else
    {
        sprite_index = get_charactersprite("spr_genoidle");
        fmod_studio_event_instance_stop(genowalksnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    }
    
    if (sprite_index == get_charactersprite("spr_genowalk") && move != 0 && floor(image_index) == (image_number < 7))
    {
        if (!fmod_studio_event_instance_is_playing(genowalksnd))
            fmod_studio_event_instance_start(genowalksnd);
    }
    else if (move == 0)
        fmod_studio_event_instance_stop(genowalksnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    
    if (key_attack2)
    {
        can_jump = false;
        state = states.geno_jump;
        vsp = -5;
        fmod_studio_event_oneshot_3d("event:/sfx/player/geno/genodash");
        var _mul = (move == 0) ? xscale : move;
        hsp = 10 * _mul;
        image_index = 0;
        sprite_index = get_charactersprite("spr_genodash");
    }
    
    if (landAnim == 1)
    {
        if (move == 0)
        {
            movespeed = 0;
            sprite_index = get_charactersprite("spr_genoland");
            
            if (floor(image_index) == (image_number - 1))
                landAnim = 0;
        }
        
        if (move != 0)
        {
            sprite_index = get_charactersprite("spr_genoland2");
            
            if (floor(image_index) == (image_number - 1))
            {
                landAnim = 0;
                sprite_index = get_charactersprite("spr_genowalk");
                image_index = 0;
            }
        }
    }
    
    do_genoshoot();
}

function scr_geno_jump()
{
    image_speed = 0.35;
    
    if ((sprite_index == get_charactersprite("spr_genojump") || sprite_index == get_charactersprite("spr_genodash") || sprite_index == get_charactersprite("spr_genodoublejump")) && animation_end())
        sprite_index = get_charactersprite("spr_genofall");
    
    if (fmod_studio_event_instance_is_playing(genowalksnd))
        fmod_studio_event_instance_stop(genowalksnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    
    if (grounded)
    {
        jumpstop = false;
        state = states.geno_normal;
        landAnim = 1;
        sprite_index = get_charactersprite("spr_genoidle");
        
        if (move == 0)
            hsp = 0;
    }
    
    if (key_jump && input_buffer_jump > 5)
    {
        sprite_index = get_charactersprite("spr_genodoublejump");
        image_index = 0;
        vsp = -9;
        fmod_studio_event_oneshot_3d("event:/sfx/player/geno/genodoublejump");
    }
    
    if (sprite_index == get_charactersprite("spr_genodash"))
        exit;
    
    if (!key_jump2 && (jumpstop == 0 && (vsp < 0.5 && stompAnim == 0)))
    {
        vsp /= 10;
        jumpstop = true;
    }
    
    if (key_attack2)
    {
        can_jump = false;
        state = states.geno_jump;
        vsp = -5;
        fmod_studio_event_oneshot_3d("event:/sfx/player/geno/genodash");
        var _mul = (move == 0) ? xscale : move;
        hsp = 10 * _mul;
        image_index = 0;
        sprite_index = get_charactersprite("spr_genodash");
    }
    
    move = key_left + key_right;
    hsp = approach(hsp, 7 * move, 0.75);
    
    if (sign(hsp) != 0)
        xscale = sign(hsp);
    
    do_genoshoot();
}

function scr_geno_shoot()
{
    move = key_left + key_right;
    hsp = approach(hsp, 7 * move, 0.25);
    
    if (!animation_end())
        exit;
    
    if (grounded)
    {
        image_index = 0;
        sprite_index = (move != 0) ? get_charactersprite("spr_genowalk") : get_charactersprite("spr_genoidle");
        state = states.geno_normal;
    }
    else
    {
        image_index = 0;
        sprite_index = get_charactersprite("spr_genofall");
        state = states.geno_jump;
    }
}
