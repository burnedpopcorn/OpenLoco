if (live_call())
    return global.live_result;

if (surface_exists(global.parallaxbg_surface))
{
    var shd = 0;
    
    if (instance_exists(obj_backgroundchange) || global.panic)
        shd = 1;
    
    if (shd == 1)
    {
        shader_set(shd_panicbg);
        var panicbgColor = 255;
        
        if (global.lap3activate)
            panicbgColor = 8388736;
        
        shader_set_uniform_f_ext(shd_panicbg, "red", color_get_red(panicbgColor) / 255);
        shader_set_uniform_f_ext(shd_panicbg, "green", color_get_green(panicbgColor) / 255);
        shader_set_uniform_f_ext(shd_panicbg, "blue", color_get_blue(panicbgColor) / 255);
        var panic_id = shader_get_uniform(shd_panicbg, "panic");
        shader_set_uniform_f(panic_id, 1);
        var time_id = shader_get_uniform(shd_panicbg, "time");
        shader_set_uniform_f(time_id, current_time / 1000);
    }
    
    draw_surface(global.parallaxbg_surface, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]));
    shader_reset();
    draw_set_alpha(flash);
    draw_set_color(c_white);
    draw_rectangle(camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]), camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]), false);
    draw_set_alpha(1);
}
