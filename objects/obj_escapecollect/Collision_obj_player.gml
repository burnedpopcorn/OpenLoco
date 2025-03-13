if (image_alpha == 1)
{
    fmod_studio_event_oneshot_3d("event:/sfx/level_structure/collects/clock");
    
    if (obj_player1.character == "V")
        global.playerhealth = clamp(global.playerhealth + 1, 0, 100);
    
    global.combotime += 10;
    global.combotime = clamp(global.combotime, 0, 60);
    var val = heat_calculate(10);
    global.collect += val;
    create_collect(x, y, sprite_index, val);
    
    with (instance_create(x + 16, y, obj_smallnumber))
        number = string(val);
    
    instance_destroy();
}
