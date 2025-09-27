function scr_player_shotgun()
{
    image_speed = 0.4;
    move = key_left + key_right;
    hsp = xscale * movespeed;
    
    if (place_meeting(x + hsp, y, obj_solid) && !place_meeting(x + hsp, y, obj_slope))
        movespeed = 0;
    
    if (move != 0)
    {
        if (move == xscale)
            movespeed = Approach(movespeed, 4, 0.25);
        else
            movespeed = Approach(movespeed, -8, 0.2);
    }
    else
        movespeed = Approach(movespeed, 0, 0.1);
    
    if (floor(image_index) == (image_number - 1) && !instance_exists(obj_genobeam))
    {
        if (grounded)
        {
            image_index = 0;
            sprite_index = get_charactersprite("spr_idle");
            state = states.normal;
        }
        else
        {
            image_index = 0;
            sprite_index = get_charactersprite("spr_fall");
            state = states.jump;
        }
        
        if (move == -xscale)
        {
            xscale = move;
            dir = xscale;
            movespeed = abs(movespeed);
            momemtum = 1;
        }
    }
    
    if (instance_exists(obj_genobeam))
        image_index = 0;
    
    if ((key_slap2 && genomode) && genodelay == 0 && !instance_exists(obj_genobeam))
        scr_genoshoot();
}
