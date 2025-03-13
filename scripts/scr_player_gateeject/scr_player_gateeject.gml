function scr_player_gateeject()
{
    if (sprite_index != get_charactersprite("spr_hurt"))
    {
        cutscene = 1;
        vsp = 0;
        hsp = 0;
        movespeed = 0;
    }
    else
    {
        image_speed = 0.5;
        
        if (grounded)
        {
            switch (bounce)
            {
                case 0:
                    vsp = -12;
                    bounce = 1;
                    fmod_studio_event_oneshot_3d("event:/sfx/player/misc/bump");
                    break;
                
                case 1:
                    vsp = -9;
                    bounce = 2;
                    fmod_studio_event_oneshot_3d("event:/sfx/player/misc/bump");
                    break;
                
                case 2:
                    state = states.normal;
                    bounce = 0;
                    fmod_studio_event_oneshot_3d("event:/sfx/player/misc/bump");
                    break;
            }
        }
    }
}
