var player = instance_nearest(x, y, obj_player);
var angle = point_direction(x, y, player.x, player.y);
x += lengthdir_x(movespeed, angle);
y += lengthdir_y(movespeed, angle);
image_xscale = lerp(image_xscale, 0, 0.004);
image_yscale = image_xscale;
