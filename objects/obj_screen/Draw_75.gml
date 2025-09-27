surface_reset_target();
shader_reset();
draw_set_alpha(1);

if (!surface_exists(guiSurface))
{
    gpu_set_blendmode(bm_normal);
    exit;
}

if (surface_exists(guiSurface))
    draw_surface(guiSurface, 0, 0);

gpu_set_blendmode(bm_normal);
gpu_set_texfilter(false);

if (instance_exists(obj_pause))
{
    with (obj_pause)
    {
        pal_swap_set(spr_dsipausepalette, obj_pause.dsipalette, false);
        draw_sprite_ext(spr_dsipause, -1, 480, 270, scaledsi, scaledsi, 0, c_white, 1);
        shader_reset();
    }
}

if (mouseVisible)
{
    var mouse_delta = 
    {
        x: device_mouse_x_to_gui(0) - previousX,
        y: device_mouse_y_to_gui(0) - previousY
    };
    var sc_x = 1 - (mouse_delta.x / 10);
    var sc_y = 1 + (mouse_delta.y / 10);
    var mouseClicked = mouse_check_button(mb_left);
    var sc = mouseClicked ? 0.7 : 1;
    
    for (var i = 0; i < ds_list_size(afterimg); i++)
    {
        var b = afterimg[| i];
        
        if (!is_undefined(b))
        {
            with (b)
            {
                alpha = Approach(alpha, 0, 0.1);
                
                if (alpha == 0)
                {
                    ds_list_delete(other.afterimg, i);
                    b = undefined;
                    i--;
                }
                
                pal_swap_set(spr_mousepalette, other.palette, false);
                draw_sprite_ext(spr_mouse, 0, x, y, sc, sc, 0, color, alpha);
                shader_reset();
            }
        }
    }
    
    pal_swap_set(spr_mousepalette, palette, false);
    draw_sprite_ext(spr_mouse, -1, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), sc * sc_x, sc * sc_y, 0, c_white, generalAlpha);
    shader_reset();
}
