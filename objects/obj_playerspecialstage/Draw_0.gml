spritereal = global.danikyo ? spr_danikyo : sprite_index;
pal_swap_set(spr_palette, paletteselect, 0);
draw_sprite_ext(spritereal, image_index, x + xx + shakeboth(xH), y + shakeboth(yH), xscale, yscale, angle, image_blend, image_alpha);
shader_reset();

if (flash)
{
    gpu_set_fog(true, c_white, 1, 1);
    draw_sprite_ext(spritereal, image_index, x + xx + shakeboth(xH), y + shakeboth(yH), xscale, yscale, angle, image_blend, image_alpha);
    gpu_set_fog(false, c_black, 0, 0);
}
