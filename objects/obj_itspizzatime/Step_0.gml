if (fmod_studio_event_instance_is_playing(global.music.event_instance))
{
    mustrack += 1;
    
    if (mustrack >= 60 && !activate[0])
    {
        alpha[0] = 1;
        activate[0] = true;
    }
    
    if (mustrack >= 90 && !activate[1])
    {
        alpha[1] = 1;
        activate[1] = true;
    }
    
    if (mustrack >= 120 && !activate[2])
    {
        alpha[2] = 1;
        activate[2] = true;
    }
    
    if (mustrack >= 441 && !falling)
    {
        vsp[0] = -4;
        hsp[0] = -3;
        vsp[1] = -7;
        hsp[1] = 0;
        vsp[2] = -4;
        hsp[2] = 3;
        falling = true;
    }
}

for (var i = 0; i < 3; i++)
{
    if (size[i] <= 1 && !done[i])
    {
        fmod_studio_event_oneshot("event:/sfx/player/punch");
        shake[i] = 8;
        done[i] = true;
    }
    
    if (falling)
    {
        vsp[i] = Approach(vsp[i], 20, 0.4);
        X[i] += hsp[i];
        Y[i] += vsp[i];
    }
    
    size[i] = Approach(size[i], activate[i] ? 1 : 2, 0.1);
    shake[i] = Approach(shake[i], 0, 0.5);
}
