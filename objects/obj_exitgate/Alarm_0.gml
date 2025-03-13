if (!instance_exists(obj_endlevelfade))
{
    with (instance_create(x, y, obj_endlevelfade))
    {
        if (room != Tutori_1)
        {
            alarm[0] = 680;
            var _rankmap = ds_map_create();
            ds_map_set(_rankmap, "l", 5);
            ds_map_set(_rankmap, "s", 4);
            ds_map_set(_rankmap, "a", 3);
            ds_map_set(_rankmap, "b", 2);
            ds_map_set(_rankmap, "c", 1);
            ds_map_set(_rankmap, "d", 0);
            music_instance = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/music/level_structure/rank"));
            fmod_studio_event_instance_set_parameter_by_name(music_instance, "state", ds_map_find_value(_rankmap, global.rank));
            fmod_studio_event_instance_start(music_instance);
            fmod_studio_event_instance_release(music_instance);
        }
    }
}
