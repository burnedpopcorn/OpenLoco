function scr_savescore(argument0)
{
    if (global.collect >= global.srank)
    {
        global.rank = "s";
        
        if (global.lap && global.secretfound >= 3 && global.treasure && !global.combodrop)
            global.rank = "l";
    }
    else if (global.collect > global.arank)
    {
        global.rank = "a";
    }
    else if (global.collect > global.brank)
    {
        global.rank = "b";
    }
    else if (global.collect > global.crank)
    {
        global.rank = "c";
    }
    else
    {
        global.rank = "d";
    }
    
    with (obj_camera)
    {
        startbgescape = false;
        global.lap3activate = false;
    }
    
    if (instance_exists(obj_patripi))
        instance_destroy(obj_patripi);
    
    ini_open_from_string(obj_savesystem.ini_str);
    
    if (ini_read_real("Highscore", argument0, 0) < global.collect)
        ini_write_real("Highscore", argument0, global.collect);
    
    if (ini_read_real("Treasure", argument0, 0) == 0)
        ini_write_real("Treasure", argument0, global.treasure);
    
    if (global.secretfound > 3)
        global.secretfound = 3;
    
    if (ini_read_real("Secret", argument0, 0) < global.secretfound)
        ini_write_string("Secret", argument0, global.secretfound);
    
    if (ini_read_real("Toppin", argument0 + "1", 0) == 0)
        ini_write_real("Toppin", argument0 + "1", global.shroomfollow);
    
    if (ini_read_real("Toppin", argument0 + "2", 0) == 0)
        ini_write_real("Toppin", argument0 + "2", global.cheesefollow);
    
    if (ini_read_real("Toppin", argument0 + "3", 0) == 0)
        ini_write_real("Toppin", argument0 + "3", global.tomatofollow);
    
    if (ini_read_real("Toppin", argument0 + "4", 0) == 0)
        ini_write_real("Toppin", argument0 + "4", global.sausagefollow);
    
    if (ini_read_real("Toppin", argument0 + "5", 0) == 0)
        ini_write_real("Toppin", argument0 + "5", global.pineapplefollow);
    
    scr_write_rank(argument0);
    
    if (global.lap == 1 && ini_read_real("Laps", argument0, 0) < global.laps)
        ini_write_string("Laps", argument0, global.laps);
    
    obj_savesystem.ini_str = ini_close();
}

function scr_write_rank(argument0)
{
    var _rank = ini_read_string("Ranks", argument0, "d");
    var _map = ds_map_create();
    ds_map_set(_map, "d", 0);
    ds_map_set(_map, "c", 1);
    ds_map_set(_map, "b", 2);
    ds_map_set(_map, "a", 3);
    ds_map_set(_map, "s", 4);
    ds_map_set(_map, "l", 5);
    
    if (ds_map_find_value(_map, global.rank) >= ds_map_find_value(_map, _rank))
        ini_write_string("Ranks", argument0, global.rank);
    
    ds_map_destroy(_map);
    exit;
}
