if (state == 5)
{
    with (instance_create(x, y, obj_afterimage))
    {
        sprite_index = other.sprite_index;
        image_xscale = other.xscale;
        image_index = other.image_index - 1;
    }
    
    alarm[2] = 8;
}
else
{
    effectappear = 0;
}
