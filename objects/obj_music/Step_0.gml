if (instance_exists(obj_load) || instance_exists(obj_pausescreen))
    exit;

with (global.music)
{
    fmod_studio_system_set_parameter_by_name("gamefocused", window_has_focus() || !global.unfocus);
    fmod_studio_system_set_parameter_by_name("pillardistance", pillar_dist);
    fmod_studio_event_instance_set_pitch(event_instance, pitch);
    
    if (instance_exists(obj_exitbubble) && obj_exitbubble.state != 1)
        pitch = Approach(pitch, 0, 0.01);
    else if (instance_exists(obj_marx))
        pitch = 0.9;
    else
        pitch = 1;
    
    if (fmod_studio_event_instance_get_description(event_instance) == fmod_studio_system_get_event("event:/music/level_structure/escape"))
    {
        var _panicstate = 0;
        
        if (global.laps < 2)
            _panicstate = global.minutes <= 0;
        else
            _panicstate = global.laps;
        
        fmod_studio_event_instance_set_parameter_by_name(event_instance, "state", _panicstate);
    }
}

if (!instance_exists(obj_hungrypillar))
{
    global.music.pillar_dist = 10;
    exit;
}

with (obj_hungrypillar)
{
    var _mu = global.music;
    
    if (bbox_in_camera(view_camera[0], 0))
        _mu.pillar_dist = distance_to_point(obj_player1.x, obj_player1.y) / 80;
    else
        _mu.pillar_dist = 10;
}
