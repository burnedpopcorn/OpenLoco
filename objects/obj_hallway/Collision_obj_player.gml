with (other.id)
{
    x = other.x;
    y = other.y + (other.sprite_height - 46);
    var fadeout = (obj_player1.spotlight == 1) ? (object_index == obj_player1) : (object_index == obj_player2);
    
    if (fadeout)
    {
        if (!instance_exists(obj_fadeout))
        {
            var p = [obj_player1];
            
            if (instance_exists(obj_player2))
                array_push(p, obj_player2);
            
            for (var i = 0; i < array_length(p); i++)
            {
                p[i].targetDoor = other.targetDoor;
                p[i].targetRoom = other.targetRoom;
                p[i].hallway = 1;
                p[i].hallwaydirection = other.image_xscale;
            }
            
            other.visited = 1;
            image_index = 0;
            
            if (state == states.machslide)
                state = states.normal;
            
            fmod_studio_event_oneshot("event:/sfx/transitions/fade");
            instance_create(x, y, obj_fadeout);
        }
    }
}
