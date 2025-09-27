function scr_player_kungfu()
{
    image_speed = 0.35;
    hsp = movespeed * xscale;
    move = key_right + key_left;
    
    if (move == xscale)
        movespeed = Approach(movespeed, 24, 0.12);
    else if (move == -xscale)
        movespeed = Approach(movespeed, -5, 1);
    
    var kung = sprite_index == get_charactersprite("spr_kungfu1") || sprite_index == get_charactersprite("spr_kungfu2") || sprite_index == get_charactersprite("spr_kungfu3");
    var kungAir = sprite_index == get_charactersprite("spr_kungfuair1") || sprite_index == get_charactersprite("spr_kungfuair2") || sprite_index == get_charactersprite("spr_kungfuair3") || sprite_index == get_charactersprite("spr_kungfuair1transition") || sprite_index == get_charactersprite("spr_kungfuair2transition") || sprite_index == get_charactersprite("spr_kungfuair3transition");
    
    if (grounded && kungAir)
        kungfu_transition();
    
    if (floor(image_index) == (image_number - 1))
    {
        if (kungAir)
        {
            if (sprite_index == get_charactersprite("spr_kungfuair1transition"))
                sprite_index = get_charactersprite("spr_kungfuair1");
            
            if (sprite_index == get_charactersprite("spr_kungfuair2transition"))
                sprite_index = get_charactersprite("spr_kungfuair2");
            
            if (sprite_index == get_charactersprite("spr_kungfuair3transition"))
                sprite_index = get_charactersprite("spr_kungfuair3");
        }
        else
            kungfu_transition();
    }
    
    if (scr_solid(x + xscale, y) && !place_meeting(x + sign(hsp), y, obj_destructibles))
    {
        vsp = -4;
        sprite_index = get_charactersprite("spr_kungfujump");
        image_index = 0;
        state = states.punch;
        movespeed = -6;
    }
}

function kungfu_transition()
{
    if (key_attack)
    {
        if (movespeed >= 12)
        {
            state = states.mach3;
            sprite_index = get_charactersprite("spr_mach4");
        }
        else
        {
            if (movespeed < 0)
                movespeed = 8;
            
            state = states.mach2;
            sprite_index = get_charactersprite("spr_mach");
        }
    }
    else
    {
        if (movespeed < 0 || movespeed > 6)
            movespeed = 6;
        
        state = states.normal;
    }
}
