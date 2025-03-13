with (other)
{
    sprite_index = get_charactersprite("spr_slipbanan1");
    other.drop = 1;
    vsp = -11;
    movespeed += 2;
    
    if (movespeed > 14)
        movespeed = 14;
    
    hsp = movespeed * xscale;
    image_index = 0;
    state = states.slipbanana;
    fmod_studio_event_instance_start(slipbanansnd);
}
