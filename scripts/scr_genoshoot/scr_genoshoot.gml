function scr_genoshoot(_downwards = false)
{
    breakdance_pressed = 0;
    genodelay = genodelay_max;
    
    if (geno_beamcharges < 3)
        geno_beamcharges++;
    
    state = states.shotgun;
    
    with (instance_create(x, y, obj_pistoleffect))
        image_xscale = other.xscale;
    
    image_index = 0;
    sprite_index = spr_shotgunshoot;
    
    if (_downwards)
    {
        with (instance_create(x + (xscale * 20), y + 20, obj_genobullet))
            downwards = true;
    }
    else
        instance_create(x + (xscale * 20), y + 20, obj_genobullet);
}
