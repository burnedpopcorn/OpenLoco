if (!instance_exists(obj_ghostcollectibles))
    create_debris(random_range(camera_get_view_x(view_camera[0]), camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0])), camera_get_view_y(view_camera[0]) + 10, spr_debris, 0);

alarm[0] = 7;
