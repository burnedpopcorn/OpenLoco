if (state != states.tumble && !seek)
{
    x += hsp;
    y += vsp;
}

image_xscale = 1 + (0.5 * (abs(hsp) / 10));
image_yscale = 1 - (0.5 * (abs(hsp) / 10));

switch (state)
{
    case states.normal:
        scr_cappy_fly();
        break;
    
    case UnknownEnum.Value_1:
        scr_cappy_enemycontrol();
        break;
    
    case states.tumble:
        scr_cappy_comeback();
        break;
}
