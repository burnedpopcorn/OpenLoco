with (obj_camera)
    extra_lshake = (global.laps - 3) / 2;

y = -sprite_height;
down = 1;
movespeed = 2;
depth = -100;
fmod_studio_event_oneshot("event:/sfx/level_structure/lapcounter");
