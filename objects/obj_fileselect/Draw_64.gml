if (!instance_exists(obj_erasegame))
{
    draw_set_font(global.bigfont);
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    var fs = fileselect;
    draw_text_color(480, 100, (deletearchive == 1) ? langstr_get("FileSelect_Delete") : langstr_get("FileSelect_Choose"), c_white, c_white, c_white, c_white, alpha);
    draw_text_color(480, 240, langstr_get("FileSelect_File1"), c_white, c_white, c_white, c_white, ((fs == 1) ? 1 : 0.5) * alpha);
    draw_text_color(480, 304, langstr_get("FileSelect_File2"), c_white, c_white, c_white, c_white, ((fs == 2) ? 1 : 0.5) * alpha);
    draw_text_color(480, 368, langstr_get("FileSelect_File3"), c_white, c_white, c_white, c_white, ((fs == 3) ? 1 : 0.5) * alpha);
}
