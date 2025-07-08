with (other.id)
{
    if (!(global.laps >= 5))
    {
        if (instance_exists(other.baddieID) && (state != states.tumble && (state != states.backbreaker && (state != states.knightpep && state != states.knightpepslopes))))
        {
            state = 2;
            xscale = other.baddieID.image_xscale;
            movespeed = 14;
            vsp = 0;
            sprite_index = get_charactersprite("spr_tumble");
        }
    }
    else
    {
        sprite_index = get_charactersprite("spr_rockethitwall");
        vsp = -11;
        movespeed += 2;
        
        if (movespeed > 14)
            movespeed = 14;
        
        xscale = other.image_xscale;
        hsp = movespeed * xscale;
        image_index = 0;
        
        if (state != states.slipbanana)
        {
            fmod_studio_event_oneshot_3d("event:/sfx/player/punch");
            state = states.slipbanana;
        }
    }
}
