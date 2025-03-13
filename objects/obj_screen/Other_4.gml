view_enabled = true;
view_visible[0] = true;

while (surface_get_target() != -1 && surface_get_target() != application_surface)
    surface_reset_target();
