instance_destroy(instance_place(x, y - 1, obj_baddie));

if (place_meeting(x, y - 1, obj_player))
{
    with (obj_player)
    {
        if (place_meeting(x, y + 1, other))
        {
            state = states.slipnslide;
            sprite_index = get_charactersprite("spr_current");
            xscale = sign(other.image_xscale);
            movespeed = 20;
        }
    }
}
