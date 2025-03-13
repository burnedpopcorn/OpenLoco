function approach(argument0, argument1, argument2)
{
    return argument0 + clamp(argument1 - argument0, -abs(argument2), abs(argument2));
}

function chance(argument0)
{
    return argument0 > random(1);
}

function animation_end(argument0 = floor(image_index), argument1 = image_number - 1)
{
    return argument0 >= argument1;
}
