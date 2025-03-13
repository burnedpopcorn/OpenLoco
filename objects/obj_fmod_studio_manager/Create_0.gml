var _max_channels = 1024;
var _flags_core = UnknownEnum.Value_0;
var _flags_studio = UnknownEnum.Value_1;
fmod_debug_initialize(UnknownEnum.Value_4, UnknownEnum.Value_2);
fmod_studio_system_create();
show_debug_message("fmod_studio_system_create: " + string(fmod_last_result()));
fmod_studio_system_init(_max_channels, _flags_studio, _flags_core);
show_debug_message("fmod_studio_system_init: " + string(fmod_last_result()));
fmod_main_system = fmod_studio_system_get_core_system();
master_bank = fmod_studio_system_load_bank_file(fmod_path_bundle("data\\sound\\Desktop\\Master.bank"), UnknownEnum.Value_0);
master_strings_bank = fmod_studio_system_load_bank_file(fmod_path_bundle("data\\sound\\Desktop\\Master.strings.bank"), UnknownEnum.Value_0);
music_bank = fmod_studio_system_load_bank_file(fmod_path_bundle("data\\sound\\Desktop\\Music.bank"), UnknownEnum.Value_0);
sfx_bank = fmod_studio_system_load_bank_file(fmod_path_bundle("data\\sound\\Desktop\\SFX.bank"), UnknownEnum.Value_0);
music_bus = fmod_studio_system_get_bus("bus:/music");
sfx_bus = fmod_studio_system_get_bus("bus:/sfx");
oneshot_events = ds_list_create();
fmod_studio_system_set_num_listeners(0);
listener_weight = 0;
listener_attributes = 
{
    position: 
    {
        x: 0,
        y: 0,
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
fmod_studio_system_set_listener_attributes(0, listener_attributes);
fmod_studio_system_set_listener_weight(0, listener_weight);
