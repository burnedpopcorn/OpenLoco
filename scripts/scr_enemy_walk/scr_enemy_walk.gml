function scr_enemy_walk()
{
    if (grounded && (!place_meeting(x, y + 1, obj_railh) && !place_meeting(x, y + 1, obj_railh2)))
        hsp = image_xscale * (movespeed + (global.baddiespeed - 1));
    else if (grounded && place_meeting(x, y + 1, obj_railh))
        hsp = (image_xscale * (movespeed + (global.baddiespeed - 1))) - 5;
    else if (grounded && place_meeting(x, y + 1, obj_railh2))
        hsp = (image_xscale * (movespeed + (global.baddiespeed - 1))) + 5;
    else if (object_index != obj_ancho)
        hsp = 0;
    
    sprite_index = walkspr;
    image_speed = 0.35;
    
    if (object_index == obj_waddledee || object_index == obj_shyguy)
        image_speed = (place_meeting(x, y, obj_water) || place_meeting(x, y, obj_waterunder) || place_meeting(x, y, obj_watercurrent)) ? 0.15 : 0.35;
    
    if (((place_meeting_solid(x + sign(hsp), y) && !place_meeting_slope(x + sign(hsp), y + 1)) || (grounded && ((place_meeting_collision(x + sign(hsp), y - 64) || place_meeting_solid(x + sign(hsp), y - 64)) && place_meeting_slope(x, y + 1)))) || place_meeting(x + sign(hsp), y, obj_hallway))
    {
        if (object_index == obj_shyguy)
        {
            image_xscale *= -1;
            image_index = 0;
            sprite_index = spr_forknight_turn;
            state = states.normal;
        }
        else
            image_xscale *= -1;
    }
    
    if (object_index != obj_ancho)
    {
        if (!(place_meeting_collision(x + (image_xscale * 15), y + 31) || place_meeting(x + (image_xscale * 15), y + 31, obj_platform)))
        {
            if (movespeed > 0 && grounded)
            {
                if (object_index == obj_ninja)
                {
                    vsp = -11;
                    image_index = 0;
                    image_xscale = -sign(x - obj_player.x);
                    state = states.charge;
                }
                else if (object_index == obj_shyguy)
                {
                    image_xscale *= -1;
                    image_index = 0;
                    sprite_index = spr_forknight_turn;
                    state = states.normal;
                }
                else if (object_index == obj_zombie)
                {
                    image_xscale *= -1;
                    image_index = 0;
                    sprite_index = spr_forknight_turn;
                    state = states.normal;
                    movealarm = 100;
                }
                else
                    image_xscale *= -1;
            }
        }
    }
    
    if (object_index == obj_zombie)
    {
        var p = instance_nearest(x, y, obj_player);
        
        if (movealarm <= 0)
        {
            if ((p.x >= x && image_xscale == -1) || (p.x < x && image_xscale == 1))
            {
                image_xscale *= -1;
                image_index = 0;
                sprite_index = spr_forknight_turn;
                state = states.normal;
            }
        }
    }
}
