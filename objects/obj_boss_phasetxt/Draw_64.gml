draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_set_color(c_white);
draw_set_font(global.bigfont);
draw_set_alpha(image_alpha);
sheight = string_height(text) * image_yscale * 2;
var shake = get_shake(5);
draw_text_transformed((obj_screen.actualWidth / 2) + shake.x, 100 + shake.y + y, text, image_xscale, image_yscale, image_angle);
draw_set_alpha(1);
