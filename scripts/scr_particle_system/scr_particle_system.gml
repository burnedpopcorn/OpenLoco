function create_debris(_x, _y, _sprite, _animated = 0, _palette = 0, _palette_spr = 0)
{
    var q = 
    {
        x: _x,
        y: _y,
        sprite_index: _sprite,
        image_number: sprite_get_number(_sprite),
        image_index: irandom(image_number - 1),
        image_angle: random_range(1, 270),
        image_speed: 0.35,
        sprw: sprite_get_width(_sprite),
        sprh: sprite_get_height(_sprite),
        hsp: random_range(-4, 4),
        vsp: random_range(-4, 0),
        alpha: 1,
        grav: 0.4,
        type: 0,
        animated: _animated,
        destroyonanimation: 0,
        palette: _palette,
        palette_spr: _palette_spr
    };
    ds_list_add(global.debris_list, q);
    return q;
}

function declare_particle(_particle, _sprite, _speed, _depth)
{
    global.part_map[? _particle] = part_type_create();
    global.part_depth[? _particle] = _depth;
    var p = global.part_map[? _particle];
    part_type_sprite(p, _sprite, 1, 1, 0);
    var t = sprite_get_number(_sprite);
    var s = _speed;
    var spd = t / s;
    part_type_life(p, spd, spd);
    return p;
}

function particle_set_scale(_particle, _xscale, _yscale)
{
    part_type_scale(global.part_map[? _particle], _xscale, _yscale);
}

function create_collect(_x, _y, _sprite, _val = 0)
{
    _x -= camera_get_view_x(view_camera[0]);
    _y -= camera_get_view_y(view_camera[0]);
    q = 
    {
        x: _x,
        y: _y,
        sprite_index: _sprite,
        image_index: 0,
        image_number: sprite_get_number(_sprite),
        colorpalettesprite: noone,
        colorpalette: noone,
        hsp: 0,
        vsp: 0,
        val: _val
    };
    ds_list_add(global.collect_list, q);
    return q;
}

function create_collect_color(_x, _y, _sprite, _col_pal_spr, _col_pal, _val = 0)
{
    _x -= camera_get_view_x(view_camera[0]);
    _y -= camera_get_view_y(view_camera[0]);
    q = 
    {
        x: _x,
        y: _y,
        sprite_index: _sprite,
        image_index: 0,
        image_number: sprite_get_number(_sprite),
        colorpalettesprite: _col_pal_spr,
        colorpalette: _col_pal,
        hsp: 0,
        vsp: 0,
        val: _val
    };
    ds_list_add(global.collect_list, q);
    return q;
}

function create_particle(_x, _y, _particle, _size = 0)
{
    var _depth = global.part_depth[? _particle];
    
    if (is_undefined(_depth))
        _depth = object_get_depth(object_index);
    
    part_system_depth(global.particle_system, _depth);
    part_emitter_region(global.particle_system, global.part_emitter, _x - _size, _x + _size, _y - _size, _y + _size, 0, 0);
    part_emitter_burst(global.particle_system, global.part_emitter, global.part_map[? _particle], 1);
}
