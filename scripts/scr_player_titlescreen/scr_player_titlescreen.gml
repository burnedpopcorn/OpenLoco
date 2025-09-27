function scr_player_titlescreen()
{
    if (object_index == obj_player1)
        targetDoor = "A";
    
    if (sprite_index == spr_pepcooter && !instance_exists(obj_superdashcloud))
        instance_create(x - 100, y, obj_superdashcloud);
    
    if (instance_exists(obj_textbox))
    {
        if (x != xprevious)
        {
            sprite_index = get_charactersprite("spr_move");
            xscale = -sign(xprevious - x);
        }
        else if (sprite_index != get_charactersprite("spr_idle"))
        {
            sprite_index = get_charactersprite("spr_idle");
            xscale *= -1;
        }
    }
    else
        sprite_index = get_charactersprite("spr_idle");
    
    image_speed = 0.35;
}
