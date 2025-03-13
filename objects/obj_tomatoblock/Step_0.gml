with (obj_player)
{
    if (place_meeting(x, y + 1, obj_tomatoblock) && state != states.gameover)
    {
        if (key_jump2)
            obj_player.vsp = -20;
        else
            vsp = -11;
        
        if (state == states.jump)
            sprite_index = get_charactersprite("spr_Sjump");
        
        with (instance_place(x, y + 1, obj_tomatoblock))
        {
            image_index = 0;
            image_speed = 0.35;
        }
    }
}
