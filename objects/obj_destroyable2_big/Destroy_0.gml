if (ds_list_find_index(global.saveroom, id) == -1 && global.snickchallenge == 0)
{
    with (instance_create(x, y, obj_parryeffect))
    {
        image_speed = 0.35;
        sprite_index = spr_blockydestroyed;
        palette = spr_blockypalette;
        paletteindex = other.paletteselect;
    }
    
    fmod_studio_event_oneshot_3d("event:/sfx/level_structure/collects/big");
    global.combotime += 10;
    global.combotime = clamp(global.combotime, 0, 60);
    var val = heat_calculate(100);
    global.collect += val;
    tile_layer_delete_at(1, x, y);
    tile_layer_delete_at(1, x + 32, y);
    tile_layer_delete_at(1, x + 32, y + 32);
    tile_layer_delete_at(1, x, y + 32);
    fmod_studio_event_instance_start(breaksound);
    ds_list_add(global.saveroom, id);
    
    with (instance_create(x + 16, y, obj_smallnumber))
        number = string(val);
    
    number = val;
}
