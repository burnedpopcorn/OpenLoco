var ident = ds_map_find_value(async_load, "id");
var status = ds_map_find_value(async_load, "status");
var error = ds_map_find_value(async_load, "error");

switch (state)
{
    case 1:
        if (ident == saveid)
        {
            buffer_delete(savebuff);
            trace("Save status: ", status, ", error: ", error);
            state = states.normal;
        }
        
        break;
    
    case 2:
        if (ident == loadid)
        {
            var buffstring = buffer_read(loadbuff, buffer_string);
            ini_open_from_string(buffstring);
            global.introcutscene = ini_read_real("Cutscene", "intro", 0);
            global.cutscenehallpillar = ini_read_real("Cutscene", "hallpillar", 0);
            global.custeneplantwall = ini_read_real("Custene", "plantwall", 0);
            global.halltreasure = ini_read_real("Treasure", "hall", 0);
            global.entrancetreasure = ini_read_real("Treasure", "entrance", 0);
            global.medievaltreasure = ini_read_real("Treasure", "medieval", 0);
            global.ruintreasure = ini_read_real("Treasure", "ruin", 0);
            global.dungeontreasure = ini_read_real("Treasure", "dungeon", 0);
            ini_str = ini_close();
            buffer_delete(loadbuff);
            trace("inistr: ", ini_str);
            trace("buffstring: ", buffstring);
            state = states.normal;
        }
        
        break;
}
