function ds_list_add_unique(_id)
{
    if (argument_count > 1)
    {
        for (var i = 1; i < argument_count; i++)
        {
            b = argument[i];
            
            if (ds_list_find_index(_id, b) == -1)
                ds_list_add(_id, b);
        }
    }
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

function vertex_add_point(vbuffer, xx, yy, zz, nx, ny, nz, utex, vtex, color, alpha)
{
    vertex_position_3d(vbuffer, xx, yy, zz);
    vertex_normal(vbuffer, nx, ny, nz);
    vertex_texcoord(vbuffer, utex, vtex);
    vertex_color(vbuffer, color, alpha);
}

function shakeboth(shaking)
{
    return random_range(shaking, -shaking);
}

function heat_calculate(argument0)
{
    trace(global.stylemultiplier);
    return argument0 + round(argument0 * global.stylemultiplier);
}

function draw_sprite_wave(sprite, image, X, Y, axis, wavelength, amplitude, phase)
{
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

function camera_zoom(_zoom, _zoomspd)
{
    with (obj_camera)
    {
        targetzoom = _zoom;
        targetzoom = clamp(targetzoom, 0, max_zoom);
        
        if (_zoomspd != undefined)
            zoomspd = abs(_zoomspd);
    }
}

function camera_angle(_angle, _anglespd)
{
    with (obj_camera)
    {
        targetangle = _angle;
        targetangle = clamp(targetangle, 0, max_angle);
        
        if (_anglespd != undefined)
            anglespd = abs(_anglespd);
    }
}

function camera_set_zoom(_zoom)
{
    with (obj_camera)
        zoom = _zoom;
}

// why was this func duplicated?
// both funcs wave() and Wave() both exist for some reason
function Wave(argument0, argument1, argument2, argument3)
{
    var a4 = (argument1 - argument0) * 0.5;
    return argument0 + a4 + (sin((((current_time * 0.001) + (argument2 * argument3)) / argument2) * (2 * pi)) * a4);
}

function point_in_camera(_px, _py, _cam)
{
    var cam_x = camera_get_view_x(_cam);
    var cam_y = camera_get_view_y(_cam);
    var cam_w = camera_get_view_width(_cam);
    var cam_h = camera_get_view_height(_cam);
    return point_in_rectangle(_px, _py, cam_x, cam_y, cam_x + cam_w, cam_y + cam_h);
}

function randomize_palette(_pal_sprite)
{
    return round(irandom(sprite_get_width(_pal_sprite) - 1));
}

function array_random(argument0, argument1 = 0, argument2 = array_length(argument0) - 1)
{
    if (array_length(argument0) <= 0 || argument1 > argument2)
        return undefined;
    
    var index = irandom_range(argument1, argument2);
    
    if (index > (array_length(argument0) - 1) || index < 0)
        return noone;
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

function rank_get_value(_rank_letter)
{
    var rank_map = ds_map_create();
    rank_map[? "l"] = 6;
    rank_map[? "s"] = 5;
    rank_map[? "a"] = 4;
    rank_map[? "b"] = 3;
    rank_map[? "c"] = 2;
    rank_map[? "d"] = 1;
    return rank_map[? _rank_letter];
}

function shader_set_uniform_f_ext(_shader, _u_name, _value)
{
    var _id = shader_get_uniform(_shader, _u_name);
    shader_set_uniform_f(_id, _value);
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

function get_shake(_amount)
{
    return 
    {
        x: random_range(-_amount, _amount),
        y: random_range(-_amount, _amount)
    };
}

function object_is(argument0, argument1 = object_index)
{
    return array_contains(argument0, argument1);
}

function instance_create_unique(_x, _y, _obj)
{
    if (!instance_exists(_obj))
        return instance_create(_x, _y, _obj);
    else
        return noone;
}

function saveroom_add(_rm = id)
{
    ds_list_add(global.saveroom, _rm);
}

function saveroom_check(_rm = id)
{
    return global.saveroom[| _rm] != undefined;
}

function create_transfotext(_message, _effect = texteffect.randupdown)
{
    with (instance_create(x, y, obj_transformationtext))
    {
        effect = _effect;
        message = _message;
    }
}

function create_transfotext_lang(_text, _effect = texteffect.randupdown)
{
    create_transfotext(langstr_get(_text), _effect);
}

function set_fogcolor(_color)
{
    gpu_set_fog(true, _color, 1, 1);
}

function reset_fog()
{
    gpu_set_fog(false, c_black, 0, 0);
}
