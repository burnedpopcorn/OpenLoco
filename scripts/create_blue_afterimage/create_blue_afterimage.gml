function create_blue_afterimage(argument0, argument1, argument2, argument3, argument4)
{
    with (create_afterimage(argument0, argument1, argument2, argument3))
    {
        alarm[0] = -1;
        alarm[1] = -1;
        alarm[2] = -1;
        image_xscale = argument4;
        image_blend = #2C7EE4;
        alpha = 1.25;
    }
    
    exit;
}
