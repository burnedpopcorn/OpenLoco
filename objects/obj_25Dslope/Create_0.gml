groundDepth = -64;
groundOffset = 0;
image_xscale = sprite_width / sprite_get_width(sprite_index);
z = depth + groundOffset;

vBuffTop = vertex_create_buffer();
textureTop = sprite_get_texture(spr_wall25D, 0);
vertex_begin(vBuffTop, global.vFormat);

if (sign(image_xscale) == 1)
    vertex_create_face(vBuffTop, new Vec3(x, y + sprite_height, z + groundDepth), new Vec3(x + sprite_width, y, z + groundDepth), new Vec3(x + sprite_width, y, z), new Vec3(x, y + sprite_height, z), -1, 1, sprite_width, groundDepth);
else if (sign(image_xscale) == -1)
    vertex_create_face(vBuffTop, new Vec3(x, y, z + groundDepth), new Vec3(x + sprite_width, y + sprite_height, z + groundDepth), new Vec3(x + sprite_width, y + sprite_height, z), new Vec3(x, y, z), -1, 1, sprite_width, groundDepth);

vertex_create_face(vBuffTop, new Vec3(x, y + sprite_height, z + groundDepth), new Vec3(x + sprite_width, y + sprite_height, z + groundDepth), new Vec3(x + sprite_width, y + sprite_height, z), new Vec3(x, y + sprite_height, z), -1, 1, sprite_width, groundDepth);
vertex_end(vBuffTop);
vertex_freeze(vBuffTop);

vBuffSides = vertex_create_buffer();
textureSides = sprite_get_texture(spr_wall25D, 0);
vertex_begin(vBuffSides, global.vFormat);

if (sign(image_xscale) == -1)
    vertex_create_face(vBuffSides, new Vec3(x, y, z + groundDepth), new Vec3(x, y, z), new Vec3(x, y + sprite_height, z), new Vec3(x, y + sprite_height, z + groundDepth), -1, 1, groundDepth, sprite_height);
else if (sign(image_xscale) == 1)
    vertex_create_face(vBuffSides, new Vec3(x + sprite_width, y, z + groundDepth), new Vec3(x + sprite_width, y, z), new Vec3(x + sprite_width, y + sprite_height, z), new Vec3(x + sprite_width, y + sprite_height, z + groundDepth), -1, 1, groundDepth, sprite_height);

vertex_end(vBuffSides);
vertex_freeze(vBuffSides);
