if (!surface_exists(surf))
    surf = surface_create(camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));
else if (view_current == 0)
    draw_surface(surf, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]));
