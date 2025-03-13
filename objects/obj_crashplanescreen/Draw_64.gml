var this_year = date_get_year(date_current_datetime());
draw_set_color(c_black);
draw_rectangle(0, 0, 960, 540, false);
draw_set_alpha(alpha);
draw_set_font(global.bigfont);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_text(480, 270, "R.I.P PLANE PASSENGERS\n\n\n19XX . " + string(this_year));
draw_set_alpha(1);
