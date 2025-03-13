image_speed = 0.35;

if ((obj_player1.key_right2 || -obj_player2.key_left2) && (selected == 0 && ready == 0))
{
    selected += 1;
    fmod_studio_event_oneshot("event:/sfx/player/step");
}

if ((-obj_player1.key_left2 || obj_player2.key_right2) && (selected == 1 && ready == 0))
{
    selected -= 1;
    fmod_studio_event_oneshot("event:/sfx/player/step");
}

if (obj_player1.key_jump && (selected == 0 && obj_peppinoselect.sprite_index != spr_peppinoselected))
{
    ready = 1;
    fmod_studio_event_oneshot_3d("event:/sfx/level_structure/collects/plushie");
    obj_peppinoselect.sprite_index = spr_peppinoselected;
    obj_peppinoselect.image_index = 0;
    
    with (obj_player1)
        character = "P";
    
    with (obj_player2)
    {
        character = "N";
        
        if (global.coop == 1)
        {
            obj_noiseselect.sprite_index = spr_noiseselected;
            obj_noiseselect.image_index = 0;
        }
    }
    
    alarm[0] = 100;
}

if (obj_player1.key_jump && (selected == 1 && obj_noiseselect.sprite_index != spr_noiseselected))
{
    ready = 1;
    fmod_studio_event_oneshot_3d("event:/sfx/level_structure/collects/plushie");
    obj_noiseselect.sprite_index = spr_noiseselected;
    obj_noiseselect.image_index = 0;
    
    with (obj_player1)
        character = "N";
    
    with (obj_player2)
    {
        character = "P";
        
        if (global.coop == 1)
        {
            obj_peppinoselect.sprite_index = spr_peppinoselected;
            obj_peppinoselect.image_index = 0;
        }
    }
    
    alarm[0] = 100;
}
