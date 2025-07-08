if (state == states.capefall && thrown == 0 && object_index != obj_pizzaboy)
    stundraw = 25;
else
    stundraw = 0;

gpu_set_fog(flash, c_white, 1, 1);
draw_sprite_ext(sprite_index, image_index, x, y + stundraw, xscale * image_xscale, yscale, image_angle, image_blend, image_alpha);
gpu_set_fog(false, c_black, 0, 0);
