if (global.timeattack == 0)
{
    obj_timeattack.alarm[1] = 60;
    global.timeattack = 1;
    global.collect = 12000;
    fmod_studio_event_oneshot("event:/sfx/player/misc/kill");
    instance_destroy();
    ds_list_add(global.baddieroom, id);
}
