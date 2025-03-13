if (place_meeting(x, y, obj_player) || (instance_exists(obj_cappy) && place_meeting(x, y, obj_cappy)))
{
    ds_list_add(global.saveroom, id);
    global.combotime = 60;
    global.gerome = 1;
    instance_create(x, y, obj_geromeanim);
    fmod_studio_event_oneshot_3d("event:/sfx/level_structure/patripiget");
    tv_trigger_expression("spr_tvcatripi", 60, 1000);
    instance_destroy();
    
    with (obj_player)
    {
        roomstartx = other.x;
        roomstarty = other.y;
    }
}
