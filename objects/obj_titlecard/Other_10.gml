title_x = 0 - sprite_get_width(title_sprite);
title_instance = fmod_studio_event_description_create_instance(fmod_studio_system_get_event(title_music));
fmod_studio_event_instance_start(title_instance);
fmod_studio_event_instance_release(title_instance);
