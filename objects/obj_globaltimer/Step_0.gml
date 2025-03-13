var s = 0.016666666666666666;

if ((instance_exists(obj_pause) && !obj_pause.pause) || global.option_speedrun_timer)
{
    if (room != rank_room && !instance_exists(obj_endlevelfade))
    {
        global.file_seconds += s;
        
        if (global.file_seconds >= 60)
        {
            global.file_seconds = 0;
            global.file_minutes++;
        }
        
        global.level_seconds += s;
        
        if (global.level_seconds >= 60)
        {
            global.level_seconds = 0;
            global.level_minutes++;
        }
    }
}
