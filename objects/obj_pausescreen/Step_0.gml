vspeedsprite += 0.25;

if (vspeedsprite > sprite_get_height(spr_pausecomplex))
    vspeedsprite = 0;

scalepause = lerp(scalepause, 0.82, 0.15);
