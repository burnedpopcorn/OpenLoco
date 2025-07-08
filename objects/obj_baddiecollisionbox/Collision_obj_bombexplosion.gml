if (instance_exists(baddieID))
{
    with (baddieID)
    {
        state = states.capefall;
        stunned = 100;
        vsp = -5;
    }
}
