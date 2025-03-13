y += hspeed;
x += vspeed;

switch (type)
{
    default:
        image_alpha -= 0.15;
        break;
    
    case UnknownEnum.Value_1:
        image_alpha = Wave(1, 0, 0.1, 0);
        break;
    
    case UnknownEnum.Value_2:
        image_alpha -= 0.025;
}

if (image_alpha <= 0 && type != UnknownEnum.Value_1)
    instance_destroy();

if (type != UnknownEnum.Value_2)
    exit;

x = xstart + lengthdir_x(len * invert, dir);
y = ystart + lengthdir_y(len * invert, dir);
dir += 10;
dir = wrap(dir, 0, 360);
image_angle = dir;
len += 10;
