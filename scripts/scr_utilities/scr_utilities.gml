function ds_list_add_unique(argument0)
{
    if (argument_count > 1)
    {
        for (var i = 1; i < argument_count; i++)
        {
            b = argument[i];
            
            if (ds_list_find_index(argument0, b) == -1)
                ds_list_add(argument0, b);
        }
    }
    
    exit;
}

function get_milliseconds()
{
    return get_timer() / 1000;
}

function concat()
{
    var _string = "";
    
    for (i = 0; i < argument_count; i++)
        _string += string(argument[i]);
    
    return _string;
}

function vertex_add_point(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10)
{
    var vbuffer = argument0;
    var xx = argument1;
    var yy = argument2;
    var zz = argument3;
    var nx = argument4;
    var ny = argument5;
    var nz = argument6;
    var utex = argument7;
    var vtex = argument8;
    var color = argument9;
    var alpha = argument10;
    vertex_position_3d(vbuffer, xx, yy, zz);
    vertex_normal(vbuffer, nx, ny, nz);
    vertex_texcoord(vbuffer, utex, vtex);
    vertex_color(vbuffer, color, alpha);
}

function shakeboth(argument0)
{
    var shaking = argument0;
    return random_range(shaking, -shaking);
}

function heat_calculate(argument0)
{
    trace(global.stylemultiplier);
    return argument0 + round(argument0 * global.stylemultiplier);
}

function draw_sprite_wave(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7)
{
    var sprite = argument0;
    var image = argument1;
    var X = argument2;
    var Y = argument3;
    var axis = argument4;
    var wavelength = argument5;
    var amplitude = argument6;
    var phase = argument7;
    var width = sprite_get_width(sprite);
    var height = sprite_get_height(sprite);
    var xoff = sprite_get_xoffset(sprite);
    var yoff = sprite_get_yoffset(sprite);
    var size;
    
    if (axis)
        size = height;
    else
        size = width;
    
    for (var i = 0; i < size; i += 1)
    {
        var shift = amplitude * sin((2 * pi) * ((i / wavelength) + phase));
        
        if (axis)
        {
            var sx = (shift - xoff) + X;
            var sy = (i - yoff) + Y;
            draw_sprite_part(sprite, image, 0, i, width, 1, sx, sy);
        }
        else
        {
            var sx = (i - xoff) + X;
            var sy = (shift - yoff) + Y;
            draw_sprite_part(sprite, image, i, 0, 1, height, sx, sy);
        }
    }
}

function camera_zoom(argument0, argument1)
{
    with (obj_camera)
    {
        targetzoom = argument0;
        targetzoom = clamp(targetzoom, 0, max_zoom);
        
        if (argument1 != undefined)
            zoomspd = abs(argument1);
    }
    
    exit;
}

function camera_angle(argument0, argument1)
{
    with (obj_camera)
    {
        targetangle = argument0;
        targetangle = clamp(targetangle, 0, max_angle);
        
        if (argument1 != undefined)
            anglespd = abs(argument1);
    }
    
    exit;
}

function camera_set_zoom(argument0)
{
    with (obj_camera)
        zoom = argument0;
    
    exit;
}

function Wave(argument0, argument1, argument2, argument3)
{
    var a4 = (argument1 - argument0) * 0.5;
    return argument0 + a4 + (sin((((current_time * 0.001) + (argument2 * argument3)) / argument2) * (2 * pi)) * a4);
}

function point_in_camera(argument0, argument1, argument2)
{
    var cam_x = camera_get_view_x(argument2);
    var cam_y = camera_get_view_y(argument2);
    var cam_w = camera_get_view_width(argument2);
    var cam_h = camera_get_view_height(argument2);
    return point_in_rectangle(argument0, argument1, cam_x, cam_y, cam_x + cam_w, cam_y + cam_h);
}

function randomize_palette(argument0)
{
    return round(irandom(sprite_get_width(argument0) - 1));
}

function array_random(argument0, argument1 = 0, argument2 = array_length(argument0) - 1)
{
    if (array_length(argument0) <= 0 || argument1 > argument2)
        return undefined;
    
    var index = irandom_range(argument1, argument2);
    
    if (index > (array_length(argument0) - 1) || index < 0)
        return -4;
    else
        return argument0[index];
    
    return undefined;
}

function is_hub()
{
    if (string_starts_with(room_get_name(room), "hub_"))
        return true;
    
    return false;
}

function rank_get_value(argument0)
{
    var rank_map = ds_map_create();
    ds_map_set(rank_map, "l", 6);
    ds_map_set(rank_map, "s", 5);
    ds_map_set(rank_map, "a", 4);
    ds_map_set(rank_map, "b", 3);
    ds_map_set(rank_map, "c", 2);
    ds_map_set(rank_map, "d", 1);
    return ds_map_find_value(rank_map, argument0);
}

function shader_set_uniform_f_ext(argument0, argument1, argument2)
{
    var _id = shader_get_uniform(argument0, argument1);
    shader_set_uniform_f(_id, argument2);
}

function str_read_until(argument0, argument1, argument2)
{
    var index = argument2 + 1;
    var buf = "";
    var ch = string_char_at(argument0, index);
    
    while (index < string_length(argument0) && ch != argument1)
    {
        buf += string_char_at(argument0, index);
        ch = string_char_at(argument0, ++index);
    }
    
    return [buf, index];
}

function get_shake(argument0)
{
    return 
    {
        x: random_range(-argument0, argument0),
        y: random_range(-argument0, argument0)
    };
}

function object_is(argument0, argument1 = object_index)
{
    return array_contains(argument0, argument1);
}

function instance_create_unique(argument0, argument1, argument2)
{
    if (!instance_exists(argument2))
        return instance_create(argument0, argument1, argument2);
    else
        return -4;
}

function saveroom_add(argument0 = id)
{
    ds_list_add(global.saveroom, argument0);
}

function saveroom_check(argument0 = id)
{
    return ds_list_find_value(global.saveroom, argument0) != undefined;
}

function create_transfotext(argument0, argument1 = texteffect.randupdown)
{
    with (instance_create(x, y, obj_transformationtext))
    {
        effect = argument1;
        message = argument0;
    }
}

function create_transfotext_lang(argument0, argument1 = texteffect.randupdown)
{
    create_transfotext(langstr_get(argument0), argument1);
}

function set_fogcolor(argument0)
{
    gpu_set_fog(true, argument0, 1, 1);
}

function reset_fog()
{
    gpu_set_fog(false, c_black, 0, 0);
}
