function scr_player_fireass()
{
    image_speed = 0.35;
    alarm[5] = 2;
    alarm[7] = 60;
    
    if (sprite_index == get_charactersprite("spr_fireass"))
    {
        if (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_fireass"))
            create_particle(x, y + 25, 7, 0);
        
        move = key_left + key_right;
        hsp = movespeed;
        
        if (place_meeting(x + hsp, y, obj_solid))
        {
            instance_create(x + (xscale * 10), y + 10, obj_bumpeffect);
            xscale *= -1;
            movespeed *= -1;
        }
        
        if (move != 0)
        {
            if (move == xscale)
                movespeed = Approach(movespeed, xscale * 8, 0.5);
            else
                movespeed = Approach(movespeed, 0, 0.5);
            
            if (movespeed <= 0)
                xscale = move;
        }
        else
            movespeed = Approach(movespeed, 0, 0.1);
        
        if (place_meeting(x, y + 1, obj_haystack))
            vsp = -20;
        else if (grounded && vsp > 0)
        {
            movespeed = 6;
            
            if (sprite_index == get_charactersprite("spr_fireass"))
                sprite_index = get_charactersprite("spr_fireassground");
            else
            {
                movespeed = 0;
                landAnim = 0;
                alarm[5] = 2;
                alarm[7] = 60;
                hurted = 1;
                state = states.normal;
                sprite_index = get_charactersprite("spr_idle");
                image_index = 0;
            }
            
            image_index = 0;
        }
    }
    
    if (sprite_index == get_charactersprite("spr_fireassground"))
    {
        hsp = xscale * movespeed;
        
        if (movespeed > 0)
            movespeed -= 0.25;
        
        if (place_meeting(x + hsp, y, obj_solid))
        {
            instance_create(x + (xscale * 10), y + 10, obj_bumpeffect);
            xscale *= -1;
        }
        
        if (floor(image_index) == (image_number - 1))
        {
            movespeed = 0;
            landAnim = 0;
            alarm[5] = 2;
            alarm[7] = 60;
            hurted = 1;
            state = states.normal;
            sprite_index = get_charactersprite("spr_fireassend");
            image_index = 0;
        }
    }
    
    if (sprite_index == get_charactersprite("spr_fireassend"))
    {
        if (floor(image_index) == (image_number - 1))
        {
            movespeed = 0;
            landAnim = 0;
            alarm[5] = 2;
            alarm[7] = 60;
            hurted = 1;
            state = states.normal;
            sprite_index = get_charactersprite("spr_idle");
            image_index = 0;
        }
    }
}
