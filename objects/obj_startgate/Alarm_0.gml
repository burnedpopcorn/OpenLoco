if (rank_appear)
{
    fmod_studio_event_oneshot("event:/sfx/player/slip/bump");
    rank_shakepower = 3;
}
else
{
    rank_appear = true;
    alarm[0] = 30;
}
