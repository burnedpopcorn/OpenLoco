with (obj_player)
{
    if (other.image_yscale == 1)
    {
        if (((key_down && (!place_meeting(x, y + 1, obj_destructibles) && (place_meeting(x, y + 1, other.id) && ((state == states.crouch || character == "S") || state == states.machroll)))) || ((state == states.crouchslide || (state == states.tumble && sprite_index != get_charactersprite("spr_tumble")) || (state == states.freefall || state == states.freefallland)) && (!place_meeting(x, y + 1, obj_destructibles) && place_meeting(x, y + 1, other.id)))) && (!instance_exists(obj_fadeout) && (state != states.door && (state != states.comingoutdoor && ((obj_player1.spotlight == 1 && object_index == obj_player1) || (obj_player1.spotlight == 0 && object_index == obj_player2))))))
        {
            other.depth = -10;
            obj_player1.box = 1;
            obj_player2.box = 1;
            mach2 = 0;
            obj_camera.chargecamera = 0;
            x = other.x;
            obj_player1.targetDoor = other.targetDoor;
            obj_player1.targetRoom = other.targetRoom;
            obj_player2.targetDoor = other.targetDoor;
            obj_player2.targetRoom = other.targetRoom;
            
            if (global.coop == 1)
            {
                fmod_studio_event_instance_start(other.pizzabox_sound);
                obj_player1.x = other.x;
                obj_player2.x = other.x;
                
                if (obj_player1.spotlight == 1)
                    obj_player2.y = obj_player1.y;
                
                if (obj_player1.spotlight == 0)
                    obj_player1.y = obj_player2.y;
                
                obj_player1.sprite_index = get_charactersprite("spr_downpizzabox", obj_player1);
                obj_player1.image_index = 0;
                obj_player1.state = states.door;
                obj_player2.sprite_index = get_charactersprite("spr_downpizzabox", obj_player2);
                obj_player2.image_index = 0;
                obj_player2.state = states.door;
            }
            else
            {
                fmod_studio_event_instance_start(other.pizzabox_sound);
                sprite_index = get_charactersprite("spr_downpizzabox");
                
                if (state == states.freefall)
                {
                    fmod_studio_event_instance_set_pitch(other.pizzabox_sound, 1.25);
                    image_index = sprite_get_number(get_charactersprite("spr_downpizzabox")) * 0.75;
                }
                else
                {
                    fmod_studio_event_instance_set_pitch(other.pizzabox_sound, 1);
                    image_index = 0;
                }
                
                state = states.door;
            }
        }
    }
    
    if (other.image_yscale == -1)
    {
        if (((key_up && (!place_meeting(x, y - 1, obj_destructibles) && (place_meeting(x, y - 1, other.id) && (state == states.normal || (state == states.jump || (state == states.mach1 || (state == states.mach2 || (state == states.mach3 || state == states.Sjumpprep)))))))) || ((state == states.Sjump || state == states.Sjumpland) && (!place_meeting(x, y - 1, obj_destructibles) && place_meeting(x, y - 1, other.id)))) && (!instance_exists(obj_fadeout) && (state != states.door && (state != states.comingoutdoor && ((obj_player1.spotlight == 1 && object_index == obj_player1) || (obj_player1.spotlight == 0 && object_index == obj_player2))))))
        {
            fmod_studio_event_instance_set_pitch(other.pizzabox_sound, 1);
            fmod_studio_event_instance_start(other.pizzabox_sound);
            other.depth = -10;
            obj_player1.box = 1;
            obj_player2.box = 1;
            other.depth = -8;
            mach2 = 0;
            obj_camera.chargecamera = 0;
            x = other.x;
            obj_player1.targetDoor = other.targetDoor;
            obj_player1.targetRoom = other.targetRoom;
            obj_player2.targetDoor = other.targetDoor;
            obj_player2.targetRoom = other.targetRoom;
            
            if (global.coop == 1)
            {
                obj_player1.x = other.x;
                obj_player2.x = other.x;
                
                if (obj_player1.spotlight == 1)
                    obj_player2.y = obj_player1.y;
                
                if (obj_player1.spotlight == 0)
                    obj_player1.y = obj_player2.y;
                
                obj_player1.sprite_index = get_charactersprite("spr_uppizzabox", obj_player1);
                obj_player1.image_index = 0;
                obj_player1.state = states.door;
                obj_player2.sprite_index = get_charactersprite("spr_uppizzabox", obj_player2);
                obj_player2.image_index = 0;
                obj_player2.state = states.door;
            }
            else
            {
                sprite_index = get_charactersprite("spr_uppizzabox");
                image_index = 0;
                state = states.door;
            }
        }
    }
}

if (place_meeting(x, y + 1, obj_doorA) || place_meeting(x, y - 1, obj_doorA))
    targetDoor = "A";

if (place_meeting(x, y + 1, obj_doorB) || place_meeting(x, y - 1, obj_doorB))
    targetDoor = "B";

if (place_meeting(x, y + 1, obj_doorC) || place_meeting(x, y - 1, obj_doorC))
    targetDoor = "C";

if (place_meeting(x, y + 1, obj_doorD) || place_meeting(x, y - 1, obj_doorD))
    targetDoor = "D";

if (place_meeting(x, y + 1, obj_doorE) || place_meeting(x, y - 1, obj_doorE))
    targetDoor = "E";
