if (!instance_exists(obj_option) && !instance_exists(obj_erasegame) && !instance_exists(obj_fileselect))
{
    var title_yoff = sin(time / 20) * 5;
    draw_set_font(global.bigfont);
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    draw_sprite(spr_title, -1, 282.5, 32 + title_yoff);
    var opt = optionselect;
    var yoff = 40;
    draw_text_color(480, 240 + yoff, langstr_get("TitlescreenOption_StartGame"), c_white, c_white, c_white, c_white, (opt == 0) ? 1 : 0.5);
    draw_text_color(480, 304 + yoff, langstr_get("TitlescreenOption_Options"), c_white, c_white, c_white, c_white, (opt == 1) ? 1 : 0.5);
    draw_text_color(480, 368 + yoff, langstr_get("TitlescreenOption_EraseData"), c_white, c_white, c_white, c_white, (opt == 2) ? 1 : 0.5);
    draw_text_color(480, 432 + yoff, langstr_get("TitlescreenOption_Credits"), c_white, c_white, c_white, c_white, (opt == 3) ? 1 : 0.5);
}
