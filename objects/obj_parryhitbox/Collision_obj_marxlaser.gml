with (other)
{
    if (!parried)
    {
        parried = true;
        
        if (!instance_exists(obj_fadeout))
        {
            alarm[1] = 40;
            obj_camera.zoom = 0.7;
            obj_camera.spdzooming = 0.035;
        }
    }
}

if (!collisioned)
    event_user(1);
