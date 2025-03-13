if (point_distance(x, y, obj_player1.x, obj_player1.y) < 250)
{
    if (ds_list_size(imagelist) > 0)
        appearmultiimage();
    else
        appear();
}
else
{
    disappear();
}

globoxindex += 0.35;
globoxindex = wrap(globoxindex, 0, sprite_get_number(globoxsprite));
