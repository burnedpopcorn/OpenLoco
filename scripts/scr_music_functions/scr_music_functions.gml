function music_set_paused(_pause)
{
    var _truepause = 
    {
        main_music: _pause ? _pause : obj_music.secret,
        secret_music: _pause ? _pause : !obj_music.secret
    };
    
    with (global.music)
    {
        fmod_studio_event_instance_set_paused(event_instance, _truepause.main_music);
        fmod_studio_event_instance_set_paused(secret_event_instance, _truepause.secret_music);
        fmod_studio_event_instance_set_paused(pillar_instance, _pause);
    }
}

function music_set_volume(_volume)
{
    with (global.music)
    {
        fmod_studio_event_instance_set_volume(event_instance, _volume);
        fmod_studio_event_instance_set_volume(secret_event_instance, _volume);
        fmod_studio_event_instance_set_volume(pillar_instance, _volume);
    }
}

function change_music(_main_mus, _secret_mus, _dont_force = false, _func = function()
{
    fmod_studio_event_instance_set_parameter_by_name(global.music.event_instance, "state", 0);
})
{
    with (global.music)
    {
        if (fmod_studio_event_instance_get_description(event_instance) != fmod_studio_system_get_event(_main_mus) || !_dont_force)
        {
            fmod_studio_event_instance_kill(event_instance);
            event_instance = fmod_studio_event_description_create_instance(fmod_studio_system_get_event(_main_mus));
            fmod_studio_event_instance_start(event_instance);
        }
        
        if (fmod_studio_event_instance_get_description(secret_event_instance) != fmod_studio_system_get_event(_secret_mus) || !_dont_force)
        {
            fmod_studio_event_instance_kill(secret_event_instance);
            secret_event_instance = fmod_studio_event_description_create_instance(fmod_studio_system_get_event(_secret_mus));
            fmod_studio_event_instance_start(secret_event_instance);
        }
        
        fmod_studio_event_instance_set_paused(event_instance, obj_music.secret);
        fmod_studio_event_instance_set_paused(secret_event_instance, !obj_music.secret);
    }
    
    _func();
}

function add_music(_rm, _mus, _secret_mus, _func = function()
{
    fmod_studio_event_instance_set_parameter_by_name(global.music.event_instance, "state", 0);
})
{
    var _data = 
    {
        rm: _rm,
        music: _mus,
        secret_music: _secret_mus,
        func: _func
    };
    
    if (is_array(_data.rm))
    {
        for (var i = 0; i < array_length(_data.rm); i++)
            ds_map_add(obj_music.music_map, _data.rm[i], _data);
    }
    else
        ds_map_add(obj_music.music_map, _data.rm, _data);
}

function restart_music()
{
    with (global.music)
    {
        fmod_studio_event_instance_start(event_instance);
        fmod_studio_event_instance_start(secret_event_instance);
        fmod_studio_event_instance_set_paused(event_instance, obj_music.secret);
        fmod_studio_event_instance_set_paused(secret_event_instance, !obj_music.secret);
    }
}
