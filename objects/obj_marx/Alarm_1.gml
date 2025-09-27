var _bodypart_array = [spr_marx_leftshoeNEW, spr_marx_rightshoeNEW, spr_marx_bowtie, spr_marx_leftwingNEW, spr_marx_rightwingNEW, spr_marx_hexagonleftNEW, spr_marx_hexagonrightNEW, sprite_index];
var _xposition_array = [leftshoex, rightshoex, tiex, leftwingsx, rightwingsx, lefthexagonx, righthexagonx, x];
var _yposition_array = [leftshoey, rightshoey, tiey, leftwingsy, rightwingsy, lefthexagony, righthexagony, y];
// cant convert to hex colors for some bullshit reason
// but here's the array with the actual values
// [#A850F8, #F8E000, #58C000, #30A8F8, #F80000]
var _color_array = [16273576, 57592, 49240, 16295984, 248];

for (var i = 0; i < array_length(_bodypart_array); i++)
{
    with (instance_create(_xposition_array[i], _yposition_array[i], obj_afterimage))
    {
        image_index = other.image_index;
        sprite_index = _bodypart_array[i];
        image_blend = _color_array[irandom_range(0, array_length(_color_array) - 1)];
        
        output_modifier = function()
        {
            gpu_set_fog(true, image_blend, 1, 1);
        };
        
        output_resetter = function()
        {
            gpu_set_fog(false, c_black, 0, 0);
        };
    }
}

alarm[1] = 3;
