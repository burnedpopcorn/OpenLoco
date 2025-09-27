if (!instance_exists(obj_endlevelfade))
{
    with (instance_create(x, y, obj_endlevelfade))
    {
        if (room != Tutori_1)
        {
            alarm[0] = 680;
            var _rankmap = ds_map_create();
            _rankmap[? "l"] = 5;
            _rankmap[? "s"] = 4;
            _rankmap[? "a"] = 3;
            _rankmap[? "b"] = 2;
            _rankmap[? "c"] = 1;
            _rankmap[? "d"] = 0;
            music_instance = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/music/level_structure/rank"));
            fmod_studio_event_instance_set_parameter_by_name(music_instance, "state", _rankmap[? global.rank]);
            fmod_studio_event_instance_start(music_instance);
            fmod_studio_event_instance_release(music_instance);
        }
    }
}
