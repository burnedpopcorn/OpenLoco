shader_set(global.Pal_Shader);
pal_swap_set(get_charactersprite("spr_palette", obj_player1), obj_player1.paletteselect, 0);
draw_self();
shader_reset();
