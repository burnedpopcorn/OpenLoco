if (other.state != states.slipnslide && other.state != states.debugstate && other.state != states.bubble)
{
    other.state = states.slipnslide;
    other.sprite_index = get_charactersprite("spr_machfreefall", other);
    other.xscale = sign(image_xscale);
}

if (other.state != states.debugstate && other.state != states.bubble)
{
    if (targetAngle != -90 && targetAngle != 90)
    {
        if (other.cantvspmove == 1)
            other.cantvspmove = 0;
        
        other.canthspmove = 1;
        other.movespeed = Approach(other.movespeed, 15 * sign(image_xscale), 0.5);
    }
    else
    {
        if (other.canthspmove == 1)
            other.canthspmove = 0;
        
        other.cantvspmove = 1;
        other.vsp = Approach(other.vsp, 12 * sign(-targetAngle), 0.5);
    }
}
