scr_collision();

if ((place_meeting_collision(x, y + vsp) && !place_meeting_slope(x, y + vsp)) && !rolling)
{
    if (!doublejump)
    {
        vsp = -12;
        doublejump = 1;
        fmod_studio_event_oneshot_3d("event:/sfx/player/bodyslam_land");
    }
    else
    {
        fmod_studio_event_oneshot_3d("event:/sfx/player/bodyslam_land");
        instance_destroy();
    }
}

if (place_meeting_slope(x, y + vsp))
{
    with (instance_place(x, y + 1, obj_slope))
        other.image_xscale = -sign(image_xscale);
    
    rolling = 1;
    doublejump = 2;
}

if (rolling == 1)
{
    hsp = image_xscale * movespeed;
    
    if (place_meeting_solid(x + sign(hsp), y) && (!scr_slope() || place_meeting_collision(x + sign(hsp), y - 2)) && !place_meeting_slope(x + sign(hsp), y))
    {
        instance_destroy();
        fmod_studio_event_oneshot_3d("event:/sfx/player/bodyslam_land");
    }
    
    if (place_meeting_slope(x, y + 1))
    {
        with (instance_place(x, y + 1, obj_slope))
        {
            if (other.image_xscale == -sign(image_xscale))
            {
                if (other.movespeed < 14)
                    other.movespeed += 0.25;
            }
        }
    }
}

if (!rolling)
{
    hsp = image_xscale * movespeed;
    
    if (place_meeting_collision(x, y + hsp))
        image_xscale *= -1;
}

if (doublejump)
    angle += 25;
