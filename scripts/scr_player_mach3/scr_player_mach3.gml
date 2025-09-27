function scr_player_mach3()
{
    if (windingAnim < 2000)
        windingAnim++;
    
    if (!place_meeting(x, y + 1, obj_railh) && !place_meeting(x, y + 1, obj_railh2))
        hsp = xscale * movespeed;
    else if (place_meeting(x, y + 1, obj_railh))
        hsp = (xscale * movespeed) - 5;
    else if (place_meeting(x, y + 1, obj_railh2))
        hsp = (xscale * movespeed) + 5;
    
    mach2 = 100;
    momemtum = 1;
    
    if (upsidedown)
        move = -(key_right + key_left);
    else
        move = key_right + key_left;
    
    move2 = key_right2 + key_left2;
    
    if (fightball == 1 && global.coop == 1)
    {
        if (object_index == obj_player1)
        {
            x = obj_player2.x;
            y = obj_player2.y;
        }
        
        if (object_index == obj_player2)
        {
            x = obj_player1.x;
            y = obj_player1.y;
        }
    }
    
    scr_player_addslopemomentum(0.095, 0.085 * (sprite_index != get_charactersprite("spr_crazyrun")), true, 12, -4);
    
    if (upsidedown && !grounded && !groundedSlope && !place_meeting_collision(x + hsp, y - 16))
        upsidedown = false;
    
    if (movespeed < 20)
    {
        if (move == xscale)
        {
            if (character == "T")
                movespeed += 0.06;
            else
                movespeed += 0.02;
        }
    }
    
    crouchslideAnim = 1;
    
    if (!key_jump2 && (jumpstop == 0 && vsp < 0.5))
    {
        vsp /= 10;
        jumpstop = 1;
    }
    
    if (grounded && vsp > 0)
        jumpstop = 0;
    
    if (input_buffer_jump < 8 && (can_jump && move != -xscale))
    {
        key_jump2 = false;
        fmod_studio_event_instance_start(jumpsnd);
        sprite_index = get_charactersprite("spr_mach3jump");
        image_index = 0;
        
        if (upsidedown)
        {
            vsp = 11;
            upsidedown = false;
        }
        else
            vsp = -11;
    }
    
    if (fightball == 0)
    {
        if (sprite_index == get_charactersprite("spr_mach3jump") && floor(image_index) == (image_number - 1))
            sprite_index = get_charactersprite("spr_mach4");
        
        if (floor(image_index) == (image_number - 1) && (sprite_index == get_charactersprite("spr_rollgetup") || sprite_index == get_charactersprite("spr_dashpad") || sprite_index == get_charactersprite("spr_mach3hit")))
            sprite_index = get_charactersprite("spr_mach4");
        
        if ((sprite_index == get_charactersprite("spr_mach2jump") || sprite_index == get_charactersprite("spr_Sjumpcancel") || sprite_index == get_charactersprite("spr_walljumpend")) && (grounded && vsp > 0))
            sprite_index = get_charactersprite("spr_mach4");
        
        if (movespeed > 16 && sprite_index != get_charactersprite("spr_crazyrun"))
        {
            flash = 1;
            sprite_index = get_charactersprite("spr_crazyrun");
        }
        else if (movespeed <= 16 && sprite_index == get_charactersprite("spr_crazyrun"))
            sprite_index = get_charactersprite("spr_mach4");
    }
    
    if (sprite_index == get_charactersprite("spr_crazyrun") && !instance_exists(crazyruneffectid))
    {
        with (instance_create(x, y, obj_crazyrunothereffect))
        {
            playerid = other.object_index;
            other.crazyruneffectid = id;
        }
    }
    
    if (sprite_index == get_charactersprite("spr_crazyrun"))
    {
        if (flamecloud_buffer > 0)
            flamecloud_buffer--;
        else
        {
            flamecloud_buffer = 10;
            
            with (instance_create(x, y, obj_dashcloud))
            {
                image_xscale = other.xscale;
                sprite_index = spr_flamecloud;
            }
        }
    }
    
    if (sprite_index == get_charactersprite("spr_mach4") || sprite_index == get_charactersprite("spr_mach3jump") || sprite_index == get_charactersprite("spr_fightball") || sprite_index == get_charactersprite("spr_dashpad") || sprite_index == get_charactersprite("spr_Sjumpcancel"))
        image_speed = 0.4;
    
    if (sprite_index == get_charactersprite("spr_crazyrun"))
        image_speed = 0.75;
    
    if (sprite_index == get_charactersprite("spr_rollgetup") || sprite_index == get_charactersprite("spr_mach3hit"))
        image_speed = 0.4;
    
    if (key_jump)
        input_buffer_jump = 0;
    
    if (key_up && grounded && !upsidedown && !place_meeting(x, y, obj_dashpad))
    {
        sprite_index = get_charactersprite("spr_superjumpprep");
        state = states.Sjumpprep;
        hsp = 0;
        image_index = 0;
    }
    
    if (((!key_attack && fightball == 0 && sprite_index != get_charactersprite("spr_dashpad")) && (grounded && character != "S")) || ((character == "S" && ((move == 0 || move != xscale) && grounded)) && fightball == 0))
    {
        if (upsidedown)
            upsidedown = false;
        
        sprite_index = get_charactersprite("spr_machslidestart");
        fmod_studio_event_instance_start(machslidesnd);
        state = states.machslide;
        image_index = 0;
    }
    
    if (move == -xscale && (grounded && sprite_index != get_charactersprite("spr_dashpad") && (character != "S" && fightball == 0)))
    {
        if (upsidedown)
            upsidedown = false;
        
        fmod_studio_event_instance_start(machdriftsnd);
        sprite_index = get_charactersprite("spr_machslideboost3");
        state = states.machslide;
        image_index = 0;
    }
    
    if (key_down2 && !upsidedown && (fightball == 0 && !place_meeting(x, y, obj_dashpad)))
    {
        particle_set_scale(5, xscale, 1);
        create_particle(x, y, 5, 0);
        flash = 0;
        state = states.tumble;
        vsp = 10;
        image_index = 0;
        
        if (!grounded)
            sprite_index = get_charactersprite("spr_mach2jump");
        else
            sprite_index = get_charactersprite("spr_machroll");
    }
    
    dograb();
    
    if (key_slap2 && genomode && !key_up)
        scr_genoshoot();
    
    if (((key_slap2 || input_buffer_slap > 0) && key_up) && !upsidedown)
    {
        state = states.punch;
        input_buffer_slap = 0;
        image_index = 0;
        sprite_index = get_charactersprite("spr_breakdanceuppercut");
        fmod_studio_event_instance_start(uppercutsnd);
        
        if (grounded)
            vsp = -20;
        else
            vsp = -14;
        
        movespeed = hsp;
    }
    
    if ((key_special2 || input_buffer_special > 0) && !shotgunAnim && !instance_exists(obj_cappy))
    {
        input_buffer_special = 0;
        do_specialmoves();
    }
    
    if (((!grounded && scr_solid(x + sign(hsp), y)) || (grounded && scr_solid(x + sign(hsp), y) && groundedSlope)) && !place_meeting(x + hsp, y, obj_destructibles) && !place_meeting(x + hsp, y, obj_metalblock))
    {
        wallspeed = movespeed;
        grabclimbbuffer = 0;
        
        if (movespeed < 1)
            wallspeed = 1;
        else if (character == "T")
            wallspeed -= vsp;
        else
            wallspeed = movespeed;
        
        state = states.climbwall;
    }
    
    if ((scr_solid(x + sign(hsp), y) && !groundedSlope && !place_meeting(x + sign(hsp), y, obj_metalblock) && !place_meeting(x + sign(hsp), y, obj_destructibles) && (grounded || fightball == 1)) && !upsidedown)
    {
        if (fightball == 0)
        {
            sprite_index = get_charactersprite("spr_mach3hitwall");
            fmod_studio_event_oneshot_3d("event:/sfx/player/bodyslam_land");
            fmod_studio_event_oneshot_3d("event:/sfx/player/misc/bump");
            
            with (obj_camera)
            {
                shake_mag = 20;
                shake_mag_acc = 40 / room_speed;
            }
            
            hsp = 0;
            image_speed = 0.35;
            
            with (obj_baddie)
            {
                if (point_in_rectangle(x, y, __view_get(0, 0), __view_get(1, 0), __view_get(0, 0) + __view_get(2, 0), __view_get(1, 0) + __view_get(3, 0)))
                {
                    stun = 1;
                    alarm[0] = 200;
                    ministun = 0;
                    vsp = -5;
                    hsp = 0;
                }
            }
            
            flash = 0;
            state = states.bump;
            hsp = -4.5 * xscale;
            vsp = -6;
            mach2 = 0;
            image_index = 0;
            instance_create(x - 10, y + 10, obj_bumpeffect);
        }
        else if (fightball == 1)
        {
            with (obj_player)
            {
                sprite_index = get_charactersprite("spr_mach3hitwall");
                fmod_studio_event_oneshot_3d("event:/sfx/player/bodyslam_land");
                fmod_studio_event_oneshot_3d("event:/sfx/player/misc/bump");
                
                with (obj_camera)
                {
                    shake_mag = 20;
                    shake_mag_acc = 40 / room_speed;
                }
                
                hsp = 0;
                image_speed = 0.35;
                
                with (obj_baddie)
                {
                    if (point_in_rectangle(x, y, __view_get(0, 0), __view_get(1, 0), __view_get(0, 0) + __view_get(2, 0), __view_get(1, 0) + __view_get(3, 0)))
                    {
                        stun = 1;
                        alarm[0] = 200;
                        ministun = 0;
                        vsp = -5;
                        hsp = 0;
                    }
                }
                
                flash = 0;
                state = states.bump;
                hsp = -2.5 * xscale;
                vsp = -3;
                mach2 = 0;
                image_index = 0;
                instance_create(x + 10, y + 10, obj_bumpeffect);
            }
            
            fightball = 0;
        }
    }
    
    if (!instance_exists(dashcloudid) && grounded && !place_meeting(x, y + 1, obj_water))
    {
        with (instance_create(x, y, obj_superdashcloud))
        {
            if (other.fightball == 1)
                instance_create(obj_player.x, obj_player.y, obj_slapstar);
            
            image_xscale = other.xscale;
            other.dashcloudid = id;
        }
    }
    
    scr_dotaunt();
    
    if (!instance_exists(chargeeffectid))
    {
        with (instance_create(x, y, obj_chargeeffect))
        {
            playerid = other.object_index;
            other.chargeeffectid = id;
        }
    }
    
    if (genomode)
    {
        sprite_index = get_charactersprite("spr_mach");
        state = states.mach2;
        movespeed = 12;
    }
    
    if (!grounded && input_buffer_jump2 > 10 && key_jump2)
    {
        sprite_index = get_charactersprite("spr_cape");
        vsp = -10;
        cape_vspeed = 10;
        state = states.cape;
        fmod_studio_event_instance_start(capegetsnd);
        flash = true;
    }
}
