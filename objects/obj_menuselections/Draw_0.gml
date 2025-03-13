if (levelselect == 1)
{
    draw_set_font(global.bigfont);
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_text(x, y, string_hash_to_newline(level[b]));
    draw_text(x, y + 40, string_hash_to_newline("PRESS UP AND DOWN TO\n SELECT THE LEVEL"));
}

draw_self();
