function fmod_studio_event_instance_move(argument0, argument1 = x, argument2 = y)
{
    var _attributes = 
    {
        position: 
        {
            x: argument1,
            y: argument2,
            z: 0
        },
        velocity: 
        {
            x: 0,
            y: 0,
            z: 0
        },
        forward: 
        {
            x: 0,
            y: 0,
            z: 1
        },
        up: 
        {
            x: 0,
            y: 1,
            z: 0
        }
    };
    fmod_studio_event_instance_set_3d_attributes(argument0, _attributes);
}

function fmod_studio_event_oneshot(argument0, argument1 = global.option_sfx_volume * global.option_master_volume)
{
    var _oneshot_instance = fmod_studio_event_description_create_instance(fmod_studio_system_get_event(argument0));
    fmod_studio_event_instance_move(_oneshot_instance, camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2), camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2));
    fmod_studio_event_instance_set_volume(_oneshot_instance, 1);
    fmod_studio_event_instance_start(_oneshot_instance);
    fmod_studio_event_instance_release(_oneshot_instance);
    ds_list_add(obj_fmod_studio_manager.oneshot_events, _oneshot_instance);
}

function fmod_studio_event_oneshot_3d(argument0, argument1 = x, argument2 = y, argument3 = global.option_master_volume * global.option_sfx_volume)
{
    var _oneshot_instance = fmod_studio_event_description_create_instance(fmod_studio_system_get_event(argument0));
    fmod_studio_event_instance_move(_oneshot_instance, argument1, argument2);
    fmod_studio_event_instance_set_volume(_oneshot_instance, 1);
    fmod_studio_event_instance_start(_oneshot_instance);
    fmod_studio_event_instance_release(_oneshot_instance);
}

function fmod_studio_event_instance_kill(argument0)
{
    fmod_studio_event_instance_stop(argument0, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    fmod_studio_event_instance_release(argument0);
}

function fmod_studio_event_instance_is_playing(argument0)
{
    return fmod_studio_event_instance_get_playback_state(argument0) == FMOD_STUDIO_PLAYBACK_STATE.PLAYING;
}
