function scr_destroy_tiles(argument0, argument1, argument2 = 0)
{
    var lay_id = layer_get_id(argument1);
    
    if (lay_id != -1)
    {
        var map_id = layer_tilemap_get_id(lay_id);
        var w = abs(sprite_width) / argument0;
        var h = abs(sprite_height) / argument0;
        var ix = sign(image_xscale);
        var iy = sign(image_yscale);
        
        if (ix < 0)
            w++;
        
        var yy = 0 - argument2;
        
        while (yy < (h + argument2))
        {
            var xx = 0 - argument2;
            
            while (xx < (w + argument2))
            {
                scr_destroy_tile(x + (xx * argument0 * ix), y + (yy * argument0 * iy), map_id);
                xx++;
            }
            
            yy++;
        }
    }
}

function scr_destroy_tile(argument0, argument1, argument2)
{
    var data = tilemap_get_at_pixel(argument2, argument0, argument1);
    data = tile_set_empty(data);
    tilemap_set_at_pixel(argument2, data, argument0, argument1);
}

function scr_solid_line(_obj)
{
    if (collision_line(x, y, _obj.x, _obj.y, obj_solid, false, true) != noone)
        return true;
    
    if (collision_line(x, y, _obj.x, _obj.y, obj_slope, false, true) != noone)
        return true;
    
    return false;
}

function scr_destroy_nearby_tiles()
{
    with (instance_nearest(x, y, obj_tiledestroy))
    {
        array_resize(target_tiles, array_length(other.target_tiles));
        target_tiles = other.target_tiles;
        instance_destroy();
    }
}

function scr_cutoff_get_angle(_obj)
{
    var a = _obj.image_angle + 90;
    var d = point_direction(0, 0, lengthdir_x(1, a) * _obj.image_yscale, lengthdir_y(1, a) * _obj.image_yscale);
    return d;
}

function scr_cutoff()
{
    var dirs = 
	[
		[-1, 0], 
		[1, 0], 
		[0, -1], 
		[0, 1]
	];
    var list = ds_list_create();
    
    for (var i = 0; i < array_length(dirs); i++)
    {
        var d = dirs[i];
        
        if (!place_meeting(x + d[0], y + d[1], obj_cutoff))
            continue;
        
        var num = instance_place_list(x + d[0], y + d[1], obj_cutoff, list, 0);
        
        for (var j = 0; j < ds_list_size(list); j++)
        {
            var b = list[| j];
            
            if (!is_undefined(b) && instance_exists(b))
            {
                with (b)
                {
                    if (!place_meeting(x, y, obj_solid))
                        instance_destroy();
                    else if (other.object_index == obj_tiledestroy || ((object_index != obj_cutoffsmall || object_index != obj_cutoffsmallwhite || other.object_index == obj_secretblock) && (object_index != obj_cutoff || object_index != obj_cutoffwhite || other.object_index == obj_secretbigblock || other.object_index == obj_secretmetalblock)))
                    {
                        var a = scr_cutoff_get_angle(b);
                        var da = a;
                        
                        if (d[0] < 0)
                            da = 0;
                        else if (d[0] > 0)
                            da = 180;
                        else if (d[1] < 0)
                            da = 270;
                        else if (d[1] > 0)
                            da = 90;
                        
                        if (a == da)
                            visible = true;
                    }
                }
            }
        }
        
        ds_list_clear(list);
    }
    
    ds_list_clear(list);
    ds_list_destroy(list);
}
