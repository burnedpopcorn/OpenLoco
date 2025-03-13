ini_open_from_string(obj_savesystem.ini_str);

if (ini_read_real("Custene", "intro", 0) == 0)
    ini_write_real("Custene", "intro", 1);

obj_savesystem.ini_str = ini_close();
gamesave_async_save();

with (instance_create(x, y, obj_fadeout))
    obj_player.targetRoom = Titlescreen;
