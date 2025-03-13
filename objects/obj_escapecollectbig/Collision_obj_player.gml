if (image_alpha == 1)
{
    global.collect += 100;
    create_collect(x, y, sprite_index, 100);
    
    with (instance_create(x, y, obj_smallnumber))
        number = "100";
    
    global.combotime = 60;
    fmod_studio_event_oneshot_3d("event:/sfx/level_structure/collects/bell");
    instance_destroy();
}
