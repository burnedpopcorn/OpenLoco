image_speed = 0.35;
depth = -10;
targetDoor = "A";
pizzabox_sound = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/level_structure/pipe"));
fmod_studio_event_instance_move(pizzabox_sound);
color = randomize_palette(spr_pipepalette);

if (ds_map_find_value(global.palettesaveroom, id) == undefined)
    ds_map_set(global.palettesaveroom, id, color);
