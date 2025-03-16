y += hspeed;
x += vspeed;

switch (type)
{
    default: // grab
        image_alpha -= 0.15;
        break;
    
    case afterimgs.runningcolors: // run colors
        image_alpha = Wave(1, 0, 0.1, 0);
        break;
    
    case afterimgs.unusedimg: // seemingly unused
        image_alpha -= 0.025;
}

if (image_alpha <= 0 && type != afterimgs.runningcolors)
    instance_destroy();

if (type != afterimgs.unusedimg)
    exit;

x = xstart + lengthdir_x(len * invert, dir);
y = ystart + lengthdir_y(len * invert, dir);
dir += 10;
dir = wrap(dir, 0, 360);
image_angle = dir;
len += 10;
