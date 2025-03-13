draw_rectangle_color(0, 0, 960, 540, c_black, c_black, c_black, c_black, 0);
draw_set_font(global.bigfont);
draw_set_halign(fa_center);
draw_set_color(c_white);
var _os = optionselected;
draw_text(480, 200, langstr_get("EraseGame_YouSureBro"));
draw_text_colour(400, 300, langstr_get("EraseGame_No"), c_white, c_white, c_white, c_white, (_os == 0) ? 1 : 0.5);
draw_text_colour(560, 300, langstr_get("EraseGame_Yes"), c_white, c_white, c_white, c_white, (_os == 1) ? 1 : 0.5);
