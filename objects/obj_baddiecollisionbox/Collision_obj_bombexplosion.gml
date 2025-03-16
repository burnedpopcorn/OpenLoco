if (instance_exists(baddieID))
{
    with (baddieID)
    {
        state = baddiestates.stun;
        stunned = 100;
        vsp = -5;
    }
}
