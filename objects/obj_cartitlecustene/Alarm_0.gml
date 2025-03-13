exit;

with (instance_create(x - 100, y, obj_transpimage))
{
    image_xscale = 1;
    sprite_index = other.sprite_index;
    hspeed = -3;
}

alarm[0] = 3;
