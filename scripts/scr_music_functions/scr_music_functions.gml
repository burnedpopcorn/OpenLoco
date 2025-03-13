function music_set_paused(argument0)
{
    var _truepause = 
    {
        main_music: argument0 ? argument0 : obj_music.secret,
        secret_music: argument0 ? argument0 : !obj_music.secret
    };
    
    with (global.music)
    {
        fmod_studio_event_instance_set_paused(event_instance, _truepause.main_music);
        fmod_studio_event_instance_set_paused(secret_event_instance, _truepause.secret_music);
        fmod_studio_event_instance_set_paused(pillar_instance, argument0);
    }
}

function music_set_volume(argument0)
{
    with (global.music)
    {
        fmod_studio_event_instance_set_volume(event_instance, argument0);
        fmod_studio_event_instance_set_volume(secret_event_instance, argument0);
        fmod_studio_event_instance_set_volume(pillar_instance, argument0);
    }
}

function change_music(argument0, argument1, argument2 = false, func = function()
{
    fmod_studio_event_instance_set_parameter_by_name(global.music.event_instance, "state", 0);
})
{
    with (global.music)
    {
        if (fmod_studio_event_instance_get_description(event_instance) != fmod_studio_system_get_event(argument0) || !argument2)
        {
            fmod_studio_event_instance_kill(event_instance);
            event_instance = fmod_studio_event_description_create_instance(fmod_studio_system_get_event(argument0));
            fmod_studio_event_instance_start(event_instance);
        }
        
        if (fmod_studio_event_instance_get_description(secret_event_instance) != fmod_studio_system_get_event(argument1) || !argument2)
        {
            fmod_studio_event_instance_kill(secret_event_instance);
            secret_event_instance = fmod_studio_event_description_create_instance(fmod_studio_system_get_event(argument1));
            fmod_studio_event_instance_start(secret_event_instance);
        }
        
        fmod_studio_event_instance_set_paused(event_instance, obj_music.secret);
        fmod_studio_event_instance_set_paused(secret_event_instance, !obj_music.secret);
    }
    
    func();
}

function add_music(argument0, argument1, argument2, argument3 = function()
{
    fmod_studio_event_instance_set_parameter_by_name(global.music.event_instance, "state", 0);
})
{
    var _data = 
    {
        rm: argument0,
        music: argument1,
        secret_music: argument2,
        func: argument3
    };
    
    if (is_array(_data.rm))
    {
        for (var i = 0; i < array_length(_data.rm); i++)
            ds_map_add(obj_music.music_map, _data.rm[i], _data);
    }
    else
    {
        ds_map_add(obj_music.music_map, _data.rm, _data);
    }
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
