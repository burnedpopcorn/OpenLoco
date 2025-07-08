vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
global.ColMeshFormat = vertex_format_end();

function colmesh_debug_draw_block(argument0, argument1)
{
    static vbuff = global.ColMeshDebugShapes[Colmesh_shapes.block];
    
    if (vbuff < 0)
    {
        global.ColMeshDebugShapes[Colmesh_shapes.block] = colmesh_create_block(1, 1);
        vbuff = global.ColMeshDebugShapes[Colmesh_shapes.block];
    }
    
    shader_set(sh_colmesh_debug);
    shader_set_uniform_f(shader_get_uniform(sh_colmesh_debug, "u_color"), color_get_red(argument1) / 255, color_get_green(argument1) / 255, color_get_blue(argument1) / 255, 1);
    shader_set_uniform_f(shader_get_uniform(sh_colmesh_debug, "u_radius"), 0);
    var W = matrix_get(2);
    matrix_set(2, argument0);
    vertex_submit(vbuff, pr_trianglelist, -1);
    shader_reset();
    matrix_set(2, matrix_build_identity());
}

function colmesh_debug_draw_capsule(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8)
{
    var type = Colmesh_shapes.capsule;
    var vbuff = global.ColMeshDebugShapes[type];
    
    if (vbuff < 0)
    {
        global.ColMeshDebugShapes[type] = colmesh_create_capsule(20, 10, 1, 1);
        vbuff = global.ColMeshDebugShapes[type];
    }
    
    shader_set(sh_colmesh_debug);
    shader_set_uniform_f(shader_get_uniform(sh_colmesh_debug, "u_color"), color_get_red(argument8) / 255, color_get_green(argument8) / 255, color_get_blue(argument8) / 255, 1);
    shader_set_uniform_f(shader_get_uniform(sh_colmesh_debug, "u_radius"), argument6);
    matrix_set(2, colmesh_matrix_build_from_vector(argument0, argument1, argument2, argument3, argument4, argument5, 1, 1, argument7));
    vertex_submit(vbuff, pr_trianglelist, -1);
    shader_reset();
    matrix_set(2, matrix_build_identity());
}

function colmesh_debug_draw_cylinder(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8)
{
    var type = Colmesh_shapes.cylinder;
    var vbuff = global.ColMeshDebugShapes[type];
    
    if (vbuff < 0)
    {
        global.ColMeshDebugShapes[type] = colmesh_create_cylinder(20, 1, 1);
        vbuff = global.ColMeshDebugShapes[type];
    }
    
    shader_set(sh_colmesh_debug);
    shader_set_uniform_f(shader_get_uniform(sh_colmesh_debug, "u_color"), color_get_red(argument8) / 255, color_get_green(argument8) / 255, color_get_blue(argument8) / 255, 1);
    shader_set_uniform_f(shader_get_uniform(sh_colmesh_debug, "u_radius"), 0);
    matrix_set(2, colmesh_matrix_build_from_vector(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument6, argument7));
    vertex_submit(vbuff, pr_trianglelist, -1);
    shader_reset();
    matrix_set(2, matrix_build_identity());
}

function colmesh_debug_draw_sphere(argument0, argument1, argument2, argument3, argument4)
{
    var type = Colmesh_shapes.sphere;
    var vbuff = global.ColMeshDebugShapes[type];
    
    if (vbuff < 0)
    {
        global.ColMeshDebugShapes[type] = colmesh_create_sphere(20, 10, 1, 1);
        vbuff = global.ColMeshDebugShapes[type];
    }
    
    shader_set(sh_colmesh_debug);
    shader_set_uniform_f(shader_get_uniform(sh_colmesh_debug, "u_color"), color_get_red(argument4) / 255, color_get_green(argument4) / 255, color_get_blue(argument4) / 255, 1);
    shader_set_uniform_f(shader_get_uniform(sh_colmesh_debug, "u_radius"), argument3);
    matrix_set(2, matrix_build(argument0, argument1, argument2, 0, 0, 0, 1, 1, 1));
    vertex_submit(vbuff, pr_trianglelist, -1);
    shader_reset();
    matrix_set(2, matrix_build_identity());
}

