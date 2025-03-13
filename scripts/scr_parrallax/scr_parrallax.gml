function calculate_parrallax_still_x(argument0)
{
    if (is_undefined(sprite) || sprite == -1)
    {
        return 0;
    }
    else
    {
        var w = room_width - obj_screen.actualWidth;
        var per_x;
        
        if (room_width <= obj_screen.actualWidth)
            per_x = 0;
        else
            per_x = camera_get_view_x(view_camera[0]) / w;
        
        var _w = sprite_get_width(sprite);
        
        if (_w > 540)
            _w = 540;
        
        var sw = _w - obj_screen.actualWidth;
        var r = sw * per_x * argument0;
        r = max(r, 0);
        return r;
    }
}

function calculate_parrallax_still_y(argument0)
{
    if (is_undefined(sprite) || sprite == -1)
    {
        return 0;
    }
    else
    {
        var h = room_height - obj_screen.actualHeight;
        var per_y;
        
        if (room_height <= obj_screen.actualHeight)
            per_y = 0;
        else
            per_y = camera_get_view_y(view_camera[0]) / h;
        
        var _h = sprite_get_height(sprite);
        
        if (_h > 540)
            _h = 540;
        
        var sh = _h - obj_screen.actualHeight;
        var r = sh * per_y * argument0;
        r = max(r, 0);
        return r;
    }
}

function safe_layer_depth(argument0, argument1)
{
    if (layer_exists(argument0))
        layer_depth(argument0, argument1);
}

function parallaxAdd(argument0, argument1)
{
    var q = 
    {
        per: argument1
    };
    ds_map_set(global.parallaxMap, argument0, q);
    return q;
}

function parallaxGroupAdd(argument0)
{
    for (var i = 0; i < array_length(argument0); i++)
    {
        var l = argument0[i];
        parallaxAdd(l[0], l[1]);
    }
}

function get_layer(argument0)
{
    for (var i = 0; i < ds_list_size(BG_list); i++)
    {
        var l = ds_list_find_value(BG_list, i);
        
        if (l.name == argument0)
        {
            return l;
            break;
        }
    }
    
    return -4;
}

function parrallax_load()
{
    ds_list_clear(BG_list);
    BG_arr = [];
    
    if (room != Scootertransition && room != timesuproom)
    {
        var lay_arr = layer_get_all();
        
        for (var i = 0; i < array_length(lay_arr); i++)
        {
            var lay = lay_arr[i];
            var lay_name = layer_get_name(lay);
            var bgID = layer_background_get_id(lay);
            var isBackground = bgID != -1;
            var isAssetBG = string_starts_with(lay_name, "Assets_BG") || string_starts_with(lay_name, "Assets_FG") || string_starts_with(lay_name, "Assets_stillBG");
            
            if (isBackground || isAssetBG)
            {
                var layerProperties = 
                {
                    id: lay,
                    name: lay_name,
                    sprite: layer_background_get_sprite(bgID),
                    x: layer_get_x(lay),
                    y: layer_get_y(lay),
                    backgroundID: bgID,
                    xoffset: layer_get_x(lay),
                    yoffset: layer_get_y(lay),
                    hsp: layer_get_hspeed(lay),
                    vsp: layer_get_vspeed(lay),
                    storedHsp: layer_get_hspeed(lay),
                    sotredVsp: layer_get_vspeed(lay),
                    scrollx: 0,
                    scrolly: 0
                };
                
                if (isBackground)
                    array_push(BG_arr, layerProperties.id);
                
                ds_list_add(BG_list, layerProperties);
            }
            
            if (BG_arr != [])
            {
                array_sort(BG_arr, function(argument0, argument1)
                {
                    return layer_get_depth(argument1) - layer_get_depth(argument0);
                });
            }
        }
        
        scr_parallax_init();
    }
}
