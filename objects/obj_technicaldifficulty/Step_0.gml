if (floor(image_index) == (image_number - 1))
{
    switch (sprite_index)
    {
        case spr_tvtransition:
            if (bg2 == GuessWhat)
            {
            }
            
            with (playerid)
            {
                x = roomstartx;
                y = roomstarty;
            }
            
            use_static = 0;
            alarm[0] = 75;
            image_index = 0;
            image_speed = 0;
            break;
        
        case spr_tvtransitionreverse:
            instance_destroy();
            break;
    }
}
