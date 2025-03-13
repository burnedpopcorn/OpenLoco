var drawpoint = point_direction(collectx, collecty, targetx, targety);
collectx += lengthdir_x(spd, drawpoint);
collecty += lengthdir_y(spd, drawpoint);
draw_sprite_ext(sprite_index, -1, collectx, collecty, 1, 1, 0, c_white, image_alpha);

if (point_in_circle(collectx, collecty, targetx, targety, spd))
{
    collectx = targetx;
    collecty = targety;
    instance_destroy();
}
