var lx = camera_get_view_x(view_camera[0]) + (camera_get_view_width(view_camera[0]) / 2);
var ly = camera_get_view_y(view_camera[0]) + (camera_get_view_height(view_camera[0]) / 2);
x = lx;
y = ly;
audio_listener_position(lx, ly, 0);
audio_falloff_set_model(audio_falloff_linear_distance);
audio_listener_orientation(0, 0, -1, 0, 1, 0);
