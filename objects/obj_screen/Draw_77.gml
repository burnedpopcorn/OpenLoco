if (app_scale <= 0)
    exit;

application_surface_draw_enable(0);
draw_set_alpha(1);
gpu_set_blendmode(bm_normal);
draw_set_color(c_white);

if (frac(app_scale) > 0)
    gpu_set_texfilter(true);
else
    gpu_set_texfilter(false);

var off = 100;
var c = c_white;
draw_sprite_tiled(spr_pausecomplex, 0, bgX, bgY);
gpu_set_blendenable(false);
var shd = 0;

if (instance_exists(obj_backgroundchange) || global.panic)
    shd = 1;

if (shd == 1)
{
    shader_set(shd_panicfx);
    
    if (starting_fill < global.fill)
        flash_color = 16711680;
    else if (starting_fill >= global.fill && !global.lap3activate)
        flash_color = 255;
    else if (starting_fill >= global.fill && global.lap3activate)
        flash_color = 8388736;
    
    shader_set_uniform_f_ext(shd_panicfx, "red", color_get_red(flash_color) / 255);
    shader_set_uniform_f_ext(shd_panicfx, "green", color_get_green(flash_color) / 255);
    shader_set_uniform_f_ext(shd_panicfx, "blue", color_get_blue(flash_color) / 255);
    var panic_id = shader_get_uniform(shd_panicfx, "panic");
    shader_set_uniform_f(panic_id, 1);
    var time_id = shader_get_uniform(shd_panicfx, "time");
    shader_set_uniform_f(time_id, current_time / 1000);
}

draw_surface_ext(application_surface, (window_get_width() / 2) - ((surface_get_width(application_surface) * app_scale) / 2), (window_get_height() / 2) - ((surface_get_height(application_surface) * app_scale) / 2), app_scale, app_scale, 0, c_white, 1);
shader_reset();
gpu_set_blendenable(true);
gpu_set_texfilter(false);
