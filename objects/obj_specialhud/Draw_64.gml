draw_set_alpha(alpha);
draw_set_font(global.bigfont);
draw_set_halign(fa_left);
draw_set_color(c_white);
draw_text(32, 32, "POINTS: " + string(global.collectspecial) + " OF " + string(global.collectspecialmax));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color((global.secondsspecial <= 30 && global.minutesspecial <= 0) ? c_red : c_white);

if (global.secondsspecial < 10)
    draw_text_transformed(480, 476, string_hash_to_newline(string_hash_to_newline(string(global.minutesspecial) + ":0" + string(global.secondsspecial))), xscaletimer, yscaletimer, angletimer);
else if (global.secondsspecial >= 10)
    draw_text_transformed(480, 476, string_hash_to_newline(string_hash_to_newline(string(global.minutesspecial) + ":" + string(global.secondsspecial))), xscaletimer, yscaletimer, angletimer);
