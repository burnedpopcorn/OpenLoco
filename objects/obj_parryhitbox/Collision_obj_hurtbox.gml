if (other.object_index == obj_spitcheesespike || other.object_index == obj_robotknife)
{
    with (other)
    {
        var current_hspd = abs(hsp);
        var _dir = sign(hsp);
        
        if (x != other.x)
            _dir = sign(x - other.x);
        
        hsp = _dir * current_hspd;
        image_xscale = _dir;
    }
}

if (other.object_index == obj_crushershockwave)
{
    with (other)
    {
        xscale *= -1;
        movespeed = xscale * 9;
    }
}

if (!collisioned)
    event_user(0);
