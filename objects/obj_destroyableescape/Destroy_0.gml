if (ds_list_find_index(global.saveroom, id) == -1)
{
    if (global.panic == 1)
    {
        repeat (4)
        {
            with (instance_create(x + 16, y, obj_debris))
                sprite_index = spr_debrisescape;
        }
        
        tile_layer_delete_at(1, x, y);
        fmod_studio_event_oneshot_3d("event:/sfx/level_structure/destroy");
        ds_list_add(global.saveroom, id);
    }
}
