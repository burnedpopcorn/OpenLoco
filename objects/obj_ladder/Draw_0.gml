if (visible)
{
    for (var i = 0; i < abs(image_yscale); i++)
        draw_sprite_ext(sprite_index, image_index, x, y + (32 * i * sign(image_yscale)), image_xscale, 1, image_angle, image_blend, image_alpha);
}
