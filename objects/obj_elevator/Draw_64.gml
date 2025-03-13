draw_set_alpha(alpha);
draw_set_font(global.bigfont);
draw_set_color(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
var width = array_reduce(levels, function(argument0, argument1, argument2)
{
    return max(argument0, string_width(argument1.name));
}, 0);
var l_inc = string_height("A") + 20;
var height = array_length(levels) * l_inc;
var pad = 20;
var ww = obj_screen.actualWidth / 2;
var hh = obj_screen.actualHeight / 2;
var yoff = sin(++time / 20) * 5;
var xx = ww - (width / 2);
var yy = (hh - (height / 2)) + (pad / 2) + yoff;
draw_roundrect((xx - pad) * xscale, ((yy - pad) * yscale) + yoff, (ww + (width / 2) + pad) / xscale, (hh + (height / 2) + yoff) / yscale, false);
draw_set_color(c_purple);
draw_roundrect((xx - pad) * xscale, ((yy - pad) * yscale) + yoff, (ww + (width / 2) + pad) / xscale, (hh + (height / 2) + yoff) / yscale, true);

for (var i = 0; i < array_length(levels); i++)
{
    var level = levels[i];
    draw_set_color((i == selected) ? c_gray : c_white);
    draw_text_transformed(obj_screen.actualWidth / 2, yy, level.name, xscale / 1, yscale / 1, 0);
    yy += l_inc;
}
