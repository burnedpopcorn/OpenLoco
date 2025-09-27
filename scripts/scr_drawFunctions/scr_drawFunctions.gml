function draw_sprite_ext_flash(_sprite, _subimg, _x, _y, _xscale, _yscale, _rot, _col, _alpha)
{
    gpu_set_fog(true, _col, 0, 1);
    draw_sprite_ext(_sprite, _subimg, _x, _y, _xscale, _yscale, _rot, _col, _alpha);
    gpu_set_fog(false, c_black, 0, 0);
}
