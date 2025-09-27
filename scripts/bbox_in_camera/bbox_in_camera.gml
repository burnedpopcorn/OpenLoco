function bbox_in_camera(_cam, _size = 0)
{
    var cam_x = camera_get_view_x(_cam);
    var cam_y = camera_get_view_y(_cam);
    var cam_w = camera_get_view_width(_cam);
    var cam_h = camera_get_view_height(_cam);
    return bbox_left < (cam_x + cam_w + _size) && bbox_right > (cam_x - _size) && bbox_top < (cam_y + cam_h + _size) && bbox_bottom > (cam_y - _size);
}
