function scr_panicbg_start()
{
    if (!variable_global_exists("panicbg_surface") || !surface_exists(global.panicbg_surface))
        global.panicbg_surface = surface_create(obj_screen.actualWidth, obj_screen.actualHeight);
    
    if (event_type == ev_draw && event_number == 0)
    {
        surface_set_target(global.panicbg_surface);
        draw_clear_alpha(c_black, 0);
        var arr = 
		[
			"Backgrounds_", 
			"Backgrounds_Ground", 
			"Backgrounds_still", 
			"Backgrounds_skystill", 
			"Backgrounds_sky"
		];
        
        for (var i = 0; i < array_length(arr); i++)
        {
            for (var o = 0; o < 10; o++)
            {
                var _id = layer_get_id(arr[i] + string(o));
                
                if (_id != -1)
                {
                    layer_x(_id, layer_get_x(_id) - camera_get_view_x(view_camera[0]));
                    layer_y(_id, layer_get_y(_id) - camera_get_view_y(view_camera[0]));
                }
            }
        }
    }
}
