if (room != rank_room)
{
    if (room == timesuproom)
    {
        with (obj_player1)
        {
            instance_create(x, y, obj_exitbubble);
            hsp = 0;
            state = states.actor;
            failexit = true;
            targetDoor = lastdoorhub;
            image_speed = 0.35;
            image_index = 0;
            sprite_index = get_charactersprite("spr_bubble");
        }
    }
    
    with (obj_camera)
        gateactivate = 0;
    
    room_goto(targetRoom);
    
    if (!instance_exists(obj_exitbubble))
    {
        with (obj_player1)
        {
            state = states.comingoutdoor;
            sprite_index = get_charactersprite("spr_walkfront");
            image_index = 0;
        }
    }
    else
    {
        scr_playerreset();
        obj_player.failexit = true;
        playerendedit = 1;
        global.leveltosave = noone;
    }
    
    circlein = 0;
    circleout = 1;
}
else
{
    with (obj_player1)
    {
        targetDoor = lastdoorhub;
        targetRoom = lasthub;
        scr_playerreset();
        state = states.comingoutdoor;
        room_goto(targetRoom);
    }
    
    circlein = false;
    circleout = true;
}
