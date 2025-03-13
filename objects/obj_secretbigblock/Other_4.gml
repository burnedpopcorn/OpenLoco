if (ds_list_find_index(global.saveroom, id) != -1)
{
    scr_destroy_tiles(32, "Tiles_1");
    scr_destroy_tiles(32, "Tiles_2");
    scr_destroy_tiles(32, "Tiles_3");
    scr_destroy_tiles(32, "Tiles_4");
    instance_destroy();
}

scr_cutoff();
var roomname = room_get_name(room);

if (string_letters(roomname) == "Nhall" || string_letters(roomname) == "Nhallsecret")
    particlespr = spr_halldebris2;
