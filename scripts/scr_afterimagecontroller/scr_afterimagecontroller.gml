function create_afterimage(_unused = 0, _spr_index = sprite_index, _img_index = image_index, _img_speed = 0, _xscale = image_xscale, _yscale = image_yscale, _angle = image_angle, _alpha = 0.8, _blend = image_blend)
{
    var _afterimg = 
    {
        sprite_index: _spr_index,
        image_index: _img_index,
        image_speed: _img_speed,
        image_xscale: _xscale,
        image_yscale: _yscale,
        image_angle: _angle,
        image_alpha: _alpha,
        image_blend: _blend
    };
    array_push(global.afterimage_array, _afterimg);
}
