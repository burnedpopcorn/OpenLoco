rock_y -= 7;

if (ending)
{
    fade = Approach(fade, 0, 0.1);
    
    if (fade <= 0)
        instance_destroy();
}

yoffest = Approach(yoffest, 0, 60);

if (yoffest == 0 && !dontrepeat)
    image_speed = 0.35;

if (floor(image_index) == (image_number - 1) && !dontrepeat)
{
    obj_hungrypillar.hitLag = 1;
    obj_player.hitLag = 1;
    dontrepeat = 1;
    image_speed = 0;
}

if (bgoffest > -540)
    bgoffest -= 40;

if (bgoffest <= -540)
    bgoffest = 0;
