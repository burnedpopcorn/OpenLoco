var X = irandom_range(-1, 1);
var Y = irandom_range(-1, 1);
draw_set_color(c_white);
draw_sprite(sprite_index, 0, x + X, y + Y);
var lapfont = __scribble_font_add_sprite_ext(spr_lapfont, "0123456789", 1, 0);
draw_set_font(lapfont);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(512 + X, y + 32 + Y, string(global.laps));
