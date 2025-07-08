with (other)
{
    if (state == states.grab || state != states.handstandjump)
        exit;
    
    if (state == states.zombieattack)
    {
        instance_destroy(other);
        exit;
    }
    
    if (!other.grabbable)
        exit;
    
    sprite_index = (movespeed <= 10) ? get_charactersprite("spr_haulingidle") : get_charactersprite("spr_swingding");
    
    if (!grounded)
        vsp = 6;
    
    swingdingendcooldown = 0;
    state = states.grab;
    baddiegrabbedID = other.id;
    other.state = states.grabbed;
    other.grabber = id;
}
