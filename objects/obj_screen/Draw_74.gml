if (!surface_exists(guiSurface))
    guiSurface = surface_create(display_get_gui_width(), display_get_gui_height());

if (surface_get_width(guiSurface) != display_get_gui_width() || surface_get_height(guiSurface) != display_get_gui_height())
    surface_resize(guiSurface, display_get_gui_width(), display_get_gui_height());

surface_set_target(guiSurface);
draw_clear_alpha(c_black, 0);
shader_set(shd_alphafix);
reset_blendmode();
reset_shader_fix();
