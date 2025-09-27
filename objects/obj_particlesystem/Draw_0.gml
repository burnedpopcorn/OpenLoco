if (!ds_list_empty(global.debris_list))
{
    for (var i = 0; i < ds_list_size(global.debris_list); i++)
    {
        var q = global.debris_list[| i];
        
        if (is_struct(q))
        {
            if (q.palette_spr != 0)
                pal_swap_set(q.palette_spr, q.palette, false);
            
            draw_sprite_ext(q.sprite_index, q.image_index, q.x, q.y, 1, 1, q.image_angle, c_white, q.alpha);
            
            if (q.palette_spr != 0)
                shader_reset();
        }
    }
}

if (!ds_list_empty(global.collect_list))
{
    for (var i = 0; i < ds_list_size(global.collect_list); i++)
    {
        var b = global.collect_list[| i];
        
        if (is_struct(b))
        {
            var cx = camera_get_view_x(view_camera[0]);
            var cy = camera_get_view_y(view_camera[0]);
            
            if (b.colorpalettesprite != noone)
            {
                pal_swap_set(b.colorpalettesprite, b.colorpalette, 0);
                draw_sprite_ext(b.sprite_index, b.image_index, b.x + cx, b.y + cy, 1, 1, 0, c_white, 1);
                shader_reset();
            }
            else
            {
                draw_sprite_ext(b.sprite_index, b.image_index, b.x + cx, b.y + cy, 1, 1, 0, c_white, 1);
            }
        }
    }
}
