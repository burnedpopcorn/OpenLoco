if (state != states.normal)
    exit;

var nearest = instance_nearest(x, y, obj_zombie);

if (nearest == noone)
{
    last_saw = false;
    exit;
}

var seen = (image_xscale == -1 && nearest.x < x && nearest.x >= (x - distance)) || (image_xscale == 1 && nearest.x > x && nearest.x <= (x + distance));

if (!(seen && nearest.y <= y))
{
    last_saw = false;
    exit;
}

if (!last_saw)
    instance_create(x, (y - sprite_height) + 10, obj_peashooter_saw);

last_saw = true;
image_index = 0;
sprite_index = spr_shoot;
shots_left = 1;
