function scr_hungrypillar_hit()
{
    if (!instance_exists(obj_backgroundchange))
        instance_create(x, y, obj_backgroundchange);
    
    X = hitX + random_range(-6, 6);
    Y = hitY + random_range(-6, 6);
    hitLag--;
    sprite_index = spr_hungrypillar_dead;
    
    if (hitLag <= 0)
        instance_destroy();
}
