gpu_set_ztestenable(true);
gpu_set_zwriteenable(true);
gpu_set_texrepeat(true);
xscale = 1;
yscale = 1;
zscale = 1;
xspd = 0.2;
yspd = 0.4;
portaly = 0;
entering = 0;
xoff = 0;
yoff = 0;
going = 0;
specialstageroom = -4;
vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_normal();
vertex_format_add_texcoord();
vertex_format_add_color();
vertex_format = vertex_format_end();
pitch = 20;
model = load_obj("egg.obj", "egg.mtl", self);
