function create_blue_afterimage(_unused, _spr_index, _img_index, _img_speed, _xscale)
{
    with (create_afterimage(_unused, _spr_index, _img_index, _img_speed))
    {
        alarm[0] = -1;
        alarm[1] = -1;
        alarm[2] = -1;
        image_xscale = _xscale;
        image_blend = #2C7EE4;
        alpha = 1.25;
    }
}
