if (state == states.capefall && thrown == 0 && object_index != obj_pizzaboy)
    stundraw = 25;
else
    stundraw = 0;

gpu_set_fog(flash, c_white, 1, 1);
draw_sprite_ext(sprite_index, image_index, x, y + stundraw, xscale * image_xscale, yscale, image_angle, c_gray, image_alpha);
gpu_set_fog(false, c_black, 0, 0);

if (elite && maxelitehit != elitehit)
{
    var hpelite = (elitehit / maxelitehit) * 100;
    draw_healthbar(x - 20, y - 40, x + 20, y - 20, hpelite, c_black, c_red, c_lime, 0, true, true);
}
