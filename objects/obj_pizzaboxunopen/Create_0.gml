image_speed = 0.35;
createdpizza = 0;
content = obj_pizzakinshroom;
soundGain = 0;

if (obj_player.character == "S")
    instance_destroy();

snd = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/level_structure/boxalert"));
fmod_studio_event_instance_move(snd);
alarm[0] = 1;
