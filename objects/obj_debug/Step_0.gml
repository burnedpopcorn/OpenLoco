if (keyboard_check_pressed(vk_f1))
{
    switch (global.debugmode)
    {
        case 0:
            global.debugmode = 1;
            break;
        
        case 1:
            global.debugmode = 0;
            showcollisions = 0;
            showdetails = 0;
            fmod_studio_event_oneshot("event:/sfx/player/damage");
            break;
    }
}

if (global.debugmode == 1)
{
    if (keyboard_check_pressed(vk_f3))
        showdetails = !showdetails;
    
    if (keyboard_check_pressed(vk_f4))
        showcollisions = !showcollisions;
    
    if (keyboard_check_pressed(vk_f5) && instance_exists(obj_player1))
    {
        with (obj_player1)
        {
            if (state != states.debugstate)
                state = states.debugstate;
        }
    }
}

with (obj_solid)
{
    if (object_index == obj_solid || object_index == obj_secretbigblock || object_index == obj_secretblock || object_index == obj_secretmetalblock)
        visible = other.showcollisions;
}

with (obj_slope)
{
    if (object_index == obj_slope)
        visible = other.showcollisions;
}

with (obj_platform)
{
    if (object_index == obj_platform)
        visible = other.showcollisions;
}
