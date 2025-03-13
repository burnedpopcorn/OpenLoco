function scr_player_capefall()
{
    if (sign(hsp) != 0)
        xscale = sign(hsp);
    
    if (animation_end() && sprite_index == get_charactersprite("spr_capeend"))
        sprite_index = get_charactersprite("spr_capefall");
    
    if (grounded)
    {
        state = (movespeed > 6) ? states.mach2 : states.normal;
        sprite_index = get_charactersprite("spr_land");
        exit;
    }
    
    move = key_left + key_right;
    
    if (move != 0 && sign(move) != xscale)
    {
        xscale = sign(move);
        hsp = xscale * 2;
    }
}

function scr_player_cape()
{
    static _up_frame = 2;
    static _down_frame = 13;
    
    instakillmove = movespeed >= 12;
    var moveh = key_down + -key_up;
    terminalVelocity = Approach(terminalVelocity, (moveh == xscale) ? 20 : 10, 0.5);
    
    if (sprite_index == get_charactersprite("spr_capebounce"))
    {
        xscale *= -1;
        sprite_index = get_charactersprite("spr_cape");
        vsp -= 4;
        movespeed++;
        fmod_studio_event_oneshot_3d("event:/sfx/player/misc/bump");
        instance_create(x, y, obj_bumpeffect);
        exit;
    }
    
    move = -key_up + key_down;
    grav = 0.3;
    hsp += ((movespeed / 8) * sign(xscale));
    hsp = clamp(hsp, -movespeed, movespeed);
    movespeed = clamp(movespeed, 0, 24);
    
    if (scr_solid(x + xscale, y))
    {
        image_index = 0;
        image_speed = 0.35;
        sprite_index = get_charactersprite("spr_capebounce");
        exit;
    }
    
    image_speed = 0;
    
    if (moveh != 0)
    {
        var glidespeed = 0.65;
        
        if (moveh == -xscale)
            glidespeed = 0.95;
        
        vsp += (glidespeed * moveh);
    }
    
    vsp = clamp(vsp, -20, 20);
    
    if (key_down2)
        fmod_studio_event_instance_start(capedownsnd);
    
    if (key_up2)
        fmod_studio_event_instance_start(capeupsnd);
    
    image_index += ((abs(vsp) / 10) * sign(vsp));
    
    if (image_index >= _down_frame)
        image_index = _down_frame;
    
    if (image_index <= _up_frame)
        image_index = _up_frame;
    
    with (instance_place(x + xscale, y, [obj_destructibles, obj_bigdestructibles, obj_destroyable, obj_metalblock]))
    {
        if (object_index != obj_metalblock || other.movespeed >= 12)
            instance_destroy();
    }
    
    if (grounded)
    {
        image_speed = 0.35;
        grav = 0.5;
        terminalVelocity = 16;
        sprite_index = get_charactersprite("spr_machroll");
        state = states.tumble;
    }
    
    if (key_jump)
    {
        image_speed = 1;
        sprite_index = get_charactersprite("spr_capeend");
        grav = 0.5;
        terminalVelocity = 16;
        movespeed = abs(hsp);
        state = states.capefall;
        hsp = xscale * movespeed;
    }
}
