gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_texrepeat(true);
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
vertex_format = vertex_format_end();
depths = 0;
model = load_obj("3Dmodels/treasuredoor.obj", "3Dmodels/treasuredoor.mtl", self);
