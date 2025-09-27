var _target = instance_nearest(x, y, obj_player);

if (_target == noone)
    _target = obj_player1;

target_angle = Approach(target_angle, point_direction(x, y, _target.x, _target.y), 1);
speed = 8 + (distance_to_object(_target) / 50);
x += lengthdir_x(speed, target_angle);
y += lengthdir_y(speed, target_angle);
