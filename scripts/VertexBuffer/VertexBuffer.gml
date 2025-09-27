vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_texcoord();
vertex_format_add_color();
global.vFormat = vertex_format_end();

function vertex_create_face(_vbuff, _vert1, _vert2, _vert3, _vert4, _col, _alpha, _width, _height)
{
    static _texSize = 32;
    
    var _texW = _width / _texSize;
    var _texH = _height / _texSize;
	
    vertex_position_3d(_vbuff, _vert1.x, _vert1.y, _vert1.z);
    vertex_texcoord(_vbuff, 0, 0);
    vertex_color(_vbuff, _col, _alpha);
	
    vertex_position_3d(_vbuff, _vert2.x, _vert2.y, _vert2.z);
    vertex_texcoord(_vbuff, _texW, 0);
    vertex_color(_vbuff, _col, _alpha);
	
    vertex_position_3d(_vbuff, _vert3.x, _vert3.y, _vert3.z);
    vertex_texcoord(_vbuff, _texW, _texH);
    vertex_color(_vbuff, _col, _alpha);
	
    vertex_position_3d(_vbuff, _vert1.x, _vert1.y, _vert1.z);
    vertex_texcoord(_vbuff, 0, 0);
    vertex_color(_vbuff, _col, _alpha);
	
    vertex_position_3d(_vbuff, _vert3.x, _vert3.y, _vert3.z);
    vertex_texcoord(_vbuff, _texW, _texH);
    vertex_color(_vbuff, _col, _alpha);
	
    vertex_position_3d(_vbuff, _vert4.x, _vert4.y, _vert4.z);
    vertex_texcoord(_vbuff, 0, _texH);
    vertex_color(_vbuff, _col, _alpha);
}
