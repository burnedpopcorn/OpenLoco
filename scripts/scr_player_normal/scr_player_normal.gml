function scr_player_normal()
{
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
    
    mach2 = 0;
    move = key_left + key_right;
    
    if (!place_meeting(x, y + 1, obj_railh) && !place_meeting(x, y + 1, obj_railh2))
        hsp = move * movespeed;
    else if (place_meeting(x, y + 1, obj_railh))
        hsp = (move * movespeed) - 5;
    else if (place_meeting(x, y + 1, obj_railh2))
        hsp = (move * movespeed) + 5;
    
    if (key_up && key_shoot2 && character == "T")
    {
        with (instance_create(x + (10 * xscale), y, obj_coin))
            vsp = -10;
    }
    
    var breakdance_max = 10;
    
    if (key_taunt && !shotgunAnim && !genomode)
        breakdance_pressed++;
    else
        breakdance_pressed = 0;
    
    if (breakdance_pressed == breakdance_max && !shotgunAnim)
        flash = 1;
    
    if (breakdance_pressed >= breakdance_max && !shotgunAnim)
        breakdance_speed = Approach(breakdance_speed, 0.6, 0.005);
    else
        breakdance_speed = 0.25;
    
    if (breakdance_speed >= 0.5)
    {
        if (!instance_exists(obj_beatbox))
        {
            windingAnim = 0;
            fmod_studio_event_oneshot_3d("event:/sfx/player/misc/breakdance_start");
            instance_create(x, y, obj_genericpoofeffect);
            
            with (instance_create(x, y - 30, obj_beatbox))
                vsp = -11;
        }
        
        notecreate--;
    }
    
    if (notecreate <= 0 && !shotgunAnim)
    {
        instance_create(x + random_range(-70, 70), y + random_range(-70, obj_cartitlecustene), obj_notes);
        notecreate = 10;
    }
    
    if (character == "P" || character == "N" || character == "T")
    {
        if (machslideAnim == 0 && (landAnim == 0 && shotgunAnim == 0))
        {
            if (move == 0)
            {
                if (idle < 400)
                    idle++;
                
                if (idle >= 150 && floor(image_index) == (image_number - 1))
                {
                    facehurt = 0;
                    idle = 0;
                    image_index = 0;
                }
                
                if (idle >= 150 && (sprite_index != get_charactersprite("spr_idlefrown") && (sprite_index != get_charactersprite("spr_idledance") && (sprite_index != get_charactersprite("spr_handgesture1") && (sprite_index != get_charactersprite("spr_idlefrown") && (sprite_index != get_charactersprite("spr_idledance") && sprite_index != get_charactersprite("spr_handgesture1")))))))
                {
                    if (sprite_index != get_charactersprite("spr_panic") && sprite_index != get_charactersprite("spr_breakdance") && sprite_index != get_charactersprite("spr_fireassend") && !genomode)
                    {
                        randomise();
                        idleanim = random_range(0, 100);
                        
                        if (irandom(100) <= 50)
                            fmod_studio_event_instance_start(idlevoice);
                        
                        if (idleanim <= 16)
                            sprite_index = get_charactersprite("spr_idlefrown");
                        
                        if (idleanim > 16 && idleanim < 32)
                        {
                            sprite_index = get_charactersprite("spr_idledance");
                            fmod_studio_event_oneshot_3d("event:/sfx/player/idlescratch");
                        }
                        
                        if (idleanim > 32 && idleanim < 48)
                            sprite_index = get_charactersprite("spr_handgesture1");
                        
                        if (idleanim > 48 && idleanim < 64)
                            sprite_index = get_charactersprite("spr_idlefrown");
                        
                        if (idleanim > 64 && idleanim < 80)
                            sprite_index = get_charactersprite("spr_idledance");
                        
                        if (idleanim > 80)
                            sprite_index = get_charactersprite("spr_handgesture1");
                        
                        image_index = 0;
                    }
                    else
                    {
                        facehurt = 0;
                        idle = 0;
                    }
                }
                
                if (idle < 150)
                {
                    if (facehurt == 0)
                    {
                        if (sprite_index == get_charactersprite("spr_breakdance"))
                            image_speed = breakdance_speed;
                        else
                            image_speed = 0.35;
                        
                        if (windingAnim < 1800 || (angry == 1 || global.playerhealth == 1))
                        {
                            start_running = 1;
                            movespeed = 0;
                            
                            if (sprite_index != get_charactersprite("spr_fireassend"))
                            {
                                if (breakdance_pressed >= breakdance_max)
                                    sprite_index = get_charactersprite("spr_breakdance");
                                else if (global.minutes == 0 && global.seconds == 0)
                                    sprite_index = get_charactersprite("spr_hurtidle");
                                else if (global.panic == 1 || global.snickchallenge == 1)
                                    sprite_index = get_charactersprite("spr_panic");
                                else if (global.combo >= 50)
                                    sprite_index = get_charactersprite("spr_rageidle");
                                else if (global.combo >= 25)
                                    sprite_index = get_charactersprite("spr_3hpidle");
                                else
                                    sprite_index = get_charactersprite("spr_idle");
                            }
                            
                            if (sprite_index == get_charactersprite("spr_fireassend") && floor(image_index) == (image_number - 1))
                            {
                                if (global.minutes == 0 && global.seconds == 0)
                                    sprite_index = get_charactersprite("spr_hurtidle");
                                else if (global.panic == 1 || global.snickchallenge == 1)
                                    sprite_index = get_charactersprite("spr_panic");
                                else if (global.combo >= 25)
                                    sprite_index = get_charactersprite("spr_3hpidle");
                                else if (global.combo >= 50)
                                    sprite_index = get_charactersprite("spr_rageidle");
                                else
                                    sprite_index = get_charactersprite("spr_idle");
                            }
                        }
                        else if (character == "P" || character == "N" || character == "T")
                        {
                            idle = 0;
                            windingAnim--;
                            sprite_index = get_charactersprite("spr_winding");
                        }
                    }
                    else if (facehurt == 1 && (character == "P" || character == "N" || character == "T"))
                    {
                        windingAnim = 0;
                        
                        if (sprite_index != get_charactersprite("spr_facehurtup") && sprite_index != get_charactersprite("spr_facehurt"))
                            sprite_index = get_charactersprite("spr_facehurtup");
                        
                        if (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_facehurtup"))
                            sprite_index = get_charactersprite("spr_facehurt");
                    }
                }
            }
            
            if (move != 0)
            {
                machslideAnim = 0;
                idle = 0;
                facehurt = 0;
                
                if (breakdance_pressed >= breakdance_max)
                    sprite_index = get_charactersprite("spr_breakdance");
                else if (global.minutes == 0 && global.seconds == 0)
                    sprite_index = get_charactersprite("spr_hurtwalk");
                else if (global.combo >= 25)
                    sprite_index = get_charactersprite("spr_3hpwalk");
                else if (global.combo >= 50)
                    sprite_index = get_charactersprite("spr_ragemove");
                else
                    sprite_index = get_charactersprite("spr_move");
                
                if ((move != 0 && grounded && vsp > 0) && sprite_index != get_charactersprite("spr_breakdance"))
                {
                    if (floor(image_index) == 2 || floor(image_index) == 8)
                    {
                        if (!steppybuffer)
                        {
                            create_particle(x, y + 43, 1, 0);
                            steppybuffer = 1;
                            fmod_studio_event_oneshot_3d("event:/sfx/player/step");
                        }
                    }
                    else
                        steppybuffer = 0;
                }
            }
            
            if (move != 0)
                xscale = move;
        }
    }
    
    if (character == "S")
    {
        if (machslideAnim == 0)
        {
            if (move == 0)
            {
                if (idle < 400)
                    idle++;
                
                if (idle >= 100 && floor(image_index) == (image_number - 1))
                {
                    idle = 0;
                    image_index = 0;
                }
                
                if (idle >= 100 && sprite_index != get_charactersprite("spr_idlefrown"))
                    sprite_index = get_charactersprite("spr_idlefrown");
                
                if (idle < 100)
                    sprite_index = get_charactersprite("spr_idle");
            }
            
            if (move != 0)
            {
                machslideAnim = 0;
                sprite_index = get_charactersprite("spr_move");
                xscale = move;
            }
        }
    }
    
    if (landAnim == 1)
    {
        if (move == 0)
        {
            movespeed = 0;
            sprite_index = get_charactersprite("spr_land");
            
            if (floor(image_index) == (image_number - 1))
                landAnim = 0;
        }
        
        if (move != 0)
        {
            sprite_index = get_charactersprite("spr_land2");
            
            if (floor(image_index) == (image_number - 1))
            {
                landAnim = 0;
                sprite_index = get_charactersprite("spr_move");
                image_index = 0;
            }
        }
    }
    
    if (machslideAnim == 1)
    {
        sprite_index = get_charactersprite("spr_machslideend");
        
        if (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_machslideend"))
            machslideAnim = 0;
    }
    
    if (scr_solid(x + sign(hsp), y) && (xscale == 1 && (move == 1 && !place_meeting(x + 1, y, obj_slope))))
        movespeed = 0;
    
    if (scr_solid(x + sign(hsp), y) && (xscale == -1 && (move == -1 && !place_meeting(x - 1, y, obj_slope))))
        movespeed = 0;
    
    jumpstop = 0;
    
    if (!grounded && !key_jump)
    {
        breakdance_pressed = 0;
        sprite_index = get_charactersprite("spr_fall");
        jumpAnim = 0;
        state = states.jump;
        image_index = 0;
    }
    
    if (key_jump && (grounded && !key_down))
    {
        breakdance_pressed = 0;
        fmod_studio_event_instance_start(jumpsnd);
        sprite_index = get_charactersprite("spr_jump");
        
        with (instance_create(x, y, obj_highjumpcloud2))
            image_xscale = other.xscale;
        
        vsp = -11;
        state = states.jump;
        image_index = 0;
        jumpAnim = 1;
    }
    
    if (grounded && (input_buffer_jump < 8 && (!key_down && (!key_attack && vsp > 0))))
    {
        breakdance_pressed = 0;
        fmod_studio_event_instance_start(jumpsnd);
        sprite_index = get_charactersprite("spr_jump");
        
        with (instance_create(x, y, obj_highjumpcloud2))
            image_xscale = other.xscale;
        
        stompAnim = 0;
        vsp = -11;
        state = states.jump;
        jumpAnim = 1;
        jumpstop = 0;
        image_index = 0;
        freefallstart = 0;
    }
    
    if (((key_down && grounded) || (scr_solid(x, y - 3) && grounded)) && character != "S")
    {
        breakdance_pressed = 0;
        state = states.crouch;
        landAnim = 0;
        crouchAnim = 1;
        image_index = 0;
        idle = 0;
    }
    
    if (move != 0)
    {
        if (movespeed < 6)
            movespeed += 0.5;
        else if (floor(movespeed) == 6)
            movespeed = 6;
    }
    else
        movespeed = 0;
    
    if (movespeed > 6)
        movespeed -= 0.1;
    
    momemtum = 0;
    
    if (move != 0)
    {
        xscale = move;
        
        if (movespeed < 3 && move != 0)
            image_speed = 0.35;
        else if (movespeed > 3 && movespeed < 6)
            image_speed = 0.45;
        else
            image_speed = 0.6;
    }
    
    dograb();
    
    if ((key_special2 || input_buffer_special > 0) && !shotgunAnim && !genomode)
    {
        input_buffer_special = 0;
        do_specialmoves();
    }
    
    if (!genomode)
    {
        if ((key_slap2 || input_buffer_slap > 0) && key_up)
        {
            input_buffer_slap = 0;
            breakdance_pressed = 0;
            state = states.punch;
            image_index = 0;
            sprite_index = get_charactersprite("spr_breakdanceuppercut");
            fmod_studio_event_instance_start(uppercutsnd);
            vsp = -14;
            movespeed = hsp;
        }
    }
    
    if (((key_slap2 || input_buffer_slap > 0) && (shotgunAnim == 1 && key_up)) && !genomode)
    {
        input_buffer_slap = 0;
        breakdance_pressed = 0;
        fmod_studio_event_oneshot_3d("event:/sfx/player/misc/kill");
        state = states.shotgun;
        
        with (instance_create(x, y, obj_pistoleffect))
            image_xscale = other.image_xscale;
        
        image_index = 0;
        sprite_index = spr_shotgunshoot;
        
        if (character == "P")
        {
            instance_create(x + (image_xscale * 20), y + 20, obj_shotgunbullet);
            
            with (instance_create(x + (image_xscale * 20), y + 20, obj_shotgunbullet))
                spdh = 4;
            
            with (instance_create(x + (image_xscale * 20), y + 20, obj_shotgunbullet))
                spdh = -4;
        }
    }
    
    scr_do_geno_shit();
    
    if (key_attack && !place_meeting_solid(x + xscale, y) && (state != states.punch || sprite_index == get_charactersprite("spr_breakdanceuppercut")) && state != states.handstandjump)
    {
        breakdance_pressed = 0;
        
        if (movespeed < 6)
            movespeed = 6;
        
        sprite_index = get_charactersprite("spr_mach1");
        jumpAnim = 1;
        state = states.mach2;
        image_index = 0;
    }
    
    if (move != 0 && ((floor(image_index) == 3 || floor(image_index) == 8) && steppy == 0))
        steppy = 1;
    
    if (move != 0 && (floor(image_index) != 3 && floor(image_index) != 8))
        steppy = 0;
    
    scr_dotaunt();
}
