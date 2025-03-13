with (other)
{
    if (state == states.lawnmower || state == states.lawnmowerslide || (state == states.backbreaker && styledtaunting))
    {
        if (hsp != 0)
            xscale = sign(hsp);
        
        movespeed = abs(hsp);
        state = states.normal;
        sprite_index = spr_idle;
        dir = xscale;
        styledtaunting = 0;
        fmod_studio_event_oneshot_3d("event:/sfx/player/misc/detransform");
        create_debris(x, y - 40, spr_skateboard);
        instance_create(x, y, obj_genericpoofeffect);
    }
}
