if (jumpscare)
{
    xscale = Approach(xscale, 50, 0.5);
    yscale = Approach(yscale, 50, 0.5);
}

if (fading)
{
    fade = Approach(fade, 1, 0.05);
    alarm[1] = 150;
    instance_deactivate_all(true);
}

if (!ending && video_get_status() == 2)
    video_pause();
else if (ending && video_get_status() == 3)
    video_resume();
