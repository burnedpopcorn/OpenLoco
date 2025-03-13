if (arrows)
{
    instance_create(camera_get_view_x(view_camera[0]) + random_range(0, 960), camera_get_view_y(view_camera[0]) - 32, obj_marxarrow);
    alarm[5] = random_range(50, 70);
}
