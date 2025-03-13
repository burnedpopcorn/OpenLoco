var spr = object_get_sprite(obj_array[num]);
var spr_w = sprite_get_width(spr);
var spr_h = sprite_get_height(spr);
var spr_xoff = sprite_get_xoffset(spr);
var spr_yoff = sprite_get_yoffset(spr);
draw_sprite_part(spr, 0, 0, 0, sprite_get_width(spr), zombie_y, (x - spr_xoff) + get_shake(shake).x, (y + spr_yoff) - zombie_y - yoffset);
draw_sprite_ext(sprite_index, image_index, x, y, 1, 1, 0, c_white, 1);
