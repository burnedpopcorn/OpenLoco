scr_collision_init();
grav = 0.5;
vsp = -11;
depth = -3;
music = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/player/misc/breakdance_music"));
fmod_studio_event_instance_move(music);
