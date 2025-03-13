obj_cartitlecustene.active = 1;
ini_open_from_string(obj_savesystem.ini_str);

if (ini_read_real("Custene", "intro", 0) == 0)
    obj_cartitlecustene.intro = 1;

obj_savesystem.ini_str = ini_close();
