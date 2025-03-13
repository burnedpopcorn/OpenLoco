function scr_getlcoins()
{
    var levels = ["hall", "locotown", "forestmaze"];
    var l_coins = 0;
    ini_open_from_string(obj_savesystem.ini_str);
    
    for (var i = 0; i < array_length(levels); i++)
    {
        if (ini_read_string("Ranks", levels[i], "d") == "p" || ini_read_string("Ranks", levels[i], "d") == "l")
            l_coins += max(ini_read_real("Laps", levels[i], 0) - 1, 0);
        
        l_coins -= ini_read_real("L-Coins", "spent", 0);
    }
    
    obj_savesystem.ini_str = ini_close();
    return l_coins;
}
