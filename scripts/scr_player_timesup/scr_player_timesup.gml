function scr_player_timesup()
{
    xscale = 1;
    inv_frames = 0;
    sprite_index = get_charactersprite("spr_timesup");
    alarm[7] = -1;
    alarm[8] = -1;
    alarm[5] = -1;
    TUx = Approach(TUx, 0, 0.5);
    TUy = Approach(TUy, 0, 0.5);
    
    if (place_meeting(x, y, obj_timesup) && !instance_exists(obj_playertimesup))
    {
        visible = false;
        instance_create(x, y, obj_playertimesup);
    }
    
    if (room == timesuproom)
    {
        obj_player1.x = 480 + random_range(-TUx, TUx);
        obj_player1.y = 270 + random_range(-TUy, TUy);
    }
    
    if (floor(image_index) == 9)
        image_speed = 0;
}
