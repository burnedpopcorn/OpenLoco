function scr_panicbg_end()
{
    if (event_type == ev_draw && event_number == 0)
    {
        if (surface_exists(global.panicbg_surface))
        {
            surface_reset_target();
            shader_set(global.lap3activate ? shd_lap3bg : shd_panicbg);
            var panic_id = shader_get_uniform(global.lap3activate ? shd_lap3bg : shd_panicbg, "panic");
            shader_set_uniform_f(panic_id, global.wave / global.maxwave);
            var time_id = shader_get_uniform(global.lap3activate ? shd_lap3bg : shd_panicbg, "time");
            shader_set_uniform_f(time_id, current_time / 1000);
            draw_surface(global.panicbg_surface, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]));
            shader_reset();
        }
    }
}
