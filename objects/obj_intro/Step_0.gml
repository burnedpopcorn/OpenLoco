if (keyboard_check_pressed(ord("X")) && video_get_status() == 2)
{
    if (onceagain == 0)
    {
        onceagain = 1;
        alarm[1] = 250;
    }
    else
        video_close();
}

if (onceagain && alpha < 1)
    alpha = Approach(alpha, 1, 0.1);

if (!onceagain && alpha > 0)
    alpha = Approach(alpha, 0, 0.03);

if (video_get_status() == 0 && !don)
{
    alarm[0] = 60;
    don = 1;
}
