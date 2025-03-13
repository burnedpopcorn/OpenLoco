depth = 1;
solid_inst = -4;

if (image_yscale == 1)
{
    with (instance_create(x, y + 32, obj_solid))
    {
        image_xscale = 2;
        other.solid_inst = id;
    }
}

if (image_yscale == -1)
{
    with (instance_create(x, y, obj_solid))
    {
        image_xscale = 2;
        other.solid_inst = id;
    }
}
