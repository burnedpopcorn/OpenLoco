if (ds_list_find_index(global.saveroom, id) == -1)
{
    with (instance_create(x + 32, y + 32, obj_sausageman_dead))
        sprite_index = spr_metalbsecretdead;
    
    tile_layer_delete_at(1, x, y);
    tile_layer_delete_at(1, x + 32, y);
    tile_layer_delete_at(1, x + 32, y + 32);
    tile_layer_delete_at(1, x, y + 32);
    
    with (obj_camera)
    {
        shake_mag = 20;
        shake_mag_acc = 40 / room_speed;
    }
    
    fmod_studio_event_oneshot_3d("event:/sfx/level_structure/destroy_metal");
    ds_list_add(global.saveroom, id);
}

for (var i = 0; i < array_length(target_tiles); i++)
    scr_destroy_tiles(32, target_tiles[i]);

scr_cutoff();
scr_destroy_nearby_tiles();
depth = 1;
