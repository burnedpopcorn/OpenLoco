if (!blackhole)
{
    blackhole = 1;
    alarm[3] = 500;
}
else if (blackhole)
{
    blackhole = 0;
    powerselect = 2;
    usepower = 0;
}
