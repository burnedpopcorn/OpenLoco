scr_getinput();
alpha = Approach(alpha, ending ? 0 : 1, 0.1);

if (fileselected == 0 && !instance_exists(obj_erasegame))
{
    if (key_down2 && fileselect < 3)
    {
        fmod_studio_event_oneshot("event:/sfx/player/step");
        fileselect += 1;
    }
    
    if (key_up2 && fileselect > 1)
    {
        fmod_studio_event_oneshot("event:/sfx/player/step");
        fileselect -= 1;
    }
    
    if (key_slap2)
        instance_destroy();
    
    if (key_jump && fileselected == 0)
    {
        switch (deletearchive)
        {
            case 0:
                global.currentsavefile = fileselect;
                ending = 1;
                gamesave_async_load();
                fmod_studio_event_oneshot("event:/sfx/level_structure/collects/plushie");
                alarm[0] = 60;
                fileselected = 1;
                break;
            
            case 1:
                alarm[1] = 1;
                fmod_studio_event_oneshot("event:/sfx/level_structure/collects/plushie");
                break;
        }
    }
}
