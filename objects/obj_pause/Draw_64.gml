if (!pause)
    exit;

var ty = 0;

if (cantmove == 0)
{
    draw_set_alpha(alphapause);
    var pad = 48;
    draw_set_font(global.bigfont);
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    pad = 32;
    
    for (var i = 0; i < array_length(pause_options_array); i++)
    {
        var p = pause_options_array[i];
        var sc = scaletext;
        var c = c_white;
        ty += ((32 + pad) / 2);
        draw_text_transformed_color(obj_screen.actualWidth / 2, ((obj_screen.actualHeight / 2) + ((32 + pad) * i)) - ty, p, sc, sc, 0, c, c, c, c, ((i == selected) ? 1 : 0.5) * alphapause);
    }
    
    draw_set_alpha(1);
}
