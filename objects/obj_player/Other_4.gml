if (object_index == obj_player1)
{
    with (obj_secretportal)
    {
        if (secret)
        {
            if (!instance_exists(obj_ghostcollectibles))
            {
                instance_create(0, 0, obj_ghostcollectibles);
                trace(instance_number(obj_ghostcollectibles));
            }
        }
        
        if (instance_exists(obj_specialdoor))
            state = states.actor;
    }
    
    if (global.coop == 1)
        scr_changetoppings();
    
    if (object_index == obj_player2 && (obj_player1.spotlight == 1 && global.coop == 1))
    {
        alarm[5] = 2;
        alarm[7] = 60;
        hurted = 1;
    }
    
    if (object_index == obj_player1 && obj_player1.spotlight == 0)
    {
        alarm[5] = 2;
        alarm[7] = 60;
        hurted = 1;
    }
    
    if (object_index != obj_player2 || global.coop == 1)
    {
        var dr = asset_get_index(concat("obj_door", targetDoor));
        
        if (instance_exists(dr))
        {
            with (dr)
                scr_startdoor();
            
            hallway = 0;
            vhallway = 0;
            box = 0;
            fastpizzabox = 0;
        }
        
        if (failexit)
        {
            with (obj_exitbubble)
            {
                state = 1;
                x = obj_player1.x;
                y = camera_get_view_y(view_camera[0]) - 100;
            }
            
            visible = false;
            failexit = false;
        }
    }
    
    roomstartx = x;
    roomstarty = y;
}

ladderx = x;

if (!instance_exists(obj_25Dcamera))
{
    if (depth == -32)
        depth = -7;
}

if (global.smoothcam)
{
    with (obj_camera)
    {
        if (secretcam == 1)
        {
            player = obj_secretportalstart;
            secretcam = 0;
        }
        else if (secretcamexit == 1)
        {
            player = obj_player1.secretportalID;
            secretcamexit = 0;
        }
        else
            player = obj_player1;
        
        var target = player;
        
        if (!instance_exists(target))
            target = obj_player1;
        
        var cam_width = camera_get_view_width(view_camera[0]);
        var cam_height = camera_get_view_height(view_camera[0]);
        var cam_x = camera_get_view_x(view_camera[0]);
        var cam_y = camera_get_view_y(view_camera[0]);
        cam_x = (target.x - (cam_width / 2)) + chargecamera;
        cam_y = target.y - (cam_height / 2) - 50;
        camera_set_view_pos(view_camera[0], cam_x, cam_y + irandom_range(-shake_mag, shake_mag));
    }
}
