function scr_player_zombieattack()
{
    image_speed = 0.35;
    
    if (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_zombieattackairtrans1"))
        sprite_index = get_charactersprite("spr_zombieattackair1");
    
    move = key_left + key_right;
    
    if (grounded)
        hsp = movespeed * xscale;
    else
        hsp = movespeed;
    
    if (!grounded)
    {
        if (move != 0)
            movespeed = Approach(movespeed, move * 6, 0.5);
        else
            movespeed = Approach(movespeed, 0, 0.25);
    }
    else
        movespeed = Approach(movespeed, 0, 0.25);
    
    if (sprite_index == get_charactersprite("spr_zombieattack") && floor(image_index) == (image_number - 1))
    {
        state = states.zombie;
        sprite_index = get_charactersprite("spr_zombieidle");
    }
    
    if ((sprite_index == get_charactersprite("spr_zombieattackairtrans1") || sprite_index == get_charactersprite("spr_zombieattackair1")) && (grounded && vsp >= 0))
    {
        if (move != 0)
            xscale = move;
        
        movespeed = abs(movespeed);
        state = states.zombie;
        image_index = 0;
        sprite_index = get_charactersprite("spr_zombieland");
    }
}
