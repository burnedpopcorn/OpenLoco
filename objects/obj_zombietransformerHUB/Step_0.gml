var r = rank_get_value(rank);

if (r == 1)
    instance_destroy();

if (place_meeting(x, y, obj_player1))
{
    with (obj_player1)
    {
        if (state == states.normal && grounded && key_up2)
        {
            state = 13;
            sprite_index = spr_cheesepep_idle;
        }
    }
}
