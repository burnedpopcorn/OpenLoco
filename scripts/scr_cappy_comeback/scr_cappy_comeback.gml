function scr_cappy_comeback()
{
    var _dir = point_direction(x, y, player_id.x, player_id.y);
    x = approach(x, player_id.x, lengthdir_x(12 + elapsed_time, _dir));
    y = approach(y, player_id.y, lengthdir_y(12 + elapsed_time, _dir));
    
    if (place_meeting(x, y, player_id))
    {
        instance_create(x, y, obj_bumpeffect);
        instance_destroy();
    }
    
    elapsed_time += 0.15;
    
    if (place_meeting(x, y, obj_baddie))
    {
        with (instance_nearest(x, y, obj_baddie))
            instance_destroy();
    }
}
