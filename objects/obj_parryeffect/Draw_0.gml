if (sprite_exists(sprite_index))
{
    if (palette != -4)
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
