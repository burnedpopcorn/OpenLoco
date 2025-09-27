function reset_shader_fix()
{
    if (shader_current() != -1)
        shader_reset();
    
    shader_set(shd_alphafix);
}

function window_to_gui_x(_x)
{
    var _win_pos = _x / window_get_width();
    return display_get_gui_width() * _win_pos;
}

function window_to_gui_y(_y)
{
    var _win_pos = _y / window_get_height();
    return display_get_gui_height() * _win_pos;
}

function window_to_gui_xscale(_xscale)
{
    return (_xscale * display_get_gui_width()) / window_get_width();
}

function window_to_gui_yscale(_yscale)
{
    return (_yscale * display_get_gui_height()) / window_get_height();
}
