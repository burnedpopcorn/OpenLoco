function create_afterimage(argument0 = UnknownEnum.Value_0, argument1 = sprite_index, argument2 = image_index, argument3 = 0, argument4 = image_xscale, argument5 = image_yscale, argument6 = image_angle, argument7 = 0.8, argument8 = image_blend)
{
    var _afterimg = 
    {
        sprite_index: argument1,
        image_index: argument2,
        image_speed: argument3,
        image_xscale: argument4,
        image_yscale: argument5,
        image_angle: argument6,
        image_alpha: argument7,
        image_blend: argument8
    };
    array_push(global.afterimage_array, _afterimg);
}
