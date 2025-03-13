instance_destroy();

repeat (6)
{
    var key_off = get_shake(other.sprite_width);
    
    with (instance_create(other.x + key_off.x, other.y + key_off.y, obj_keyeffect))
        image_index = irandom(image_number - 1);
}
