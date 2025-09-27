if (!ds_list_empty(BG_list))
{
    for (var i = 0; i < ds_list_size(BG_list); i++)
    {
        var lay = BG_list[| i];
        var f = global.parallaxMap[? lay.name];
        f ??= 
        {
            per: 0
        };
        var x_mult = is_array(f.per) ? f.per[0] : f.per;
        var y_mult = is_array(f.per) ? f.per[1] : f.per;
        
        with (lay)
        {
            var parallax_stillX = calculate_parrallax_still_x(x_mult);
            var parallax_stillY = calculate_parrallax_still_y(y_mult);
            
            switch (name)
            {
                case "Backgrounds_1":
                case "Backgrounds_2":
                case "Backgrounds_3":
                    x = xoffset + (camera_get_view_x(view_camera[0]) * x_mult);
                    y = yoffset + (camera_get_view_y(view_camera[0]) * y_mult);
                    break;
                
                case "Assets_BG2":
                case "Assets_BG1":
                case "Assets_BG":
                case "Assets_stillBG":
                case "Assets_FG2":
                case "Assets_FG1":
                case "Assets_FG":
                    x = camera_get_view_x(view_camera[0]) * x_mult;
                    
                    if (name != "Assets_stillBG")
                        y = camera_get_view_y(view_camera[0]) * y_mult;
                    
                    break;
                
                case "Backgrounds_Ground1":
                case "Backgrounds_Ground2":
                case "Backgrounds_Ground3":
                    x = camera_get_view_x(view_camera[0]) * x_mult;
                    break;
                
                case "Backgrounds_H1":
                    x = camera_get_view_x(view_camera[0]) * x_mult;
                    y = camera_get_view_y(view_camera[0]);
                    break;
                
                case "Backgrounds_sky":
                    x = camera_get_view_x(view_camera[0]) * x_mult;
                    y = camera_get_view_y(view_camera[0]) * y_mult;
                    break;
                
                case "Backgrounds_sky2":
                    x = camera_get_view_x(view_camera[0]);
                    y = camera_get_view_y(view_camera[0]);
                    break;
                
                case "Backgrounds_sky3":
                    x = camera_get_view_x(view_camera[0]) * x_mult;
                    y = camera_get_view_y(view_camera[0]);
                    break;
                
                case "Backgrounds_sky4":
                    x = (camera_get_view_x(view_camera[0]) * x_mult) + scrollx;
                    y = camera_get_view_y(view_camera[0]) + scrolly;
                    scrolly += vsp;
                    scrollx += hsp;
                    break;
                
                case "Backgrounds_sky5":
                    x = camera_get_view_x(view_camera[0]) * x_mult;
                    y = camera_get_view_y(view_camera[0]);
                    break;
                
                case "Backgrounds_sky1scroll":
                case "Backgrounds_sky2scroll":
                case "Backgrounds_sky3scroll":
                    x = xoffset + (camera_get_view_x(view_camera[0]) * x_mult) + scrollx;
                    scrollx += hsp;
                    y = yoffset + (camera_get_view_y(view_camera[0]) * y_mult) + scrolly;
                    scrolly += vsp;
                    break;
                
                case "Backgrounds_still1":
                case "Backgrounds_still2":
                    x = (xoffset + camera_get_view_x(view_camera[0])) - parallax_stillX;
                    y = (yoffset + camera_get_view_y(view_camera[0])) - parallax_stillY;
                    break;
                
                case "Backgrounds_stillscroll":
                    x = (xoffset + scrollx + camera_get_view_x(view_camera[0])) - parallax_stillX;
                    y = (xoffset + scrolly + camera_get_view_y(view_camera[0])) - parallax_stillY;
                    scrollx += hsp;
                    scrolly += vsp;
                    break;
                
                case "Backgrounds_stillV1":
                case "Backgrounds_stillV2":
                case "Backgrounds_stillV3":
                case "Backgrounds_stillV4":
                    x = xoffset + (camera_get_view_x(view_camera[0]) + parallax_stillX);
                    y = yoffset + (camera_get_view_y(view_camera[0]) * y_mult);
                    xoffset += hsp;
                    yoffset += vsp;
                    break;
                
                case "Backgrounds_stillH1":
                case "Backgrounds_stillH2":
                case "Backgrounds_stillH3":
                case "Backgrounds_stillH4":
                    x = xoffset + (camera_get_view_x(view_camera[0]) * x_mult);
                    y = xoffset + (camera_get_view_y(view_camera[0]) + parallax_stillY);
                    xoffset += hsp;
                    yoffset += vsp;
                    break;
                
                case "Backgrounds_scroll":
                case "Backgrounds_scroll2":
                case "Backgrounds_scroll3":
                case "Backgrounds_scroll4":
                    x = (camera_get_view_x(view_camera[0]) * x_mult) + scrollx + xoffset;
                    y = (camera_get_view_y(view_camera[0]) * y_mult) + scrolly + yoffset;
                    scrollx += hsp;
                    scrolly += vsp;
                    break;
                
                case "Backgrounds_zigzag1":
                case "Backgrounds_zigzag2":
                    scrollx += hsp;
                    scrolly = Wave(-vsp, vsp, 4, 10);
                    x = (camera_get_view_x(view_camera[0]) * x_mult) + scrollx + xoffset;
                    y = (camera_get_view_y(view_camera[0]) * y_mult) + scrolly + yoffset;
                    break;
                
                case "Backgrounds_stillZH1":
                case "Backgrounds_stillZH2":
                    scrollx += hsp;
                    scrolly = Wave(-vsp, vsp, 4, 10);
                    x = (camera_get_view_x(view_camera[0]) * x_mult) + scrollx + xoffset;
                    y = (camera_get_view_y(view_camera[0]) - parallax_stillY) + scrolly + yoffset;
                    break;
                
                case "Foreground_1":
                    x = (camera_get_view_x(view_camera[0]) * x_mult) + xoffset;
                    y = (camera_get_view_y(view_camera[0]) * y_mult) + scrolly + yoffset;
                    scrolly += vsp;
                    break;
                
                case "Foreground_2":
                    x = (camera_get_view_x(view_camera[0]) * x_mult) + xoffset;
                    y = (camera_get_view_y(view_camera[0]) * y_mult) + yoffset;
                    break;
                
                case "Foreground_Ground1":
                    x = camera_get_view_x(view_camera[0]) * x_mult;
                    y = room_height - sprite_get_height(sprite);
                    break;
                
                case "Backgrounds_skystill":
                case "Backgrounds_skystill1":
                    x = (camera_get_view_x(view_camera[0]) * x_mult) + scrolly + xoffset;
                    y = (camera_get_view_y(view_camera[0]) * y_mult) + scrolly + yoffset;
                    break;
            }
            
            layer_hspeed(id, 0);
            layer_vspeed(id, 0);
            x = floor(x);
            y = floor(y);
            layer_x(id, x);
            layer_y(id, y);
        }
    }
}
