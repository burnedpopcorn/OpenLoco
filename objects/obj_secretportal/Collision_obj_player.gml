if (active && sprite_index != spr_secretportal_open && ds_list_find_index(global.saveroom, id) == -1)
{
    if (sprite_index != spr_secretportal_close)
    {
        fmod_studio_event_oneshot_3d("event:/sfx/level_structure/secretegg/enter");
        sprite_index = spr_secretportal_close;
        image_index = 0;
    }
    
    if (!touched)
    {
        if (global.smoothcam)
        {
            if (secret == 0)
                obj_camera.secretcam = 1;
            else
                obj_camera.secretcamexit = 1;
        }
    }
    
    touched = 1;
    playerid = other.id;
    
    with (playerid)
    {
        x = approach(x, other.x, 1);
        y = approach(y, other.y - 30, 1);
        vsp = 0;
        hsp = 0;
        cutscene = true;
        grav = 0.5;
        state = states.unknown126;
        scale_xs = Approach(scale_xs, 0, 0.05);
        scale_ys = Approach(scale_ys, 0, 0.05);
        sprite_index = get_charactersprite("spr_hurt");
    }
}
