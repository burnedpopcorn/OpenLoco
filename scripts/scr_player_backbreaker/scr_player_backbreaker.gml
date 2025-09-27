function scr_player_backbreaker()
{
    if (!styledtaunting)
    {
        mach2 = 0;
        
        if (sprite_index != get_charactersprite("spr_machfreefall"))
        {
            hsp = 0;
            movespeed = 0;
        }
        else
            hsp = xscale * movespeed;
        
        landAnim = 0;
        
        if (sprite_index == get_charactersprite("spr_machfreefall") && place_meeting(x, y + 1, obj_solid))
        {
            state = states.machslide;
            taunt_resetvariables();
            sprite_index = get_charactersprite("spr_crouchslide");
        }
        
        if (sprite_index == get_charactersprite("spr_taunt") || sprite_index == get_charactersprite("spr_supertaunt1") || sprite_index == get_charactersprite("spr_supertaunt2") || sprite_index == get_charactersprite("spr_supertaunt3") || sprite_index == get_charactersprite("spr_supertaunt4"))
        {
            if (!instance_exists(parry_inst) && taunttimer > parry_max)
            {
                parry_inst = instance_create(x, y, obj_parryhitbox);
                var _playerid = 1;
                
                if (object_index == obj_player2)
                    _playerid = 2;
                
                with (parry_inst)
                {
                    player_id = _playerid;
                    image_xscale = other.xscale;
                }
            }
            
            if (taunttimer < taunt_to_parry_max)
            {
                if (instance_exists(parry_inst))
                {
                    instance_destroy(parry_inst);
                    parry_inst = noone;
                }
            }
            
            if (supercharged == 1 && key_up && sprite_index == get_charactersprite("spr_taunt"))
            {
                fmod_studio_event_instance_stop(tauntsnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
                sprite_index = choose(get_charactersprite("spr_supertaunt1"), get_charactersprite("spr_supertaunt2"), get_charactersprite("spr_supertaunt3"), get_charactersprite("spr_supertaunt4"));
                image_index = 0;
                image_speed = 0.35;
                fmod_studio_event_instance_start(supertauntsnd);
            }
            
            if (supercharged == 1 && (sprite_index == get_charactersprite("spr_supertaunt1") || sprite_index == get_charactersprite("spr_supertaunt2") || sprite_index == get_charactersprite("spr_supertaunt3") || sprite_index == get_charactersprite("spr_supertaunt4")) && !instance_exists(obj_tauntaftereffectspawner))
            {
                instance_create(x, y, obj_tauntaftereffectspawner);
                var lag = 20;
                global.combofreeze = 20;
                
                with (obj_baddie)
                {
                    if (point_in_camera(x, y, view_camera[0]))
                    {
                        hp = -99;
                        state = states.hit;
                        hitLag = lag;
                        hitX = x;
                        hitY = y;
                        
                        if (elite)
                        {
                            elitehit = -1;
                            mach3destroy = 1;
                        }
                        
                        instance_create(x, y, obj_parryeffect);
                        alarm[3] = 3;
                        instance_create(x, y, obj_slapstar);
                        instance_create(x, y, obj_slapstar);
                        instance_create(x, y, obj_slapstar);
                        instance_create(x, y, obj_baddiegibs);
                        instance_create(x, y, obj_baddiegibs);
                        instance_create(x, y, obj_baddiegibs);
                        
                        with (obj_camera)
                        {
                            shake_mag = 3;
                            shake_mag_acc = 3 / room_speed;
                        }
                    }
                }
                
                with (obj_camera)
                {
                    shake_mag = 10;
                    shake_mag_acc = 30 / room_speed;
                }
                
                supercharge = 0;
                supercharged = 0;
            }
            
            taunttimer--;
            vsp = 0;
        }
        
        if (floor(image_index) == (image_number - 1) && (sprite_index == get_charactersprite("spr_supertaunt1") || sprite_index == get_charactersprite("spr_supertaunt2") || sprite_index == get_charactersprite("spr_supertaunt3") || sprite_index == get_charactersprite("spr_supertaunt4")))
        {
            movespeed = tauntstoredmovespeed;
            sprite_index = tauntstoredsprite;
            state = tauntstoredstate;
            image_index = tauntstoredindex;
            vsp = tauntstoredvsp;
            supercharge = 0;
            supercharged = 0;
            
            if (instance_exists(parry_inst))
            {
                instance_destroy(parry_inst);
                parry_inst = noone;
            }
            
            taunt_resetvariables();
        }
        
        if (taunttimer <= 0 && sprite_index == get_charactersprite("spr_taunt"))
        {
            movespeed = tauntstoredmovespeed;
            sprite_index = tauntstoredsprite;
            state = tauntstoredstate;
            image_index = tauntstoredindex;
            vsp = tauntstoredvsp;
            
            if (instance_exists(parry_inst))
            {
                instance_destroy(parry_inst);
                parry_inst = noone;
            }
            
            taunt_resetvariables();
        }
        
        if (floor(image_index) == (image_number - 1) && (sprite_index == get_charactersprite("spr_timesup") && place_meeting(x, y, obj_exitgate)))
        {
            state = states.normal;
            taunt_resetvariables();
        }
        
        if (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_levelcomplete"))
        {
            state = states.normal;
            taunt_resetvariables();
        }
        
        if (key_jump && sprite_index == get_charactersprite("spr_phoneidle"))
        {
            global.panic = 1;
            sprite_index = get_charactersprite("spr_bossintro");
            image_index = 0;
            
            with (instance_create(x, y, obj_debris))
            {
                image_index = 0;
                sprite_index = spr_phonedebris;
            }
        }
        
        if (global.miniboss == 1 && (sprite_index == get_charactersprite("spr_bossintro") && floor(image_index) == (image_number - 1)))
        {
            state = states.normal;
            taunt_resetvariables();
        }
        
        image_speed = 0.35;
    }
    else
    {
        sprite_index = get_charactersprite("spr_mowertaunt");
        hsp = xscale * movespeed;
        landAnim = 0;
        
        if (key_taunt2)
        {
            styledtaunts++;
            fmod_studio_event_instance_stop(styledtauntsnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
            fmod_studio_event_instance_start(styledtauntsnd);
            image_index = random_range(0, sprite_get_width(sprite_index) - 1);
            
            with (instance_create(x, y, obj_taunteffect))
            {
                player = other.id;
                image_speed = 0.65;
            }
        }
        
        if (grounded)
        {
            fmod_studio_event_instance_stop(styledtauntsnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
            fmod_studio_event_instance_start(styledtauntsnd);
            room_speed = 60;
            state = tauntstoredstate;
            sprite_index = tauntstoredsprite;
            image_index = tauntstoredindex;
            movespeed = tauntstoredmovespeed + styledtaunts;
            
            if (movespeed > 18)
                movespeed = 18;
            
            flash = 1;
            styledtaunts = 0;
            styledtaunting = 0;
            obj_camera.zoom = 1;
            obj_camera.spdzooming = 0.3;
            taunt_resetvariables();
        }
        
        if (scr_solid(x + sign(hsp), y))
        {
            fmod_studio_event_instance_stop(styledtauntsnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
            fmod_studio_event_instance_start(styledtauntsnd);
            room_speed = 60;
            sprite_index = get_charactersprite("spr_mach2jump");
            image_speed = 0.35;
            image_index = 0;
            hsp = 0;
            state = states.bump;
            
            with (instance_create(x, y, obj_explosioneffect))
                sprite_index = spr_bombexplosion;
            
            flash = 1;
            hsp = -5.5 * xscale;
            vsp = -6;
            styledtaunts = 0;
            styledtaunting = 0;
            obj_camera.zoom = 1;
            obj_camera.spdzooming = 0.3;
            taunt_resetvariables();
        }
    }
}
