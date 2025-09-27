if (previousX != device_mouse_x_to_gui(0) || previousY != device_mouse_x_to_gui(0))
    mouse_buffer = 200;

previousX = device_mouse_x_to_gui(0);
previousY = device_mouse_y_to_gui(0);
bgX += 0.1;
bgY += 0.1;

if (oldWidth != window_get_width() || oldHeight != window_get_height())
{
    var actSize = noone;
    
    if (scaleMode == 1)
    {
        actSize = 
		[
			window_get_width(), 
			window_get_height(), 
			(window_get_width() > 0 && window_get_height() > 0)
		];
        
        if (window_get_width() > 0 && window_get_height() > 0)
        {
            surface_resize(application_surface, window_get_width(), window_get_height());
            display_set_gui_size(window_get_width(), window_get_height());
            actualHeight = window_get_height();
            actualWidth = window_get_width();
        }
    }
    else
    {
        actualHeight = 540;
        actualWidth = 960;
        app_scale = min(window_get_width() / actualWidth, window_get_height() / actualHeight);
        
        if (app_scale > 0)
        {
            surface_resize(application_surface, actualWidth, actualHeight);
            display_set_gui_size(actualWidth, actualHeight);
        }
    }
    
    trace("Window width: ", window_get_width(), " | ", "Window height: ", window_get_height());
    oldWidth = window_get_width();
    oldHeight = window_get_height();
}

if (mouse_buffer > 0)
    mouse_buffer--;

var c = 16295984;

switch (palette)
{
    case 1:
        c = 248;
        break;
    
    case 2:
        c = 47352;
        break;
    
    case 3:
        c = 49240;
        break;
    
    case 4:
        c = 16273560;
        break;
}

if (mouse_buffer >= 198)
{
    if (afterimg_buffer > 0)
    {
        afterimg_buffer--;
    }
    else
    {
        ds_list_add(afterimg, 
        {
            color: c,
            x: device_mouse_x_to_gui(0),
            y: device_mouse_y_to_gui(0),
            alpha: 1
        });
        afterimg_buffer = 6;
    }
}

generalAlpha = Approach(generalAlpha, mouse_buffer ? 1 : 0, 0.1);
