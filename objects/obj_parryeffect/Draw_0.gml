if (sprite_exists(sprite_index))
{
    if (palette != noone)
    {
        pal_swap_set(palette, paletteindex, false);
        draw_self();
        shader_reset();
    }
    else
    {
        draw_self();
    }
}
