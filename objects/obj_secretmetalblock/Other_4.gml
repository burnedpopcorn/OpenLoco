if (ds_list_find_index(global.saveroom, id) != -1)
{
    scr_destroy_tiles(32, "Tiles_1");
    scr_destroy_tiles(32, "Tiles_2");
    scr_destroy_tiles(32, "Tiles_3");
    instance_destroy();
}
