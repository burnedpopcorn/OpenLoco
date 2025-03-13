if (ds_list_find_index(global.saveroom, id) == -1 && global.snickchallenge == 0)
{
    repeat (6)
    {
        with (instance_create(x + 16, y, obj_pizzadebris))
            sprite_index = spr_debris;
    }
    
    fmod_studio_event_oneshot_3d("event:/sfx/level_structure/collects/normal");
    global.combotime += 10;
    global.combotime = clamp(global.combotime, 0, 60);
    global.collect += 10;
    
    with (instance_create(x + 16, y, obj_smallnumber))
        number = "10";
    
    tile_layer_delete_at(1, x, y);
    fmod_studio_event_instance_start(breaksound);
    ds_list_add(global.saveroom, id);
}
