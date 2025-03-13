scr_getinput();

if (!instance_exists(obj_option) && !instance_exists(obj_fileselect) && !instance_exists(obj_erasegame) && optionselected == 0)
{
    if (key_down2 && optionselect < 3)
    {
        fmod_studio_event_oneshot("event:/sfx/player/step");
        optionselect++;
    }
    
    if (key_up2 && optionselect > 0)
    {
        fmod_studio_event_oneshot("event:/sfx/player/step");
        optionselect--;
    }
    
    if (key_jump && optionselected == 0)
    {
        switch (optionselect)
        {
            case 0:
                fmod_studio_event_oneshot("event:/sfx/level_structure/collects/plushie");
                instance_create_unique(x, y, obj_fileselect);
                break;
            
            case 1:
                fmod_studio_event_oneshot("event:/sfx/level_structure/collects/plushie");
                instance_create_unique(x, y, obj_option);
                break;
            
            case 2:
                alarm[2] = 1;
                fmod_studio_event_oneshot("event:/sfx/level_structure/collects/plushie");
                break;
            
            case 3:
                alarm[3] = 60;
                fmod_studio_event_oneshot("event:/sfx/level_structure/collects/plushie");
                optionselected = 1;
                break;
        }
    }
}

time++;
