/// @description Approach the value towards target provided.
/// @param value The value to be changed.
/// @param target The value targetted.
/// @param amount The amount to change.
function approach(value, target, amount) {
	return value + clamp(target - value, -abs(amount), abs(amount));
}

function chance(num)
{
    return num > random(1);
}

function animation_end(imgindex = floor(image_index), imgframe = image_number - 1)
{
    return imgindex >= imgframe;
}
