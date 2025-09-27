if (sPauseGUI != noone)
{
    draw_sprite_ext(sPause, -1, obj_screen.actualWidth / 2, obj_screen.actualHeight / 2, scalepause, scalepause, 0, c_white, 1);
    draw_sprite_ext(sPauseGUI, -1, obj_screen.actualWidth / 2, obj_screen.actualHeight / 2, scalepause, scalepause, 0, c_white, 1);
}

var index = global.language == "eng";
pal_swap_set(spr_dsipausepalette, obj_pause.dsipalette, false);
draw_sprite_tiled_ext(spr_pausecomplex, index, 0, vspeedsprite, 1, 1, c_white, obj_pause.alphapausetile);
shader_reset();
reset_shader_fix();
