function scr_pummel()
{
    sprite_index = get_charactersprite("spr_suplexmash" + string(irandom_range(1, 7)));
    image_index = 0;
    state = states.tackle;
    movespeed = 4;
    vsp = -3;
}
