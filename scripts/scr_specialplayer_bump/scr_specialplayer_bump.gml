function scr_specialplayer_bump()
{
    sprite_index = get_charactersprite("spr_wallsplat");
    movespeed = 0;
    hsp = 0;
    vsp = 0;
    
    if (floor(image_index) == (image_number - 1))
    {
        xscale *= -1;
        state = states.normal;
    }
    
    image_speed = 0.35;
}
