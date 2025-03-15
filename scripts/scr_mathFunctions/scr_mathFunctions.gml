/// @description Approach the value towards target provided.
/// @param value The value to be changed.
/// @param target The value targetted.
/// @param amount The amount to change.
function approach(value, target, amount) {
	return value + clamp(target - value, -abs(amount), abs(amount));
}

function chance(argument0)
{
    return argument0 > random(1);
}

function animation_end(argument0 = floor(image_index), argument1 = image_number - 1)
{
    return argument0 >= argument1;
}
