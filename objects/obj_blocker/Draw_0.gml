gpu_set_fog(flash, c_white, 1, 1);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);
gpu_set_fog(false, c_black, 0, 0);

if (sprite_index == spr_blocker || sprite_index == spr_blockertalk)
    draw_sprite_ext(sprbubblebox, bubblebox_index, (sprbubblebox == spr_textbox || sprbubblebox == spr_bubbleboxtotextbox || sprbubblebox == spr_textboxtobubblebox) ? (x - 32) : x, (sprbubblebox == spr_textbox || sprbubblebox == spr_bubbleboxtotextbox || sprbubblebox == spr_textboxtobubblebox) ? (y - 64) : (y - 32), 1, 1, 0, c_white, bubblealpha);

draw_sprite_ext(spr_bubbleboxcontent, contentindex, x, (y - 35) + contenty, 1, 1, 0, c_white, contentalpha * bubblealpha);
