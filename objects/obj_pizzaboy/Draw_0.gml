pal_swap_set(spr_miiboypalette, paletteselect, 0);
draw_sprite_ext(sprite_index, mii_index, x, y + stundraw, xscale * image_xscale, yscale, image_angle, image_blend, image_alpha);
shader_reset();

if (flash)
{
    gpu_set_fog(true, c_white, 1, 1);
    draw_sprite_ext(sprite_index, mii_index, x, y + stundraw, xscale * image_xscale, yscale, image_angle, image_blend, image_alpha);
    gpu_set_fog(false, c_black, 0, 0);
}
