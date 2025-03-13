repeat (6)
{
    with (instance_create(x + random_range(-100, 100), y + random_range(-100, obj_crashgame), obj_balloonpop))
        sprite_index = spr_shotgunimpact;
}
