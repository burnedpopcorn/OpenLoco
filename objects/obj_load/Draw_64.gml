if (variable_instance_exists(id, "screen") && variable_instance_exists(id, "screen_gui") && variable_instance_exists(id, "drawscreen") && drawscreen)
{
    draw_sprite(screen, 0, 0, 0);
    draw_sprite(screen_gui, 0, 0, 0);
    draw_set_font(global.bigfont);
    draw_set_halign(fa_left);
    draw_set_valign(fa_bottom);
    draw_text(10, 525, "LOADING...");
}

if (room != rm_load)
    exit;

var _indx = state;
_indx = clamp(_indx, 0, array_length(data.loadsprites) - 1);
draw_sprite_ext(data.loadsprites[_indx], 0, 10, 428, 2, 2, 0, c_white, 1);
draw_set_font(global.bigfont);
draw_text(89, 460, string_upper(data.loadtext[_indx]));
