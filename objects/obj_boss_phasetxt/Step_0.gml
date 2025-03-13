if (!chilling)
{
    image_xscale -= 0.3;
    image_yscale -= 0.3;
    y -= 4;
    image_alpha = Approach(image_alpha, 1, 0.2);
    
    if (image_xscale < 3)
        chilling = true;
    
    exit;
}

image_xscale = Approach(image_xscale, 4, 0.3);
image_yscale = Approach(image_yscale, 4, 0.3);

if (alarm[0] == -1)
    alarm[0] = 60;

if (dying)
{
    y -= 2;
    
    if ((y + sheight) < 0)
        instance_destroy();
}