function colmesh_create_sphere(argument0, argument1, argument2, argument3)
{
    var vbuff = vertex_create_buffer();
    vertex_begin(vbuff, global.ColMeshFormat);
    
    for (var xx = 0; xx < argument0; xx++)
    {
        var xa1 = (xx / argument0) * 2 * pi;
        var xa2 = ((xx + 1) / argument0) * 2 * pi;
        var xc1 = cos(xa1);
        var xs1 = sin(xa1);
        var xc2 = cos(xa2);
        var xs2 = sin(xa2);
        
        for (var yy = 0; yy < argument1; yy++)
        {
            var ya1 = (yy / argument1) * pi;
            var ya2 = ((yy + 1) / argument1) * pi;
            var yc1 = cos(ya1);
            var ys1 = sin(ya1);
            var yc2 = cos(ya2);
            var ys2 = sin(ya2);
            vertex_position_3d(vbuff, 0, 0, 0);
            vertex_normal(vbuff, xc1 * ys1, xs1 * ys1, yc1);
            vertex_texcoord(vbuff, (xx / argument0) * argument2, (yy / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, 0, 0, 0);
            vertex_normal(vbuff, xc1 * ys2, xs1 * ys2, yc2);
            vertex_texcoord(vbuff, (xx / argument0) * argument2, ((yy + 1) / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, 0, 0, 0);
            vertex_normal(vbuff, xc2 * ys1, xs2 * ys1, yc1);
            vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, (yy / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, 0, 0, 0);
            vertex_normal(vbuff, xc1 * ys2, xs1 * ys2, yc2);
            vertex_texcoord(vbuff, (xx / argument0) * argument2, ((yy + 1) / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, 0, 0, 0);
            vertex_normal(vbuff, xc2 * ys2, xs2 * ys2, yc2);
            vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, ((yy + 1) / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, 0, 0, 0);
            vertex_normal(vbuff, xc2 * ys1, xs2 * ys1, yc1);
            vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, (yy / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
        }
    }
    
    vertex_end(vbuff);
    vertex_freeze(vbuff);
    return vbuff;
}

function colmesh_create_block(argument0, argument1)
{
    var vbuff = vertex_create_buffer();
    vertex_begin(vbuff, global.ColMeshFormat);
    vertex_position_3d(vbuff, -1, -1, 1);
    vertex_normal(vbuff, 0, 0, 1);
    vertex_texcoord(vbuff, 0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, -1, 1);
    vertex_normal(vbuff, 0, 0, 1);
    vertex_texcoord(vbuff, argument0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, -1, 1, 1);
    vertex_normal(vbuff, 0, 0, 1);
    vertex_texcoord(vbuff, 0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, -1, 1, 1);
    vertex_normal(vbuff, 0, 0, 1);
    vertex_texcoord(vbuff, 0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, -1, 1);
    vertex_normal(vbuff, 0, 0, 1);
    vertex_texcoord(vbuff, argument0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, 1, 1);
    vertex_normal(vbuff, 0, 0, 1);
    vertex_texcoord(vbuff, argument0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, -1, -1, -1);
    vertex_normal(vbuff, 0, 0, -1);
    vertex_texcoord(vbuff, 0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, -1, 1, -1);
    vertex_normal(vbuff, 0, 0, -1);
    vertex_texcoord(vbuff, 0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, -1, -1);
    vertex_normal(vbuff, 0, 0, -1);
    vertex_texcoord(vbuff, argument0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, -1, 1, -1);
    vertex_normal(vbuff, 0, 0, -1);
    vertex_texcoord(vbuff, 0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, 1, -1);
    vertex_normal(vbuff, 0, 0, -1);
    vertex_texcoord(vbuff, argument0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, -1, -1);
    vertex_normal(vbuff, 0, 0, -1);
    vertex_texcoord(vbuff, argument0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, -1, -1);
    vertex_normal(vbuff, 1, 0, 0);
    vertex_texcoord(vbuff, 0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, 1, -1);
    vertex_normal(vbuff, 1, 0, 0);
    vertex_texcoord(vbuff, 0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, -1, 1);
    vertex_normal(vbuff, 1, 0, 0);
    vertex_texcoord(vbuff, argument0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, 1, -1);
    vertex_normal(vbuff, 1, 0, 0);
    vertex_texcoord(vbuff, 0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, 1, 1);
    vertex_normal(vbuff, 1, 0, 0);
    vertex_texcoord(vbuff, argument0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, -1, 1);
    vertex_normal(vbuff, 1, 0, 0);
    vertex_texcoord(vbuff, argument0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, -1, -1, -1);
    vertex_normal(vbuff, -1, 0, 0);
    vertex_texcoord(vbuff, 0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, -1, -1, 1);
    vertex_normal(vbuff, -1, 0, 0);
    vertex_texcoord(vbuff, argument0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, -1, 1, -1);
    vertex_normal(vbuff, -1, 0, 0);
    vertex_texcoord(vbuff, 0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, -1, 1, -1);
    vertex_normal(vbuff, -1, 0, 0);
    vertex_texcoord(vbuff, 0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, -1, -1, 1);
    vertex_normal(vbuff, -1, 0, 0);
    vertex_texcoord(vbuff, argument0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, -1, 1, 1);
    vertex_normal(vbuff, -1, 0, 0);
    vertex_texcoord(vbuff, argument0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, -1, 1, -1);
    vertex_normal(vbuff, 0, 1, 0);
    vertex_texcoord(vbuff, 0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, -1, 1, 1);
    vertex_normal(vbuff, 0, 1, 0);
    vertex_texcoord(vbuff, argument0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, 1, -1);
    vertex_normal(vbuff, 0, 1, 0);
    vertex_texcoord(vbuff, 0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, 1, -1);
    vertex_normal(vbuff, 0, 1, 0);
    vertex_texcoord(vbuff, 0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, -1, 1, 1);
    vertex_normal(vbuff, 0, 1, 0);
    vertex_texcoord(vbuff, argument0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, 1, 1);
    vertex_normal(vbuff, 0, 1, 0);
    vertex_texcoord(vbuff, argument0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, -1, -1, -1);
    vertex_normal(vbuff, 0, -1, 0);
    vertex_texcoord(vbuff, 0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, -1, -1);
    vertex_normal(vbuff, 0, -1, 0);
    vertex_texcoord(vbuff, 0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, -1, -1, 1);
    vertex_normal(vbuff, 0, -1, 0);
    vertex_texcoord(vbuff, argument0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, -1, -1);
    vertex_normal(vbuff, 0, -1, 0);
    vertex_texcoord(vbuff, 0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, 1, -1, 1);
    vertex_normal(vbuff, 0, -1, 0);
    vertex_texcoord(vbuff, argument0, argument1);
    vertex_color(vbuff, c_white, 1);
    vertex_position_3d(vbuff, -1, -1, 1);
    vertex_normal(vbuff, 0, -1, 0);
    vertex_texcoord(vbuff, argument0, 0);
    vertex_color(vbuff, c_white, 1);
    vertex_end(vbuff);
    vertex_freeze(vbuff);
    return vbuff;
}

function colmesh_create_torus(argument0, argument1, argument2, argument3)
{
    var vbuff = vertex_create_buffer();
    vertex_begin(vbuff, global.ColMeshFormat);
    
    for (var xx = 0; xx < argument0; xx++)
    {
        var xa1 = (xx / argument0) * 2 * pi;
        var xa2 = ((xx + 1) / argument0) * 2 * pi;
        var xc1 = cos(xa1);
        var xs1 = sin(xa1);
        var xc2 = cos(xa2);
        var xs2 = sin(xa2);
        
        for (var yy = 0; yy < argument1; yy++)
        {
            var ya1 = (yy / argument1) * 2 * pi;
            var ya2 = ((yy + 1) / argument1) * 2 * pi;
            var yc1 = cos(ya1);
            var ys1 = sin(ya1);
            var yc2 = cos(ya2);
            var ys2 = sin(ya2);
            vertex_position_3d(vbuff, xc1, xs1, 0);
            vertex_normal(vbuff, xc1 * ys1, xs1 * ys1, yc1);
            vertex_texcoord(vbuff, (xx / argument0) * argument2, (yy / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, xc1, xs1, 0);
            vertex_normal(vbuff, xc1 * ys2, xs1 * ys2, yc2);
            vertex_texcoord(vbuff, (xx / argument0) * argument2, ((yy + 1) / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, xc2, xs2, 0);
            vertex_normal(vbuff, xc2 * ys1, xs2 * ys1, yc1);
            vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, (yy / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, xc1, xs1, 0);
            vertex_normal(vbuff, xc1 * ys2, xs1 * ys2, yc2);
            vertex_texcoord(vbuff, (xx / argument0) * argument2, ((yy + 1) / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, xc2, xs2, 0);
            vertex_normal(vbuff, xc2 * ys2, xs2 * ys2, yc2);
            vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, ((yy + 1) / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, xc2, xs2, 0);
            vertex_normal(vbuff, xc2 * ys1, xs2 * ys1, yc1);
            vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, (yy / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
        }
    }
    
    vertex_end(vbuff);
    vertex_freeze(vbuff);
    return vbuff;
}

function colmesh_create_disk(argument0, argument1, argument2, argument3)
{
    var vbuff = vertex_create_buffer();
    vertex_begin(vbuff, global.ColMeshFormat);
    
    for (var xx = 0; xx < argument0; xx++)
    {
        var xa1 = (xx / argument0) * 2 * pi;
        var xa2 = ((xx + 1) / argument0) * 2 * pi;
        var xc1 = cos(xa1);
        var xs1 = sin(xa1);
        var xc2 = cos(xa2);
        var xs2 = sin(xa2);
        vertex_position_3d(vbuff, 1, 0, 0);
        vertex_normal(vbuff, 0, 0, 1);
        vertex_texcoord(vbuff, argument2, 0);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, xc1, xs1, 0);
        vertex_normal(vbuff, 0, 0, 1);
        vertex_texcoord(vbuff, xc1 * argument2, xs1 * argument3);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, xc2, xs2, 0);
        vertex_normal(vbuff, 0, 0, 1);
        vertex_texcoord(vbuff, xc2 * argument2, xs2 * argument3);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, 1, 0, 0);
        vertex_normal(vbuff, 0, 0, -1);
        vertex_texcoord(vbuff, argument2, 0);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, xc2, xs2, 0);
        vertex_normal(vbuff, 0, 0, -1);
        vertex_texcoord(vbuff, xc2 * argument2, xs2 * argument3);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, xc1, xs1, 0);
        vertex_normal(vbuff, 0, 0, -1);
        vertex_texcoord(vbuff, xc1 * argument2, xs1 * argument3);
        vertex_color(vbuff, c_white, 1);
        
        for (var yy = 0; yy < argument1; yy++)
        {
            var ya1 = (yy / argument1) * pi;
            var ya2 = ((yy + 1) / argument1) * pi;
            var yc1 = cos(ya1);
            var ys1 = sin(ya1);
            var yc2 = cos(ya2);
            var ys2 = sin(ya2);
            vertex_position_3d(vbuff, xc1, xs1, 0);
            vertex_normal(vbuff, xc1 * ys1, xs1 * ys1, yc1);
            vertex_texcoord(vbuff, (xx / argument0) * argument2, (yy / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, xc1, xs1, 0);
            vertex_normal(vbuff, xc1 * ys2, xs1 * ys2, yc2);
            vertex_texcoord(vbuff, (xx / argument0) * argument2, ((yy + 1) / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, xc2, xs2, 0);
            vertex_normal(vbuff, xc2 * ys1, xs2 * ys1, yc1);
            vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, (yy / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, xc1, xs1, 0);
            vertex_normal(vbuff, xc1 * ys2, xs1 * ys2, yc2);
            vertex_texcoord(vbuff, (xx / argument0) * argument2, ((yy + 1) / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, xc2, xs2, 0);
            vertex_normal(vbuff, xc2 * ys2, xs2 * ys2, yc2);
            vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, ((yy + 1) / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, xc2, xs2, 0);
            vertex_normal(vbuff, xc2 * ys1, xs2 * ys1, yc1);
            vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, (yy / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
        }
    }
    
    vertex_end(vbuff);
    vertex_freeze(vbuff);
    return vbuff;
}

function colmesh_create_capsule(argument0, argument1, argument2, argument3)
{
    var vbuff = vertex_create_buffer();
    vertex_begin(vbuff, global.ColMeshFormat);
    
    for (var xx = 0; xx < argument0; xx++)
    {
        var xa1 = (xx / argument0) * 2 * pi;
        var xa2 = ((xx + 1) / argument0) * 2 * pi;
        var xc1 = cos(xa1);
        var xs1 = sin(xa1);
        var xc2 = cos(xa2);
        var xs2 = sin(xa2);
        vertex_position_3d(vbuff, 0, 0, 0);
        vertex_normal(vbuff, xc1, xs1, 0);
        vertex_texcoord(vbuff, (xx / argument0) * argument2, 0);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, 0, 0, 0);
        vertex_normal(vbuff, xc2, xs2, 0);
        vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, 0);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, 0, 0, 1);
        vertex_normal(vbuff, xc1, xs1, 0);
        vertex_texcoord(vbuff, (xx / argument0) * argument2, argument3);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, 0, 0, 0);
        vertex_normal(vbuff, xc2, xs2, 0);
        vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, 0);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, 0, 0, 1);
        vertex_normal(vbuff, xc2, xs2, 0);
        vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, argument3);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, 0, 0, 1);
        vertex_normal(vbuff, xc1, xs1, 0);
        vertex_texcoord(vbuff, (xx / argument0) * argument2, argument3);
        vertex_color(vbuff, c_white, 1);
        
        for (var yy = 0; yy < argument1; yy++)
        {
            var ya1 = ((yy / argument1) * pi) / 2;
            var ya2 = (((yy + 1) / argument1) * pi) / 2;
            var yc1 = cos(ya1);
            var ys1 = sin(ya1);
            var yc2 = cos(ya2);
            var ys2 = sin(ya2);
            vertex_position_3d(vbuff, 0, 0, 0);
            vertex_normal(vbuff, xc1 * ys1, xs1 * ys1, -yc1);
            vertex_texcoord(vbuff, (xx / argument0) * argument2, (yy / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, 0, 0, 0);
            vertex_normal(vbuff, xc2 * ys1, xs2 * ys1, -yc1);
            vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, (yy / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, 0, 0, 0);
            vertex_normal(vbuff, xc1 * ys2, xs1 * ys2, -yc2);
            vertex_texcoord(vbuff, (xx / argument0) * argument2, ((yy + 1) / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, 0, 0, 0);
            vertex_normal(vbuff, xc1 * ys2, xs1 * ys2, -yc2);
            vertex_texcoord(vbuff, (xx / argument0) * argument2, ((yy + 1) / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, 0, 0, 0);
            vertex_normal(vbuff, xc2 * ys1, xs2 * ys1, -yc1);
            vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, (yy / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, 0, 0, 0);
            vertex_normal(vbuff, xc2 * ys2, xs2 * ys2, -yc2);
            vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, ((yy + 1) / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, 0, 0, 1);
            vertex_normal(vbuff, xc1 * ys1, xs1 * ys1, yc1);
            vertex_texcoord(vbuff, (xx / argument0) * argument2, (yy / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, 0, 0, 1);
            vertex_normal(vbuff, xc1 * ys2, xs1 * ys2, yc2);
            vertex_texcoord(vbuff, (xx / argument0) * argument2, ((yy + 1) / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, 0, 0, 1);
            vertex_normal(vbuff, xc2 * ys1, xs2 * ys1, yc1);
            vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, (yy / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, 0, 0, 1);
            vertex_normal(vbuff, xc1 * ys2, xs1 * ys2, yc2);
            vertex_texcoord(vbuff, (xx / argument0) * argument2, ((yy + 1) / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, 0, 0, 1);
            vertex_normal(vbuff, xc2 * ys2, xs2 * ys2, yc2);
            vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, ((yy + 1) / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
            vertex_position_3d(vbuff, 0, 0, 1);
            vertex_normal(vbuff, xc2 * ys1, xs2 * ys1, yc1);
            vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument2, (yy / argument1) * argument3);
            vertex_color(vbuff, c_white, 1);
        }
    }
    
    vertex_end(vbuff);
    vertex_freeze(vbuff);
    return vbuff;
}

function colmesh_create_cylinder(argument0, argument1, argument2)
{
    var vbuff = vertex_create_buffer();
    vertex_begin(vbuff, global.ColMeshFormat);
    
    for (var xx = 0; xx < argument0; xx++)
    {
        var xa1 = (xx / argument0) * 2 * pi;
        var xa2 = ((xx + 1) / argument0) * 2 * pi;
        var xc1 = cos(xa1);
        var xs1 = sin(xa1);
        var xc2 = cos(xa2);
        var xs2 = sin(xa2);
        vertex_position_3d(vbuff, xc1, xs1, 0);
        vertex_normal(vbuff, xc1, xs1, 0);
        vertex_texcoord(vbuff, (xx / argument0) * argument1, 0);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, xc2, xs2, 0);
        vertex_normal(vbuff, xc2, xs2, 0);
        vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument1, 0);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, xc1, xs1, 1);
        vertex_normal(vbuff, xc1, xs1, 0);
        vertex_texcoord(vbuff, (xx / argument0) * argument1, argument2);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, xc2, xs2, 0);
        vertex_normal(vbuff, xc2, xs2, 0);
        vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument1, 0);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, xc2, xs2, 1);
        vertex_normal(vbuff, xc2, xs2, 0);
        vertex_texcoord(vbuff, ((xx + 1) / argument0) * argument1, argument2);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, xc1, xs1, 1);
        vertex_normal(vbuff, xc1, xs1, 0);
        vertex_texcoord(vbuff, (xx / argument0) * argument1, argument2);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, 1, 0, 0);
        vertex_normal(vbuff, 0, 0, -1);
        vertex_texcoord(vbuff, argument1, 0.5 * argument2);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, xc2, xs2, 0);
        vertex_normal(vbuff, 0, 0, -1);
        vertex_texcoord(vbuff, (0.5 + (0.5 * xc2)) * argument1, (0.5 + (0.5 * xs2)) * argument2);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, xc1, xs1, 0);
        vertex_normal(vbuff, 0, 0, -1);
        vertex_texcoord(vbuff, (0.5 + (0.5 * xc1)) * argument1, (0.5 + (0.5 * xs1)) * argument2);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, 1, 0, 1);
        vertex_normal(vbuff, 0, 0, 1);
        vertex_texcoord(vbuff, argument1, 0.5 * argument2);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, xc1, xs1, 1);
        vertex_normal(vbuff, 0, 0, 1);
        vertex_texcoord(vbuff, (0.5 + (0.5 * xc1)) * argument1, (0.5 + (0.5 * xs1)) * argument2);
        vertex_color(vbuff, c_white, 1);
        vertex_position_3d(vbuff, xc2, xs2, 1);
        vertex_normal(vbuff, 0, 0, 1);
        vertex_texcoord(vbuff, (0.5 + (0.5 * xc2)) * argument1, (0.5 + (0.5 * xs2)) * argument2);
        vertex_color(vbuff, c_white, 1);
    }
    
    vertex_end(vbuff);
    vertex_freeze(vbuff);
    return vbuff;
}
