function scr_specialplayer_slide()
{
    hsp = xscale * movespeed;
    movespeed = Approach(movespeed, 0, 0.4);
    
    if (floor(image_index) == (image_number - 1) && (sprite_index == get_charactersprite("spr_machslideboost") || sprite_index == get_charactersprite("spr_machslideboost3")))
        image_speed = 0;
    else
        image_speed = 0.35;
    
    if (movespeed == 0 && floor(image_index) == (image_number - 1) && grounded)
    {
        state = states.normal;
        movespeed = 2;
        xscale *= -1;
    }
}
