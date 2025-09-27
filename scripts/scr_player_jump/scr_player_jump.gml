function scr_player_jump()
{
    if (momemtum == 0)
        hsp = move * movespeed;
    else
        hsp = xscale * movespeed;
    
    hsp += (railmovespeed * raildir);
    
    if (dir != xscale)
    {
        dir = xscale;
        movespeed = 2;
        facehurt = 0;
    }
    
    if (key_taunt2)
    {
        input_finisher_buffer = 60;
        input_attack_buffer = 0;
        input_up_buffer = 0;
        input_down_buffer = 0;
    }
    
    if (move != xscale)
        movespeed = 2;
    
    move = key_left + key_right;
    
    if (movespeed == 0)
        momemtum = 0;
    
    if (scr_solid(x + hsp, y))
    {
        movespeed = 0;
        mach2 = 0;
    }
    
    if (move != 0)
    {
        xscale = move;
        
        if (movespeed < 8)
            movespeed += 0.5;
        else if (floor(movespeed) == 8)
            movespeed = 6;
        
        if (scr_solid(x + xscale, y) && move == xscale)
            movespeed = 0;
    }
    else
        movespeed = 0;
    
    if (movespeed > 8)
        movespeed -= 0.1;
    
    if ((scr_solid(x + 1, y) && move == 1) || (scr_solid(x - 1, y) && move == -1))
        movespeed = 0;
    
    if (dir != xscale)
        dir = xscale;
    
    landAnim = 1;
    
    if (!key_jump2 && (jumpstop == 0 && (vsp < 0.5 && stompAnim == 0)))
    {
        vsp /= 10;
        jumpstop = 1;
    }
    
    if (ladderbuffer > 0)
        ladderbuffer--;
    
    if (scr_solid(x, y - 1) && (jumpstop == 0 && jumpAnim == 1))
    {
        vsp = grav;
        jumpstop = 1;
    }
    
    if ((grounded && can_jump && (input_buffer_jump < 8 && (!key_down && (!key_attack && vsp > 0)))) && !(sprite_index == get_charactersprite("spr_facestomp") || sprite_index == get_charactersprite("spr_freefall")))
    {
        fmod_studio_event_instance_start(jumpsnd);
        sprite_index = get_charactersprite("spr_jump");
        
        if (shotgunAnim == 1)
            sprite_index = get_charactersprite("spr_shotgunjump");
        
        instance_create(x, y, obj_highjumpcloud2);
        stompAnim = 0;
        vsp = -11;
        state = states.jump;
        jumpAnim = 1;
        jumpstop = 0;
        image_index = 0;
        freefallstart = 0;
    }
    
    if (!grounded && (input_buffer_jump < 8 && (character == "T" || genomode) && !Doublejump && vsp > 0))
    {
        sprite_index = get_charactersprite("spr_jump2");
        fmod_studio_event_instance_start(jumpsnd);
        vsp = -9;
        
        if (shotgunAnim == 1)
            sprite_index = get_charactersprite("spr_shotgunjump");
        
        instance_create(x, y, obj_jumpdust);
        stompAnim = 0;
        state = states.jump;
        jumpAnim = 1;
        jumpstop = 0;
        image_index = 0;
        freefallstart = 0;
        Doublejump = true;
    }
    
    if ((grounded && vsp > 0) && !key_attack)
    {
        fmod_studio_event_oneshot_3d("event:/sfx/player/step");
        
        if (key_attack)
            landAnim = 0;
        
        input_buffer_secondjump = 0;
        state = states.normal;
        instance_create(x, y, obj_landcloud);
        jumpAnim = 1;
        jumpstop = 0;
        image_index = 0;
        freefallstart = 0;
        movespeed = 2;
    }
    
    if ((key_special2 || input_buffer_special > 0) && !shotgunAnim && !genomode && !instance_exists(obj_cappy))
    {
        input_buffer_special = 0;
        do_specialmoves();
    }
    
    if ((key_slap2 || input_buffer_slap > 0) && key_up)
    {
        state = states.punch;
        input_buffer_slap = 0;
        image_index = 0;
        sprite_index = get_charactersprite("spr_breakdanceuppercut");
        fmod_studio_event_instance_start(uppercutsnd);
        vsp = -14;
        movespeed = hsp;
    }
    
    if (key_jump)
        input_buffer_jump = 0;
    
    if (vsp > 5)
        fallinganimation++;
    
    if (fallinganimation >= 40)
        sprite_index = get_charactersprite("spr_facestomp");
    
    if (stompAnim == 0)
    {
        if (jumpAnim == 1)
        {
            if (floor(image_index) == (image_number - 1))
                jumpAnim = 0;
        }
        
        if (jumpAnim == 0)
        {
            if (sprite_index == get_charactersprite("spr_airdash1"))
                sprite_index = get_charactersprite("spr_airdash2");
            
            if (sprite_index == get_charactersprite("spr_shotgunjump"))
                sprite_index = get_charactersprite("spr_shotgunfall");
            
            if (sprite_index == get_charactersprite("spr_jump"))
                sprite_index = get_charactersprite("spr_fall");
            
            if (sprite_index == get_charactersprite("spr_Sjumpstart"))
                sprite_index = get_charactersprite("spr_Sjump");
            
            if (sprite_index == get_charactersprite("spr_shotgunjump1"))
                sprite_index = get_charactersprite("spr_shotgunjump2");
            
            if (sprite_index == get_charactersprite("spr_suplexcancel") || sprite_index == get_charactersprite("spr_backflip") || sprite_index == get_charactersprite("spr_groundpoundjump"))
                sprite_index = get_charactersprite("spr_fall");
            
            if (sprite_index == get_charactersprite("spr_jump2"))
                sprite_index = get_charactersprite("spr_jump2fall");
        }
    }
    
    if (stompAnim == 1)
    {
        if (sprite_index == get_charactersprite("spr_stompprep") && floor(image_index) == (image_number - 1))
            sprite_index = get_charactersprite("spr_stomp");
    }
    
    do_groundpound();
    
    if (move != 0)
        xscale = move;
    
    if (sprite_index == get_charactersprite("spr_suplexcancel"))
        image_speed = 0.4;
    else
        image_speed = 0.35;
    
    if (grounded && (sprite_index == get_charactersprite("spr_facestomp") || sprite_index == get_charactersprite("spr_freefall")))
    {
        with (obj_baddie)
        {
            if (point_in_rectangle(x, y, __view_get(0, 0), __view_get(1, 0), __view_get(0, 0) + __view_get(2, 0), __view_get(1, 0) + __view_get(3, 0)))
            {
                vsp = -7;
                hsp = 0;
            }
        }
        
        with (obj_camera)
        {
            shake_mag = 10;
            shake_mag_acc = 30 / room_speed;
        }
        
        image_index = 0;
        sprite_index = get_charactersprite("spr_bodyslamland");
        state = states.freefallland;
    }
    
    if (sprite_index != get_charactersprite("spr_suplexbump"))
        dograb();
    
    scr_do_geno_shit();
    
    if ((key_slap2 || input_buffer_slap > 0) && (shotgunAnim == 1 && key_up))
    {
        state = states.shotgun;
        input_buffer_slap = 0;
        
        repeat (2)
            fmod_studio_event_oneshot_3d("event:/sfx/player/misc/kill");
        
        state = states.shotgun;
        
        with (instance_create(x, y, obj_pistoleffect))
            image_xscale = other.image_xscale;
        
        image_index = 0;
        sprite_index = get_charactersprite("spr_shotgunshoot");
        
        if (character == "P")
        {
            instance_create(x + (image_xscale * 20), y + 20, obj_shotgunbullet);
            
            with (instance_create(x + (image_xscale * 20), y + 20, obj_shotgunbullet))
                spdh = 4;
            
            with (instance_create(x + (image_xscale * 20), y + 20, obj_shotgunbullet))
                spdh = -4;
        }
    }
    
    if (!key_attack || move != xscale)
        mach2 = 0;
    
    if (key_attack && (grounded && fallinganimation < 40))
    {
        movespeed = 6;
        sprite_index = get_charactersprite("spr_mach1");
        jumpAnim = 1;
        state = states.mach2;
        image_index = 0;
    }
    
    scr_dotaunt();
}
