if (room != rm_titlecard && room != Disclamer && room != rm_titleselect)
{
    draw_set_font(global.smallfont);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_set_color(c_white);
    draw_sprite(spr_roomnamebg, 0, xi, yi);
    draw_text(xi, yi, string_hash_to_newline(message));
}
