function scr_savescore(_level)
{
    if (global.collect >= global.srank)
    {
        global.rank = "s";
        
        if (global.lap && global.secretfound >= 3 && global.treasure && !global.combodrop)
            global.rank = "l";
    }
    else if (global.collect > global.arank)
        global.rank = "a";
    else if (global.collect > global.brank)
        global.rank = "b";
    else if (global.collect > global.crank)
        global.rank = "c";
    else
        global.rank = "d";
    
    with (obj_camera)
    {
        startbgescape = false;
        global.lap3activate = false;
    }
    
    if (instance_exists(obj_patripi))
        instance_destroy(obj_patripi);
    
    ini_open_from_string(obj_savesystem.ini_str);
    
    if (ini_read_real("Highscore", _level, 0) < global.collect)
        ini_write_real("Highscore", _level, global.collect);
    
    if (ini_read_real("Treasure", _level, 0) == 0)
        ini_write_real("Treasure", _level, global.treasure);
    
    if (global.secretfound > 3)
        global.secretfound = 3;
    
    if (ini_read_real("Secret", _level, 0) < global.secretfound)
        ini_write_string("Secret", _level, global.secretfound);
    
    if (ini_read_real("Toppin", _level + "1", 0) == 0)
        ini_write_real("Toppin", _level + "1", global.shroomfollow);
    
    if (ini_read_real("Toppin", _level + "2", 0) == 0)
        ini_write_real("Toppin", _level + "2", global.cheesefollow);
    
    if (ini_read_real("Toppin", _level + "3", 0) == 0)
        ini_write_real("Toppin", _level + "3", global.tomatofollow);
    
    if (ini_read_real("Toppin", _level + "4", 0) == 0)
        ini_write_real("Toppin", _level + "4", global.sausagefollow);
    
    if (ini_read_real("Toppin", _level + "5", 0) == 0)
        ini_write_real("Toppin", _level + "5", global.pineapplefollow);
    
    scr_write_rank(_level);
    
    if (global.lap == 1 && ini_read_real("Laps", _level, 0) < global.laps)
        ini_write_string("Laps", _level, global.laps);
    
    obj_savesystem.ini_str = ini_close();
}

function scr_write_rank(_level)
{
    var _rank = ini_read_string("Ranks", _level, "d");
    var _map = ds_map_create();
    _map[? "d"] = 0;
    _map[? "c"] = 1;
    _map[? "b"] = 2;
    _map[? "a"] = 3;
    _map[? "s"] = 4;
    _map[? "l"] = 5;
    
    if (_map[? global.rank] >= _map[? _rank])
        ini_write_string("Ranks", _level, global.rank);
    
    ds_map_destroy(_map);
}
