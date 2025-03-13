target_tiles = ["Tiles_1", "Tiles_2", "Tiles_3", "Tiles_Foreground1", "Tiles_Foreground2"];
global.breaksound = 0;
particlespr = spr_towerblockdebris;
breaksound = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/sfx/level_structure/destroy"));
fmod_studio_event_instance_move(breaksound);
