if (vspinvert == 1)
{
    if (anglevertx == 180)
    {
        if (key_jump2)
            vsp = 15;
        else
            vsp = 8;
    }
    else if (key_jump2)
        vsp = -15;
    else
        vsp = -8;
    
    fmod_studio_event_oneshot_3d("event:/sfx/player/jump");
}
else if (hspinvert == 1)
{
    if (key_jump2)
        movespeed = -movespeed * 2;
    else
        movespeed = -movespeed;
    
    fmod_studio_event_oneshot_3d("event:/sfx/player/jump");
}

state = ballstates.air;
hspinvert = 0;
vspinvert = 0;
