draw_sprite(titlecard_sprite, 0, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]));
var _dropshadow_offset = 0;
var _xshake = irandom_range(-1, 1);
var _yshake = irandom_range(-1, 1);

if (title_x == 0)
    _dropshadow_offset = Approach(_dropshadow_offset, 10, 0.1);

draw_set_color(c_black);
draw_sprite(title_sprite, 0, camera_get_view_x(view_camera[0]) + title_x + _xshake + _dropshadow_offset, camera_get_view_y(view_camera[0]) + _yshake + _dropshadow_offset);
draw_set_color(c_white);
draw_sprite(title_sprite, 0, camera_get_view_x(view_camera[0]) + title_x + _xshake, camera_get_view_y(view_camera[0]) + _yshake);
draw_set_color(c_black);
draw_set_alpha(fade_alpha);
draw_rectangle(0, 0, room_width, room_height, false);
draw_set_alpha(1);
draw_set_color(c_white);
