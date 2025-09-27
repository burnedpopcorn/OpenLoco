function scr_player_punch()
{
    var _Sjumpcancel = sprite_index == get_charactersprite("spr_Sjumpcancel");
    var _kungfumove = sprite_index == get_charactersprite("spr_kungfujump") || sprite_index == get_charactersprite("spr_kungfu1");
    var _breakdanceuppercut = sprite_index == get_charactersprite("spr_breakdanceuppercut") || sprite_index == get_charactersprite("spr_spinjump") || sprite_index == get_charactersprite("spr_breakdanceuppercutend");
    move = key_left + key_right;
    
    if (!_kungfumove && !_Sjumpcancel && _breakdanceuppercut)
    {
        move = key_left + key_right;
        landAnim = 1;
        jumpstop = 0;
        image_speed = 0.4;
        
        if (move != 0 && sign(move) != xscale)
            movespeed = move * 6;
        
        hsp = Approach(hsp, movespeed, 1);
        
        if (move != 0)
            xscale = sign(move);
        
        if (key_slap2)
        {
            sprite_index = get_charactersprite("spr_suplexgrabjumpstart");
            state = states.handstandjump;
            exit;
        }
        
        if (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_breakdanceuppercut"))
            sprite_index = get_charactersprite("spr_breakdanceuppercutend");
        
        if (grounded)
        {
            movespeed = abs(movespeed);
            state = states.normal;
        }
        
        with (instance_place(x, y, obj_baddie))
        {
            other.vsp = -10;
            instance_create(x, y, obj_stompeffect);
            fmod_studio_event_oneshot_3d("event:/sfx/enemy/stomped");
            instance_destroy();
        }
    }
    
    if ((_kungfumove || _Sjumpcancel) && !_breakdanceuppercut)
    {
        if (move != 0)
        {
            if (move != xscale && movespeed > -6)
            {
                if (sprite_index != get_charactersprite("spr_kungfujump"))
                    movespeed -= 1;
                else
                    movespeed -= 0.1;
            }
            else if (move == xscale && movespeed < 6 && sprite_index == get_charactersprite("spr_kungfujump"))
                movespeed += 0.2;
        }
    }
    
    if (!_kungfumove && !_Sjumpcancel && !_breakdanceuppercut)
    {
        if (grounded)
        {
            if (dir != xscale)
            {
                dir = xscale;
                movespeed = 2;
                facehurt = 0;
            }
            
            jumpstop = 0;
            anger = 100;
            
            if (!place_meeting(x, y + 1, obj_railh) && !place_meeting(x, y + 1, obj_railh2))
                hsp = move * movespeed;
            else if (place_meeting(x, y + 1, obj_railh))
                hsp = (move * movespeed) - 5;
            else if (place_meeting(x, y + 1, obj_railh2))
                hsp = (move * movespeed) + 5;
            
            if (move != 0)
            {
                if (movespeed < 7)
                    movespeed += 0.5;
                else if (floor(movespeed) == 7)
                    movespeed = 7;
            }
            else
                movespeed = 0;
            
            if (movespeed > 7)
                movespeed -= 0.1;
            
            if (move != 0)
            {
                if (movespeed < 3 && move != 0)
                    image_speed = 0.35;
                else if (movespeed > 3 && movespeed < 6)
                    image_speed = 0.45;
                else
                    image_speed = 0.6;
            }
            else
                image_speed = 0.35;
        }
        
        if (!grounded)
        {
            if (momemtum == 0)
                hsp = move * movespeed;
            else
                hsp = xscale * movespeed;
            
            if (move != xscale && (momemtum == 1 && movespeed != 0))
                movespeed -= 0.05;
            
            if (movespeed == 0)
                momemtum = 0;
            
            if ((move == 0 && momemtum == 0) || scr_solid(x + hsp, y))
            {
                movespeed = 0;
                mach2 = 0;
            }
            
            if (move != 0 && movespeed < 7)
                movespeed += 0.25;
            
            if (movespeed > 7)
                movespeed -= 0.05;
            
            if ((scr_solid(x + 1, y) && move == 1) || (scr_solid(x - 1, y) && move == -1))
                movespeed = 0;
            
            if (dir != xscale)
            {
                mach2 = 0;
                dir = xscale;
                movespeed = 0;
            }
            
            if (move == -xscale)
            {
                mach2 = 0;
                movespeed = 0;
                momemtum = 0;
            }
            
            landAnim = 1;
            
            if (!key_jump2 && (jumpstop == 0 && (vsp < 0.5 && stompAnim == 0)))
            {
                vsp /= 5;
                jumpstop = 1;
            }
            
            if (ladderbuffer > 0)
                ladderbuffer--;
            
            if (scr_solid(x, y - 1) && (jumpstop == 0 && jumpAnim == 1))
            {
                vsp = grav;
                jumpstop = 1;
            }
        }
        
        jumpAnim = 1;
        dashAnim = 1;
        landAnim = 0;
        moveAnim = 1;
        stopAnim = 1;
        crouchslideAnim = 1;
        crouchAnim = 1;
        
        if (floor(image_index) == (image_number - 1) || move == -xscale)
            state = states.normal;
        
        sprite_index = get_charactersprite("spr_punch");
        image_speed = 0.35;
    }
    
    if (_Sjumpcancel && !_kungfumove && !_breakdanceuppercut)
    {
        hsp = movespeed * xscale;
        
        if (grounded && vsp > 0)
        {
            if (key_attack)
            {
                if (movespeed >= 12)
                    state = states.mach3;
                else
                    state = states.mach2;
                
                sprite_index = get_charactersprite("spr_rollgetup");
                image_index = 0;
            }
            else if (movespeed > 6)
            {
                state = states.machslide;
                sprite_index = get_charactersprite("spr_machslidestart");
                image_index = 0;
            }
            else
                state = states.normal;
        }
    }
    
    if (sprite_index != get_charactersprite("spr_kungfujump") && !_breakdanceuppercut && place_meeting(x + xscale, y, obj_destructibles) && !place_meeting(x + xscale, y, obj_slope))
    {
        vsp = -4;
        sprite_index = get_charactersprite("spr_kungfujump");
        state = states.punch;
        movespeed = -6;
    }
    
    if (!_Sjumpcancel && _kungfumove)
    {
        hsp = movespeed * xscale;
        
        if (grounded && vsp >= 0)
            state = states.normal;
    }
}
