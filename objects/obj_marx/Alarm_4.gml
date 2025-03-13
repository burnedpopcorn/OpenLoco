if (!arrows)
{
    if (!fmod_studio_event_instance_is_playing(laughsound))
        fmod_studio_event_instance_start(laughsound);
    
    sprite_index = spr_marx_head_spit;
    arrows = 1;
    alarm[4] = 500;
}
else if (arrows)
{
    sprite_index = spr_marx_head;
    powerselect = 0;
    usingarrows = 0;
    arrows = 0;
    usepower = 0;
    instakillmove = 1;
}
