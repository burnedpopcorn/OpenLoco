function scr_deactivate_escape()
{
    with (obj_baddie)
    {
        if (escape == 1 || under == 1 || underescape == 1)
            event_perform(ev_other, ev_room_start);
    }
    
    with (obj_comboend) { }
}

function activate_escape()
{
    if (instance_exists(obj_discord_presence))
        obj_discord_presence.alarm[0] = 1;
    
    change_music("event:/music/level_structure/escape", "event:/music/level_structure/escape_secret", false);
    fmod_studio_event_instance_kill(global.music.pillar_instance);
    
    if (instance_exists(obj_backgroundchange))
        obj_backgroundchange.ending = 1;
    
    global.minutes = minutes;
    global.seconds = seconds;
    global.fill = ((global.minutes * 60) + global.seconds) * 60;
    obj_screen.starting_fill = ((global.minutes * 60) + global.seconds) * 60;
    
    with (obj_tv)
        chunkmax = global.fill;
    
    with (obj_chunktimer)
        fillmax = global.fill;
    
    with (obj_escapecollect)
        image_alpha = 1;
    
    with (obj_escapecollectbig)
        image_alpha = 1;
    
    instance_create(x, y + 600, obj_itspizzatime);
    global.panic = 1;
    global.maxwave = ((global.minutes * 60) + global.seconds) * 60;
    global.wave = 0;
}
