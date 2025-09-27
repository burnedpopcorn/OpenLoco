secret = instance_exists(obj_secretportal) && obj_secretportal.secret;
var room_sng = music_map[? room];

with (global.music)
{
    fmod_studio_event_instance_set_paused(event_instance, other.secret);
    fmod_studio_event_instance_set_paused(secret_event_instance, !other.secret);
    
    if (instance_exists(obj_hungrypillar) && !global.panic)
    {
        fmod_studio_event_instance_kill(pillar_instance);
        pillar_instance = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/music/level_structure/patrick"));
        fmod_studio_event_instance_start(pillar_instance);
    }
    else
        fmod_studio_event_instance_kill(pillar_instance);
}

if (global.panic || is_undefined(room_sng))
    exit;

change_music(music_map[? room].music, music_map[? room].secret_music, true, music_map[? room].func);
