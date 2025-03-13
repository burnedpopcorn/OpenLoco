gpu_set_fog(flash, c_white, 1, 1);
draw_sprite_ext(sprite_index, image_index, X, Y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
gpu_set_fog(false, c_black, 0, 0);
