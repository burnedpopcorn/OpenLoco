with (other.id)
{
    y = other.y;
    
    if (!instance_exists(obj_fadeout))
    {
        obj_player1.targetDoor = other.targetDoor;
        obj_player1.targetRoom = other.targetRoom;
        obj_player1.vhallway = 1;
        obj_player1.vhallwaydirection = other.image_yscale;
        obj_player1.vhallwayoffset = x - other.x;
        
        if (instance_exists(obj_player2))
        {
            if (object_index == obj_player2)
            {
                obj_player1.x = obj_player2.x;
                obj_player1.y = obj_player2.y;
                obj_player1.state = states.normal;
            }
            
            if (object_index == obj_player1)
            {
                obj_player2.x = obj_player1.x;
                obj_player2.y = obj_player1.y;
                obj_player2.state = states.normal;
            }
            
            obj_player2.targetDoor = other.targetDoor;
            obj_player2.targetRoom = other.targetRoom;
            obj_player2.vhallway = 1;
            obj_player2.vhallwaydirection = other.image_yscale;
        }
        
        other.visited = 1;
        image_index = 0;
        fmod_studio_event_oneshot("event:/sfx/transitions/fade");
        instance_create(x, y, obj_fadeout);
    }
}
