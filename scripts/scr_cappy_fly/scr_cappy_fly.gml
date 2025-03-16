function scr_cappy_fly()
{
    var nearest_enemy = instance_nearest(x, y, obj_baddie);
    hsp = Approach(hsp, 0, 1);
    vsp = Approach(vsp, 0, 1);
    
    if (hsp == 0 && alarm[0] == -1)
        alarm[0] = 60;
    
    if (hsp == 0 && player_id.key_special2 && distance_to_object(obj_baddie) > 100)
        alarm[0] = 1;
    
    if (instance_exists(nearest_enemy))
    {
        var _dir = point_direction(x, y, player_id.x, player_id.y);
        x = approach(x, player_id.x, lengthdir_x(12 * seek, _dir));
        y = approach(y, player_id.y, lengthdir_y(12 * seek, _dir));
        
        if (place_meeting(x, y, nearest_enemy))
            state = cappystates.enemykill;
    }
    
    if (place_meeting(x, y, player_id) && player_id.key_jump2 && !player_id.grounded && player_id.state != states.cappythrow && state != states.tumble)
    {
        state = cappystates.comeback;
        
        with (player_id)
        {
            if (state != states.jump && abs(movespeed) >= 12)
            {
                if (state != states.mach3)
                    state = states.mach3;
                
                sprite_index = spr_mach3jump;
            }
            else if (state != states.jump && abs(movespeed) < 12)
            {
                if (state != states.mach2)
                    state = states.mach2;
                
                sprite_index = spr_mach2jump;
            }
            else
            {
                if (state != states.jump)
                    state = states.jump;
                
                sprite_index = spr_jump;
            }
            
            image_index = 0;
            vsp = -10;
            
            if (movespeed < 7)
                movespeed = 7;
        }
    }
    
    if (player_id.key_special2 && distance_to_object(obj_baddie) <= 100)
        seek = true;
}
