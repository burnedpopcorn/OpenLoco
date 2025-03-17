if (!place_meeting(x, y, obj_doorblocked))
{
    with (other.id)
    {
        if (key_up && ((state == states.normal || (state == states.mach1 || (state == states.mach2 || (state == states.mach3 || state == states.Sjumpprep)))) && (y == (other.y + 50) && (!instance_exists(obj_noisesatellite) && (!instance_exists(obj_fadeout) && (state != states.door && (state != states.comingoutdoor && ((obj_player1.spotlight == 1 && object_index == obj_player1) || (obj_player1.spotlight == 0 && object_index == obj_player2)))))))))
        {
            lastroom_x = other.x;
            lastroom_y = other.y;
            lastroom = room;
            
            if (other.levelname != "")
                global.leveltosave = other.levelname;
            
            fmod_studio_event_oneshot("event:/sfx/transitions/fade");
            obj_camera.chargecamera = 0;
            ds_list_add(global.saveroom, id);
            
            if (object_index == obj_player1)
                obj_player1.sprite_index = get_charactersprite("spr_lookdoor", obj_player1);
            
            if (object_index == obj_player2)
                obj_player2.sprite_index = get_charactersprite("spr_lookdoor", obj_player2);
            
            obj_player1.targetDoor = other.targetDoor;
            obj_player1.targetRoom = other.targetRoom;
            obj_player2.targetDoor = other.targetDoor;
            obj_player2.targetRoom = other.targetRoom;
            obj_player.image_index = 0;
            obj_player.state = states.door;
            obj_player.mach2 = 0;
            
            if (instance_exists(obj_player2) && global.coop == 1)
            {
                if (object_index == obj_player2)
                {
                    obj_player1.x = obj_player2.x;
                    obj_player1.y = obj_player2.y;
                }
                
                if (object_index == obj_player1)
                {
                    obj_player2.x = obj_player1.x;
                    obj_player2.y = obj_player1.y;
                }
            }
            
            other.visited = 1;
            instance_create(x, y, obj_fadeout);
        }
    }
}

if (obj_player1.state == states.door)
{
    with (obj_player1)
        x = lerp(x, other.x + 50, min(1, image_index / (image_number - 2)));
}
