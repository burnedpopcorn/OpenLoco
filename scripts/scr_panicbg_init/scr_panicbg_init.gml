// unused
function scr_panicbg_init() { }

function scr_parallax_init()
{
    if (array_length(BG_arr) == 0)
        exit;
    
    var bottom_id = BG_arr[0];
    var top_id = BG_arr[array_length(BG_arr) - 1];
    layer_script_begin(bottom_id, scr_parallax_start);
    layer_script_end(top_id, scr_parallax_end);
    depth = layer_get_depth(top_id) - 1;
}

function scr_parallax_start()
{
    if (!surface_exists(global.parallaxbg_surface))
        global.parallaxbg_surface = surface_create(obj_screen.actualWidth, obj_screen.actualHeight);
    
    if (event_type == ev_draw && event_number == 0)
    {
        surface_set_target(global.parallaxbg_surface);
        draw_clear_alpha(c_black, 0);
        
		// fix plane crash crash
		// crashes because gamemaker update shit
		try 
		{
	        for (var i = 0; i < array_length(obj_parrallax.BG_arr); i++)
	        {
	            var _id = obj_parrallax.BG_arr[i];
	            layer_x(_id, layer_get_x(_id) - camera_get_view_x(view_camera[0]));
	            layer_y(_id, layer_get_y(_id) - camera_get_view_y(view_camera[0]));
	        }
		} catch (e) {}
    }
}

function scr_parallax_end()
{
    if (event_type == ev_draw && event_number == 0)
    {
        if (surface_exists(global.parallaxbg_surface))
            surface_reset_target();
    }
}
