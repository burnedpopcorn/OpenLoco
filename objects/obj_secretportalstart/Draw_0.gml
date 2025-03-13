if (sprite_exists(sprite_index))
{
    pal_swap_set(spr_eggpalette, paletteselect, false);
    draw_self();
    shader_reset();
}
