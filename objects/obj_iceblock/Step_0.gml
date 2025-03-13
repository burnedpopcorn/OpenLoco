if (place_meeting(x, y - 1, obj_player1))
{
    with (obj_player1)
    {
        if (state == UnknownEnum.Value_24)
            state = UnknownEnum.Value_18;
        else if (state != UnknownEnum.Value_18)
            state = states.slipnslide;
        
        if (movespeed < 12)
            movespeed = 12;
    }
}

if (place_meeting(x, y - 1, obj_player2))
{
    with (obj_player2)
    {
        if (state == UnknownEnum.Value_24)
            state = UnknownEnum.Value_18;
        else if (state != UnknownEnum.Value_18)
            state = states.slipnslide;
        
        if (movespeed < 12)
            movespeed = 12;
    }
}
