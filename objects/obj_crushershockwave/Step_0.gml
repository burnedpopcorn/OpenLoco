x += movespeed;

if (scr_solid(x, y) || !grounded)
    instance_destroy();

movespeed = Approach(movespeed, xscale * 9, 0.2);
