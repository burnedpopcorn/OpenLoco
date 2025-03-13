with (other)
{
    if (state != states.actor && other.buffer <= 0)
    {
        var changecoord = 1;
        
        if (place_meeting(x, y, obj_superspring))
            changecoord = 0;
        
        if (changecoord)
            y = other.y - 14;
        
        vsp = 0;
        
        if (sprite_index != get_charactersprite("spr_dashpad"))
        {
            sprite_index = get_charactersprite("spr_dashpad");
            image_index = 0;
        }
        
        instance_create(x, y, obj_jumpdust);
        machhitAnim = 0;
        state = states.mach3;
        xscale = sign(other.image_xscale);
        fmod_studio_event_oneshot_3d("event:/sfx/level_structure/dashpad");
        
        if (movespeed < 14)
        {
            movespeed = 14;
            hsp = xscale * movespeed;
        }
        else
        {
            movespeed += 0.5;
            hsp = xscale * movespeed;
        }
        
        other.buffer = 30;
    }
}
