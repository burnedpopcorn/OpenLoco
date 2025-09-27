function scr_player_grab()
{
    var _swingding = get_charactersprite("spr_swingding");
    var _haulingidle = get_charactersprite("spr_haulingidle");
    var _haulingwalk = get_charactersprite("spr_haulingwalk");
    var _haulingstart = get_charactersprite("spr_haulingstart");
    var _haulingjump = get_charactersprite("spr_haulingjump");
    var _haulingfall = get_charactersprite("spr_haulingfall");
    var _haulingland = get_charactersprite("spr_haulingland");
    grav = 0.5;
    move = key_left + key_right;
    
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
        
        if (!place_meeting(x, y + 1, obj_grindrail))
        {
            if (sprite_index != _swingding)
                hsp = move * movespeed;
            else
                hsp = xscale * movespeed;
        }
        else
        {
            var _railinst = instance_place(x, y + 1, obj_grindrail);
            hsp = (move * movespeed) + (_railinst.movespeed * _railinst.dir);
        }
        
        if (heavy == 0)
        {
            if (sprite_index != _swingding)
            {
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
            }
        }
        else
        {
            if (move != 0)
            {
                if (movespeed < 4)
                    movespeed += 0.25;
                else if (floor(movespeed) == 4)
                    movespeed = 4;
            }
            else
                movespeed = 0;
            
            if (movespeed > 4)
                movespeed -= 0.1;
        }
        
        if (move != 0 && sprite_index != _swingding)
            xscale = move;
        
        if (move != 0)
        {
            if (sprite_index != _swingding)
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
    }
    
    if (sprite_index != _swingding)
    {
        if (!grounded)
        {
            if (dir != xscale && sprite_index != _swingding)
            {
                dir = xscale;
                movespeed = 2;
                facehurt = 0;
            }
            
            if (move != 0 && move != xscale && sprite_index != _swingding)
                movespeed = 2;
            
            if (momemtum == 0)
                hsp = move * movespeed;
            else
                hsp = xscale * movespeed;
            
            if (move != 0 && move != xscale && momemtum == 1 && movespeed != 0)
                movespeed -= 0.05;
            
            if (movespeed == 0)
                momemtum = 0;
            
            if (move != 0 && movespeed < 6)
                movespeed += 0.5;
            
            if (movespeed > 6)
                movespeed -= 0.5;
            
            if (scr_solid(x + move, y) && move != 0)
                movespeed = 0;
        }
        
        if (dir != xscale)
        {
            dir = xscale;
            movespeed = 2;
            facehurt = 0;
        }
        
        if (move == -xscale)
        {
            mach2 = 0;
            momemtum = 0;
        }
        
        landAnim = 1;
        
        if (!key_jump2 && jumpstop == 0 && vsp < 0.5 && stompAnim == 0)
        {
            vsp /= 20;
            jumpstop = 1;
        }
        
        if (ladderbuffer > 0)
            ladderbuffer--;
        
        if (scr_solid(x, y - 1) && jumpstop == 0 && jumpAnim == 1)
        {
            vsp = grav;
            jumpstop = 1;
        }
        
        if (move != 0 && sprite_index != _swingding)
            xscale = move;
    }
    else
    {
        if (grounded)
            movespeed = Approach(movespeed, 0, 0.25);
        
        if (movespeed <= 0)
            sprite_index = _haulingidle;
        
        hsp = xscale * movespeed;
        swingdingendcooldown++;
        
        if (scr_solid(x + xscale, y) && !place_meeting(x + sign(hsp), y, obj_destructibles))
        {
            vsp = -4;
            sprite_index = get_charactersprite("spr_kungfujump");
            image_index = 0;
            state = states.punch;
            movespeed = -6;
        }
        
        with (instance_place(x + xscale, y, obj_destructibles))
            instance_destroy();
    }
    
    if (movespeed == 2 && sprite_index == _swingding)
        sprite_index = _haulingidle;
    
    if (key_jump)
        input_buffer_jump = 0;
    
    if (grounded && input_buffer_jump < 8 && !key_down && !key_attack && vsp > 0 && sprite_index != _swingding)
    {
        fmod_studio_event_instance_start(jumpsnd);
        sprite_index = _haulingjump;
        instance_create(x, y, obj_highjumpcloud2);
        
        if (heavy == 0)
            vsp = -11;
        else
            vsp = -6;
        
        image_index = 0;
    }
    
    if (grounded && (move != 0 && sprite_index == _haulingidle))
        sprite_index = _haulingwalk;
    else if (grounded && (move == 0 && sprite_index == _haulingwalk))
        sprite_index = _haulingidle;
    
    if (sprite_index == _haulingstart && floor(image_index) == (image_number - 1))
        sprite_index = _haulingidle;
    
    if ((sprite_index == _haulingjump && floor(image_index) == (image_number - 1)) || (!grounded && (sprite_index == _haulingwalk || sprite_index == _haulingidle)))
        sprite_index = _haulingfall;
    
    if (grounded && (vsp > 0 && (sprite_index == _haulingfall || sprite_index == _haulingjump)))
    {
        sprite_index = _haulingland;
        movespeed = 2;
    }
    
    if (sprite_index == _haulingland && floor(image_index) == (image_number - 1))
        sprite_index = _haulingidle;
    
    if (swingdingbuffer > 0)
        swingdingbuffer -= 1;
    
    if ((key_slap2 || input_buffer_slap > 0) && sprite_index != _swingding)
    {
        input_buffer_slap = 0;
        
        if (move != 0)
            move = xscale;
        
        movespeed = hsp;
        state = 3;
        
        if (sprite_index == _swingding)
            sprite_index = get_charactersprite("spr_swingdingend");
        else if (!key_up)
            sprite_index = choose(get_charactersprite("spr_finishingblow1"), get_charactersprite("spr_finishingblow2"), get_charactersprite("spr_finishingblow3"), get_charactersprite("spr_finishingblow4"), get_charactersprite("spr_finishingblow5"));
        else if (key_up)
            sprite_index = get_charactersprite("spr_uppercutfinishingblow");
        
        image_index = 0;
    }
    else if ((key_slap2 || input_buffer_slap > 0) && sprite_index == _swingding && swingdingendcooldown > 20)
    {
        input_buffer_slap = 0;
        
        if (move != 0)
            move = xscale;
        
        hsp = xscale * movespeed;
        movespeed = hsp;
        swingdingendcooldown = 0;
        state = 3;
        sprite_index = get_charactersprite("spr_swingdingend");
        image_index = 0;
    }
    
    if (key_down && !grounded)
    {
        sprite_index = get_charactersprite("spr_piledriver");
        vsp = -5;
        state = states.superslam;
        image_index = 0;
        image_speed = 0.35;
    }
    
    if (!instance_exists(obj_cloudeffect) && (grounded && (move != 0 && (floor(image_index) == 4 || floor(image_index) == 10))))
        instance_create(x, y + 43, obj_cloudeffect);
    
    if (key_down && grounded && sprite_index != _swingding && sprite_index != get_charactersprite("spr_swingdingend"))
    {
        state = states.crouch;
        landAnim = 0;
        crouchAnim = 1;
        image_index = 0;
        idle = 0;
    }
    
    if (move != 0 && ((floor(image_index) == 3 || floor(image_index) == 8) && steppy == 0))
        steppy = 1;
    
    if (move != 0 && (floor(image_index) != 3 && floor(image_index) != 8))
        steppy = 0;
    
    if (sprite_index != _swingding)
        image_speed = 0.35;
    else
        image_speed = 0.5;
    
    var canmachrun = false;
    
    with (par_plant)
    {
        if (grabber == other.id)
            canmachrun = true;
    }
    
    if (key_attack && canmachrun)
        state = states.mach2;
}
