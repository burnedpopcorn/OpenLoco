fmod_studio_system_update();
listener_attributes.position.x = camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2);
listener_attributes.position.y = camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2);
fmod_studio_system_set_listener_attributes(0, listener_attributes);
fmod_studio_system_set_listener_weight(0, listener_weight);

for (var i = 0; i < ds_list_size(oneshot_events); i++)
{
    if (fmod_studio_event_instance_is_valid(oneshot_events[| i]))
        fmod_studio_event_instance_move(oneshot_events[| i], camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2), camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2));
    else
        ds_list_delete(oneshot_events, i);
}

var _sfxvol = global.option_master_volume * global.option_sfx_volume;
var _musvol = global.option_master_volume * global.option_music_volume;
fmod_studio_bus_set_volume(sfx_bus, _sfxvol);
fmod_studio_bus_set_volume(music_bus, _musvol);

if (!instance_exists(obj_player1))
    exit;

var _char = 0;

if (obj_player1.character == "T")
    _char = 1;
else if (obj_player1.character == "J")
    _char = 2;

fmod_studio_system_set_parameter_by_name("Character", _char);
