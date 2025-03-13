var _val;

if (collect <= -10)
{
    _val = -10;
    collect += 10;
}
else
{
    _val = collect;
    collect = 0;
}

fmod_studio_event_oneshot_3d("event:/sfx/level_structure/collects/normal");
global.collect += _val;

if (global.collect < 0)
    global.collect = 0;

instance_create(x, y, obj_pizzaloss);
alarm[1] = 10 + irandom_range(-1, 1);
