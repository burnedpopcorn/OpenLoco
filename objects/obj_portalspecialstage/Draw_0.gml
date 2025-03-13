matrix_set(2, matrix_build(x + 16, y + 16 + portaly, -32, xoff, yoff, 0, xscale, yscale, zscale));
vertex_submit(model, pr_trianglelist, sprite_get_texture(eggtexture, 0));
matrix_set(2, matrix_build_identity());
