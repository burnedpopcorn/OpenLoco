if (live_call())
    return global.live_result;

if (!djump)
{
    sprite_set_offset(sprite_index, 0, sprite_height / 2);
    image_xscale = Approach(image_xscale, approach_xscale * obj_player.xscale, 5);
    image_yscale = Approach(image_yscale, approach_yscale, 5);
}
else
{
    sprite_set_offset(sprite_index, sprite_width / 2, 0);
    image_xscale = 1;
    image_yscale += 1;
}

lifespan--;

if (lifespan < 0 && image_alpha > 0)
    image_alpha -= 0.1;

if (image_alpha <= 0)
    instance_destroy();
