audio_sound_pitch(mu_specialstage, pitchmusic);

if (global.fillspecial != 0)
{
    xscaletimer = lerp(xscaletimer, 1, 0.2);
    yscaletimer = lerp(yscaletimer, 1, 0.2);
    angletimer = lerp(angletimer, 0, 0.2);
}
else
{
    if (obj_playerspecialstage.state != 6)
    {
        xH = 3;
        yH = 3;
        audio_stop_sound(mu_specialstage);
        obj_playerspecialstage.alarm[4] = 50;
        obj_playerspecialstage.state = 6;
        alarm[4] = 300;
    }
    
    if (dissapear)
    {
        xscaletimer = Approach(xscaletimer, 0, 0.02);
        yscaletimer = Approach(yscaletimer, 0, 0.02);
        anglespeed = Approach(anglespeed, 10 * angledirection, 0.2);
        angletimer += anglespeed;
    }
}

if (global.fillspecial <= 3600 && global.fillspecial > 0)
{
    var _fill = global.fillspecial;
    var _currentbarpos = 3600 - _fill;
    var _perc = _currentbarpos / 3600;
    var _max_x = 0.2;
    pitchmusic = (_max_x * _perc) + 1;
}

if (!done)
{
    if (global.fillspecial > 0)
        global.fillspecial -= 1;
}
else
{
    alpha = Approach(alpha, 0, 0.2);
}
