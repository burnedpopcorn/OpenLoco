function scr_player_bump()
{
    if (sprite_index != get_charactersprite("spr_wallsplat"))
    {
        movespeed = 0;
        mach2 = 0;
        start_running = 1;
        
        if (grounded && vsp > 0)
            hsp = 0;
        
        alarm[4] = 14;
        image_speed = 0.35;
        
        if (sprite_index == get_charactersprite("spr_tumbleend") && floor(image_index) >= 3 && !grounded)
            image_index = 3;
        
        if (floor(image_index) == (image_number - 1) && (grounded || sprite_index == get_charactersprite("spr_mach3hitwall")))
            state = states.normal;
        
        if (grounded && sprite_index == get_charactersprite("spr_mach2jump"))
            image_index = image_number - 1;
        
        if (sprite_index != get_charactersprite("spr_catched") && (sprite_index != get_charactersprite("spr_tumbleend") && sprite_index != get_charactersprite("spr_mach2jump") && sprite_index != get_charactersprite("spr_wallsplat") && sprite_index != get_charactersprite("spr_mach3hitwall")))
            sprite_index = get_charactersprite("spr_bump");
    }
    else
    {
        sprite_index = get_charactersprite("spr_wallsplat");
        movespeed = 0;
        hsp = 0;
        vsp = 0;
        
        if (floor(image_index) == (image_number - 1))
            state = states.normal;
        
        image_speed = 0.35;
    }
}
