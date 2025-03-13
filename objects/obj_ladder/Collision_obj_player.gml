with (obj_player1)
{
    if (key_up && (place_meeting(x, y, other.id) && (ladderbuffer == 0 && ((state == states.normal || (state == states.mach2 || (state == states.mach3 || (state == states.mach1 || (state == states.shotgunjump || (state == states.jump || state == states.highjump)))))) && (state != states.hurt && (state != states.machslide && (state != states.freefall && state != states.freefallland)))))))
    {
        mach2 = 0;
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

if (instance_exists(obj_player2))
{
    with (obj_player2)
    {
        if (key_up && (place_meeting(x, y, other.id) && (ladderbuffer == 0 && ((state == states.normal || (state == states.mach2 || (state == states.mach3 || (state == states.mach1 || (state == states.shotgunjump || (state == states.jump || state == states.highjump)))))) && (state != states.hurt && (state != states.machslide && (state != states.freefall && state != states.freefallland)))))))
        {
            mach2 = 0;
            state = states.ladder;
            
            if (other.image_xscale == 1)
                x = other.x + 16;
            
            y = floor(y);
            
            if ((y % 2) == 1)
                y -= 1;
        }
    }
}
