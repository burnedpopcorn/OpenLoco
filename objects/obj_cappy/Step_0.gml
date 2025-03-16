if (state != cappystates.comeback && !seek)
{
    x += hsp;
    y += vsp;
}

image_xscale = 1 + (0.5 * (abs(hsp) / 10));
image_yscale = 1 - (0.5 * (abs(hsp) / 10));

switch (state)
{
    case cappystates.fly:
        scr_cappy_fly();
        break;
    
    case cappystates.enemykill:
        scr_cappy_enemycontrol();
        break;
    
    case cappystates.comeback:
        scr_cappy_comeback();
        break;
}
