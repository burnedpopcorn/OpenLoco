if (!instance_exists(obj_textbox) && !instance_exists(obj_titlecard))
{
    draw_sprite(spr_pointstotal, -1, obj_screen.actualWidth - 120, obj_screen.actualHeight - 100);
    draw_set_font(global.bigfont);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text(823, 440, string(global.pointstotal));
    draw_sprite(spr_ranks_hud, 5, 800, 300);
    draw_sprite(spr_ranks_hudfill, 5, 800, 300);
    draw_set_font(global.bigfont);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_text(870, 300, "X" + string(global.lcoins));
}
