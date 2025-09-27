if (live_call())
    return global.live_result;

pal_swap_set(get_charactersprite("spr_palette", obj_player1), obj_player1.paletteselect, 0);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
shader_reset();
draw_sprite_ext(spr_rankcurtainL, 0, sprite_get_width(spr_rankcurtainL) * curtain_xpos_mult, curtain_ypos, 1, 1, 0, c_white, 1);
draw_sprite_ext(spr_rankcurtainR, 0, 960 - (sprite_get_width(spr_rankcurtainL) * curtain_xpos_mult), curtain_ypos, 1, 1, 0, c_white, 1);
draw_sprite(spr_rankstatsTV, 0, 20, stats_monitor_ypos);
draw_sprite(spr_ranklapcounter, 0, 704, lap_monitor_ypos);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_font(global.scorefont);
draw_text(807, lap_monitor_ypos + 64, string(laps));
var img = 0;

switch (rank)
{
    case "l":
        img = 5;
        break;
    
    case "s":
        img = 4;
        break;
    
    case "a":
        img = 3;
        break;
    
    case "b":
        img = 2;
        break;
    
    case "c":
        img = 1;
        break;
    
    default:
        img = 0;
        break;
}

draw_set_font(global.minifont);
var points_shake = stats_points_shake_time ? irandom_range(-1, 1) : 0;
draw_text(155 + points_shake, stats_monitor_ypos + 134 + points_shake, floor(stats_points));
var time_shake = stats_time_shake_time ? irandom_range(-1, 1) : 0;
var mins = (string_length(string(time_mins)) == 1) ? ("0" + string(time_mins)) : string(time_mins);
var secs = (string_length(string(time_secs)) == 1) ? ("0" + string(time_secs)) : string(time_secs);
stats_time = concat(mins, ":", secs, ":", time_mms);
draw_text(121 + time_shake, stats_monitor_ypos + 171 + time_shake, stats_time);

if (rank_visible)
    draw_sprite_ext(spr_rankresult, img, 143, stats_monitor_ypos + 214, rank_scale, rank_scale, 0, c_white, 1);

for (var i = 0; i < (array_length(Lrank_array) - 1); i++)
{
    with (Lrank_array[i])
    {
        scale = Approach(scale, 1, 0.2);
        
        if (scale == 1 && !impact)
        {
            shake = 20;
            impact = 1;
        }
        
        if (shake > 0)
            shake--;
        
        draw_sprite_ext(spr_rankresult, img, 159 + (16 * i) + irandom_range(-sign(shake), sign(shake)), other.stats_monitor_ypos + 214 + irandom_range(-sign(shake), sign(shake)), scale, scale, 0, c_white, 1);
    }
}

if (extraLs > 0)
{
    draw_set_font(global.bigfont);
    draw_text(292, 200, concat("X", (string_length(string(extraLs)) == 1) ? ("0" + string(extraLs)) : extraLs));
}

if (show_treasure)
    draw_sprite_ext(spr_ranktreasure, 0, 140, 394, treasure_scale, treasure_scale, 0, gottreasure ? c_white : c_black, 1);

draw_sprite_ext(spr_ranktable, 0, table_x, table_y, 1, 1, 0, c_white, 1);

for (var i = 0; i < array_length(toppin_arr); i++)
{
    var toppinPad = 92;
    var t = toppin_arr[i];
    
    if (t.shake > 0)
        t.shake--;
    
    draw_sprite_ext(t.sprite_index, 0, table_x + 87 + (toppinPad * i) + irandom_range(-sign(t.shake), sign(t.shake)), (table_y - 26 - t.offset) + irandom_range(-sign(t.shake), sign(t.shake)), 1, 1, 0, c_white, 1);
}

var w1 = Wave(-50, 50, 4, 0);

for (var ii = 0; ii < array_length(egg_arr); ii++)
{
    var ei = 0;
    var e = egg_arr[ii];
    
    if (e.done)
        ei = 1;
    
    if (e.shake > 0)
        e.shake--;
    
    draw_sprite(spr_rankresultegg, ei, eggs_x + irandom_range(-sign(e.shake), sign(e.shake)) + (64 * ii), eggs_y + Wave(-50, 50, 4 + ii, 0) + irandom_range(-sign(e.shake), sign(e.shake)));
}

light_len = Wave(50, 200, 4, 0);

if (light_angle > 360)
    light_angle = 0;

light_angle += 5;

if (!surface_exists(dark_surface))
    dark_surface = surface_create(obj_screen.actualWidth, obj_screen.actualWidth);
else
{
    surface_set_target(dark_surface);
    draw_set_alpha(dark_alpha);
    draw_rectangle_color(0, 0, obj_screen.actualWidth, obj_screen.actualHeight, c_black, c_black, c_black, c_black, false);
    draw_set_alpha(1);
    gpu_set_blendmode(bm_subtract);
    draw_circle(mouse_x + irandom_range(-1, 1), mouse_y + irandom_range(-1, 1), 125 * light_scale, false);
    draw_circle(480 + lengthdir_x(light_len, light_angle), 270 + lengthdir_y(light_len, light_angle), 100, false);
    draw_circle(480 + lengthdir_x(light_len, light_angle - 180), 270 + lengthdir_y(light_len, light_angle - 180), 100, false);
    gpu_set_blendmode(bm_normal);
    surface_reset_target();
    draw_surface_ext(dark_surface, 0, 0, 1, 1, 0, c_white, dark_alpha);
}
