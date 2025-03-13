var xx = obj_player1.x;
var yy = obj_player1.y - 100;
var title_x = xx;
var title_y = yy + 30;
var text_x = xx;
var text_y = yy + 60;

if (shake_timer > 0)
{
    title_x += irandom_range(-5, 5);
    title_y += irandom_range(-5, 5);
}

draw_set_font(global.smallfont);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
var title = floor(combo / 5);
title = clamp(title, 0, floor(sprite_get_number(spr_comboend_title1) / 5));
draw_sprite(spr_comboend, 0, xx, yy);
draw_sprite_ext(spr_comboend_title1, (title * 2) + title_index, title_x, title_y, scale, scale, 0, c_white, 1);
draw_text(text_x, text_y, comboscore);
