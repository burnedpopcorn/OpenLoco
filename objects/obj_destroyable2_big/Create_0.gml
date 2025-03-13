hp = 2;
image_index = random_range(0, sprite_get_number(sprite_index) - 1);
depth = 1;
image_speed = 0.35;
sprite_index = spr_blocky;
paletteselect = randomize_palette(spr_blockypalette);
breaksound = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/level_structure/destroy"));
fmod_studio_event_instance_move(breaksound);
