fmod_studio_event_oneshot_3d("event:/sfx/level_structure/collects/normal");
global.collect += 10;
global.combotime += 10;
global.combotime = clamp(global.combotime, 0, 60);

with (instance_create(x + 16, y, obj_smallnumber))
    number = "10";

create_collect_color(x, y, sprite_index, colorpalettesprite, colorpalette, 10);
instance_destroy();
