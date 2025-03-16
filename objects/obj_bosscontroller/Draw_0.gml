if (state < boss_states.intro3)
{
    draw_set_color(c_black);
    draw_rectangle(0, 0, obj_screen.actualWidth, obj_screen.actualHeight, false);
}

if (spotlight_radius < obj_screen.actualWidth)
{
    surface_set_target(surf);
    draw_clear_alpha(c_black, 1);
    gpu_set_blendmode(bm_add);
    draw_set_alpha(0.4);
    draw_set_color(c_black);
    draw_rectangle(0, 0, obj_screen.actualWidth, obj_screen.actualHeight, false);
    gpu_set_blendmode(bm_subtract);
    draw_set_color(c_white);
    draw_set_alpha(1);
    draw_circle(par_boss.x, par_boss.y, spotlight_radius, false);
    gpu_set_blendmode(bm_normal);
    surface_reset_target();
    draw_set_alpha(1);
    draw_surface(surf, 0, 0);
}
