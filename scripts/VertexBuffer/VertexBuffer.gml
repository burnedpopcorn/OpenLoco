vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_texcoord();
vertex_format_add_color();
global.vFormat = vertex_format_end();

function vertex_create_face(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8)
{
    static _texSize = 32;
    
    var _texW = argument7 / _texSize;
    var _texH = argument8 / _texSize;
    vertex_position_3d(argument0, argument1.x, argument1.y, argument1.z);
    vertex_texcoord(argument0, 0, 0);
    vertex_color(argument0, argument5, argument6);
    vertex_position_3d(argument0, argument2.x, argument2.y, argument2.z);
    vertex_texcoord(argument0, _texW, 0);
    vertex_color(argument0, argument5, argument6);
    vertex_position_3d(argument0, argument3.x, argument3.y, argument3.z);
    vertex_texcoord(argument0, _texW, _texH);
    vertex_color(argument0, argument5, argument6);
    vertex_position_3d(argument0, argument1.x, argument1.y, argument1.z);
    vertex_texcoord(argument0, 0, 0);
    vertex_color(argument0, argument5, argument6);
    vertex_position_3d(argument0, argument3.x, argument3.y, argument3.z);
    vertex_texcoord(argument0, _texW, _texH);
    vertex_color(argument0, argument5, argument6);
    vertex_position_3d(argument0, argument4.x, argument4.y, argument4.z);
    vertex_texcoord(argument0, 0, _texH);
    vertex_color(argument0, argument5, argument6);
}
