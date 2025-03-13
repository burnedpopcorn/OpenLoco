pal_swap_set(get_charactersprite("spr_palette", obj_player1), obj_player1.paletteselect, 0);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_xscale, image_angle, image_blend, image_alpha);
shader_reset();
