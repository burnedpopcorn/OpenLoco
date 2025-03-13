scr_getinput();

if (key_up2 && !active)
{
    active = true;
    
    with (other)
    {
        sprite_index = get_charactersprite("spr_lookdoor");
        image_index = 0;
        state = states.door;
        mach2 = 0;
        hsp = 0;
        other.image_speed = 0.35;
        other.pid = id;
    }
}
