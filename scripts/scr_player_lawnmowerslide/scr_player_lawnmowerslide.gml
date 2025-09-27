function scr_player_lawnmowerslide()
{
    hsp = xscale * movespeed;
    movespeed = Approach(movespeed, 0, 0.4);
    
    if (floor(image_index) == (image_number - 1))
    {
        image_speed = 0;
        
        if (grounded)
        {
            sprite_index = get_charactersprite("spr_mowerturnend");
            state = states.lawnmower;
            xscale = -xscale;
            movespeed = 4;
        }
    }
    else
        image_speed = 0.35;
}
