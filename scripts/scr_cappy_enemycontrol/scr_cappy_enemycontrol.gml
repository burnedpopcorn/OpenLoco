function scr_cappy_enemycontrol()
{
    var nearest_enemy = instance_nearest(x, y, obj_baddie);
    
    if (instance_exists(nearest_enemy))
    {
        x = nearest_enemy.x;
        y = nearest_enemy.y;
        image_xscale = nearest_enemy.image_xscale;
        
        with (nearest_enemy)
        {
            hsp = 0;
            movespeed = 0;
            sprite_index = stunfallspr;
        }
    }
    
    with (player_id)
    {
        if (!place_meeting(x, y, nearest_enemy) && instance_exists(nearest_enemy))
        {
            state = states.actor;
            movespeed = 0;
            hsp = 0;
            vsp = 0;
            sprite_index = get_charactersprite("spr_spinjump");
            image_alpha = 0.3;
            y = Approach(y, nearest_enemy.y, 35);
            x = Approach(x, nearest_enemy.x, 35);
            move = key_left + key_right;
        }
        else if (place_meeting(x, y, nearest_enemy))
        {
            image_alpha = 1;
            other.state = cappystates.comeback;
            x = nearest_enemy.x;
            y = nearest_enemy.y;
            instance_destroy(nearest_enemy);
            
            if (key_attack)
            {
                state = states.mach3;
                movespeed = 12;
                
                if (key_jump)
                {
                    vsp = -11;
                    sprite_index = get_charactersprite("spr_mach2jump");
                }
                else
                    sprite_index = get_charactersprite("spr_mach4");
            }
            else
            {
                state = states.jump;
                sprite_index = get_charactersprite("spr_backflip");
                vsp = -12;
            }
        }
    }
}
