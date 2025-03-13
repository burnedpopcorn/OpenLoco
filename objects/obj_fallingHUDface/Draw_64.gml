if (obj_player1.spotlight == 0)
    pal_swap_set(get_charactersprite("spr_palette", obj_player1), obj_player1.paletteselect, 0);

if (obj_player1.spotlight == 1)
    pal_swap_set(get_charactersprite("spr_palette", obj_player2), obj_player2.paletteselect, 0);

draw_sprite(sprite, -1, X, Y);
shader_reset();
