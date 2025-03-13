function reset_shader_fix()
{
    if (shader_current() != -1)
        shader_reset();
    
    shader_set(shd_alphafix);
}

function window_to_gui_x(argument0)
{
    var _win_pos = argument0 / window_get_width();
    return display_get_gui_width() * _win_pos;
}

function window_to_gui_y(argument0)
{
    var _win_pos = argument0 / window_get_height();
    return display_get_gui_height() * _win_pos;
}

function window_to_gui_xscale(argument0)
{
    return (argument0 * display_get_gui_width()) / window_get_width();
}

function window_to_gui_yscale(argument0)
{
    return (argument0 * display_get_gui_height()) / window_get_height();
}
