if (place_meeting(x, y - 1, obj_player1))
{
    with (obj_player1)
    {
        if (state == states.unknown24)
            state = states.unknown18;
        else if (state != states.unknown18)
            state = states.slipnslide;
        
        if (movespeed < 12)
            movespeed = 12;
    }
}

if (place_meeting(x, y - 1, obj_player2))
{
    with (obj_player2)
    {
        if (state == states.unknown24)
            state = states.unknown18;
        else if (state != states.unknown18)
            state = states.slipnslide;
        
        if (movespeed < 12)
            movespeed = 12;
    }
}
