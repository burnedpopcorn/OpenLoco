if (!(rank == "d" || rank == "c" || rank == "b" || rank == "a" || rank == "s" || rank == "l"))
{
    if (place_meeting(x, y - 1, obj_player1))
    {
        with (obj_player1)
        {
            fmod_studio_event_instance_start(obj_player1.slipbanansnd);
            sprite_index = get_charactersprite("spr_slipbanan1");
            vsp = -6;
            movespeed = 13;
            xscale = 1;
            hsp = movespeed * xscale;
            image_index = 0;
            state = states.slipbanana;
        }
        
        fmod_studio_event_oneshot_3d("event:/sfx/level_structure/destroy");
        instance_destroy(self);
    }
}
else if (place_meeting(x, y - 1, obj_player1))
{
    with (obj_player1)
    {
        if (state == states.freefall)
        {
            with (other)
            {
                fmod_studio_event_oneshot_3d("event:/sfx/level_structure/destroy");
                instance_destroy();
            }
        }
    }
}
