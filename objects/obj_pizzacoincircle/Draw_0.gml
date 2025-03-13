var _angle = angle;
var add = 360 / coins;

repeat (coins)
{
    _angle += add;
    var targ_x = x + lengthdir_x(85, _angle);
    var targ_y = y + lengthdir_y(85, _angle);
    draw_sprite(spr_pizzacoin, image_index, targ_x, targ_y);
    
    if (coinslast != coins)
    {
        repeat (4)
            create_particle(targ_x + random_range(25, -25), targ_y + random_range(25, -25), 11, 0);
    }
}

coinslast = coins;
