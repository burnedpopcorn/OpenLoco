if (place_meeting(x, y - 1, obj_player1))
{
    with (obj_player1)
    {
        if (place_meeting(x, y + 1, obj_ladder) && (key_down && ((state == states.crouch || (character == "S" && (state == states.normal || state == states.mach1))) && !place_meeting(other.x + 16, y + 1, obj_solid) && place_meeting(x, y + 1, obj_platform))))
        {
            y += 5;
            state = states.ladder;
            
            if (other.image_xscale == 1)
                ladderx = other.x + 16;
            else
                ladderx = x;
            
            y = floor(y);
            
            if ((y % 2) == 1)
                y -= 1;
        }
    }
}

if (instance_exists(obj_player2))
{
    if (place_meeting(x, y - 1, obj_player2))
    {
        with (obj_player2)
        {
            if (place_meeting(x, y + 1, obj_ladder) && (key_down && ((state == states.crouch || (character == "S" && (state == states.normal || state == states.mach1))) && place_meeting(x, y + 1, obj_platform))))
            {
                y += 5;
                state = states.ladder;
                
                if (other.image_xscale == 1)
                    x = other.x + 16;
                
                y = floor(y);
                
                if ((y % 2) == 1)
                    y -= 1;
            }
        }
    }
}
