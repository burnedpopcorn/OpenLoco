function scr_player_mach2()
{
    if (windingAnim < 2000)
        windingAnim++;
    
    hsp = xscale * movespeed;
    
    if (!place_meeting(x, y + 1, obj_railh) && !place_meeting(x, y + 1, obj_railh2))
        hsp = xscale * movespeed;
    else if (place_meeting(x, y + 1, obj_railh))
        hsp = (xscale * movespeed) - 5;
    else if (place_meeting(x, y + 1, obj_railh2))
        hsp = (xscale * movespeed) + 5;
    
    move2 = key_right2 + key_left2;
    
    if (upsidedown)
        move = -(key_right + key_left);
    else
        move = key_right + key_left;
    
    crouchslideAnim = 1;
    
    if (!key_jump2 && (jumpstop == 0 && vsp < 0.5))
    {
        vsp /= 10;
        jumpstop = 1;
    }
    
    if (grounded && vsp > 0)
        jumpstop = 0;
    
    if (grounded && input_buffer_jump < 8 && (can_jump && (!(move == 1 && xscale == -1) && !(move == -1 && xscale == 1))))
    {
        image_index = 0;
        sprite_index = get_charactersprite("spr_secondjump1");
        fmod_studio_event_instance_start(jumpsnd);
        
        if (upsidedown)
        {
            vsp = 11;
            upsidedown = false;
        }
        else
            vsp = -11;
    }
    
    if (grounded && vsp > 0)
    {
        if (machpunchAnim == 0 && (sprite_index != get_charactersprite("spr_mach") && sprite_index != get_charactersprite("spr_mach1") && (sprite_index != get_charactersprite("spr_mach4") && sprite_index != get_charactersprite("spr_machhit"))))
        {
            if (sprite_index != get_charactersprite("spr_machhit") && sprite_index != get_charactersprite("spr_rollgetup"))
                sprite_index = get_charactersprite("spr_mach");
        }
        
        if (machpunchAnim == 1)
        {
            if (punch == 0)
                sprite_index = get_charactersprite("spr_machpunch1");
            
            if (punch == 1)
                sprite_index = get_charactersprite("spr_machpunch2");
            
            if (floor(image_index) == 4 && sprite_index == get_charactersprite("spr_machpunch1"))
            {
                punch = 1;
                machpunchAnim = 0;
            }
            
            if (floor(image_index) == 4 && sprite_index == get_charactersprite("spr_machpunch2"))
            {
                punch = 0;
                machpunchAnim = 0;
            }
        }
    }
    
    if (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_longjump"))
        sprite_index = get_charactersprite("spr_longjumpend");
    
    if ((!place_meeting_slope(x, y - 1) && !place_meeting_solid(x, y - 1)) && !(place_meeting_slope(x - hsp, y) && place_meeting_solid(x - hsp, y - 16)))
    {
        if (upsidedown)
            upsidedown = false;
    }
    
    if (!grounded)
        machpunchAnim = 0;
    
    scr_player_addslopemomentum(0.095, 0.085, true, 8, noone);
    
    if (grounded)
    {
        if (movespeed < 12)
        {
            if (mach4mode == 0)
                movespeed += 0.1;
            else
                movespeed += 0.2;
        }
        
        var cantmach3 = false;
        
        with (par_plant)
        {
            if (grabber == other.id)
                cantmach3 = true;
        }
        
        if (movespeed >= 12 && global.coop == 0 && !genomode && !cantmach3)
        {
            machhitAnim = 0;
            state = states.mach3;
            flash = 1;
            
            if (sprite_index != get_charactersprite("spr_rollgetup"))
                sprite_index = get_charactersprite("spr_mach4");
            
            with (instance_create(x, y, obj_jumpdust))
                image_xscale = other.xscale;
        }
    }
    
    if (key_jump)
        input_buffer_jump = 0;
    
    if (key_down2 && !upsidedown && (input_down_buffer <= 0 || grounded) && !place_meeting(x, y, obj_dashpad))
    {
        with (instance_create(x, y, obj_jumpdust))
            image_xscale = other.xscale;
        
        flash = 0;
        state = states.tumble;
        vsp = 10;
        image_index = 0;
        
        if (!grounded)
            sprite_index = get_charactersprite("spr_mach2jump");
        else
            sprite_index = get_charactersprite("spr_machroll");
    }
    
    if (!upsidedown && ((groundedSlope && scr_solid(x + sign(hsp), y)) || (!grounded && scr_solid(x + sign(hsp), y) && !place_meeting(x + hsp, y, obj_destructibles))))
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
            wallspeed = movespeed;
            grabclimbbuffer = 0;
            
            if (movespeed < 1)
                wallspeed = 1;
            else
                movespeed = wallspeed;
            
            state = states.climbwall;
        }
    }
    
    if (upsidedown && ((!place_meeting_slope(x, y - 1) && !place_meeting_solid(x, y - 1)) && place_meeting_slope(x - hsp, y)) && place_meeting_solid(x - hsp, y - 16))
    {
        hsp = 0;
        xscale *= -1;
        wallspeed = movespeed;
        grabclimbbuffer = 0;
        
        if (movespeed < 1)
            wallspeed = 1;
        else
            movespeed = wallspeed;
        
        state = states.climbwall;
        upsidedown = false;
    }
    
    if (upsidedown && (place_meeting_solid(x, y - 1) && (place_meeting_solid(x + sign(hsp), y + 64) && (!place_meeting(x + hsp, y, obj_destructibles) && (!place_meeting(x + hsp, y, obj_metalblock) && place_meeting_slope(x, y - 1))))))
    {
        wallspeed = movespeed;
        grabclimbbuffer = 0;
        
        if (movespeed < 1)
            wallspeed = 1;
        else
            movespeed = wallspeed;
        
        state = states.climbwall;
    }
    
    if (grounded && (!scr_slope() && ((place_meeting_collision(x + sign(hsp), y) || place_meeting_solid(x + sign(hsp), y)) && (!place_meeting(x + hsp, y, obj_destructibles) && !place_meeting_slope(x + sign(hsp), y)))))
    {
        var _bump = slope_check_up(x + sign(hsp), y, 32);
        
        if (_bump != 0)
            y -= _bump;
        else
        {
            fmod_studio_event_oneshot_3d("event:/sfx/player/misc/wallsplat");
            state = states.bump;
            image_index = 0;
            sprite_index = get_charactersprite("spr_wallsplat");
        }
    }
    
    if (sprite_index != get_charactersprite("spr_mach2jump"))
        dograb();
    
    if (!instance_exists(dashcloudid) && grounded)
    {
        with (instance_create(x, y, obj_dashcloud))
        {
            image_xscale = other.xscale;
            other.dashcloudid = id;
        }
    }
    
    if (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_mach1"))
        sprite_index = get_charactersprite("spr_mach");
    
    if (grounded && (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_rollgetup")))
        sprite_index = get_charactersprite("spr_mach");
    
    if (!grounded && (sprite_index != get_charactersprite("spr_secondjump2") && sprite_index != get_charactersprite("spr_longjump") && sprite_index != get_charactersprite("spr_dive") && sprite_index != get_charactersprite("spr_longjumpend") && sprite_index != get_charactersprite("spr_mach2jump") && sprite_index != get_charactersprite("spr_mach2jump") && sprite_index != get_charactersprite("spr_walljumpstart") && sprite_index != get_charactersprite("spr_walljumpend")))
        sprite_index = get_charactersprite("spr_secondjump1");
    
    if (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_secondjump1"))
        sprite_index = get_charactersprite("spr_secondjump2");
    
    if (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_walljumpstart"))
        sprite_index = get_charactersprite("spr_walljumpend");
    
    if ((key_special2 || input_buffer_special > 0) && !shotgunAnim && !instance_exists(obj_cappy))
    {
        input_buffer_special = 0;
        do_specialmoves();
    }
    
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
    
    if (key_attack && (!place_meeting(x + xscale, y, obj_solid) && (character == "S" && grounded)))
    {
        state = states.handstandjump;
        movespeed = 0;
    }
    
    scr_dotaunt();
    
    if ((!key_attack && (move != xscale && grounded)) || (character == "S" && (move == 0 && grounded)))
    {
        if (upsidedown)
            upsidedown = false;
        
        if (sprite_index != get_charactersprite("spr_mach1"))
        {
            image_index = 0;
            state = states.machslide;
            fmod_studio_event_instance_start(machslidesnd);
            sprite_index = get_charactersprite("spr_machslidestart");
        }
        else
        {
            movespeed = 0;
            state = states.normal;
        }
    }
    
    if (move == -xscale && movespeed >= 8 && grounded)
    {
        fmod_studio_event_instance_start(machdriftsnd);
        image_index = 0;
        state = states.machslide;
        sprite_index = get_charactersprite("spr_machslideboost");
        
        if (upsidedown)
            upsidedown = false;
    }
    else if (move == -xscale && movespeed < 8 && grounded)
    {
        if (upsidedown)
            upsidedown = false;
        
        xscale *= -1;
        movespeed = 6;
    }
    
    if (key_slap2 && genomode && !key_up)
        scr_genoshoot();
    
    if ((object_index == obj_player1 && (place_meeting(x, y, obj_player2) && (obj_player1.hurted == 0 && obj_player2.hurted == 0))) || (object_index == obj_player2 && (place_meeting(x, y, obj_player1) && (obj_player2.hurted == 0 && obj_player1.hurted == 0))))
    {
        if (object_index == obj_player1)
        {
            obj_player1.state = states.mach3;
            obj_player2.state = states.grabbed;
            obj_player2.xscale = xscale;
            
            if (obj_player1.spotlight == 0)
            {
                obj_camera.shoving = 1;
                obj_camera.image_index = 0;
            }
            
            obj_player1.spotlight = 1;
            scr_changetoppings();
            obj_player1.depth = -7;
            obj_player2.depth = -6;
        }
        
        if (object_index == obj_player2)
        {
            obj_player2.state = states.mach3;
            obj_player1.state = states.grabbed;
            obj_player1.xscale = xscale;
            
            if (obj_player1.spotlight == 1)
            {
                obj_camera.shoving = 1;
                obj_camera.image_index = 0;
            }
            
            obj_player1.spotlight = 0;
            scr_changetoppings();
            obj_player1.depth = -6;
            obj_player2.depth = -7;
        }
        
        obj_player1.image_index = 0;
        obj_player2.image_index = 0;
        obj_player1.sprite_index = get_charactersprite("spr_fightball", obj_player1);
        obj_player2.sprite_index = get_charactersprite("spr_fightball", obj_player2);
        obj_player1.fightball = 1;
        obj_player2.fightball = 1;
    }
    
    if (move == xscale && (!key_attack && grounded))
    {
        if (upsidedown)
            upsidedown = false;
        
        state = states.normal;
    }
    
    if (sprite_index == get_charactersprite("spr_mach2jump"))
        image_speed = 0.65;
    else if (sprite_index == get_charactersprite("spr_rollgetup") || sprite_index == get_charactersprite("spr_longjumpend") || sprite_index == get_charactersprite("spr_longjump") || sprite_index == get_charactersprite("spr_suplexdash"))
        image_speed = 0.4;
    else
        image_speed = abs(movespeed) / 15;
}
