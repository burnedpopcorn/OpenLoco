if ((obj_player1.state == states.normal || (obj_player1.state == states.mach1 || (obj_player1.state == states.mach2 || (obj_player1.state == states.mach3 || obj_player1.state == states.Sjumpprep)))) && (sprite_index == spr_doorkey && (obj_player1.key_up && (global.key_inv == 1 && place_meeting(x, y, obj_player1)))))
{
    ds_list_add(global.saveroom, id);
    obj_player1.state = states.victory;
    obj_player1.image_index = 0;
    
    if (instance_exists(obj_player2) && global.coop == 1)
    {
        obj_player2.x = obj_player1.x;
        obj_player2.y = obj_player1.y;
        obj_player2.state = states.victory;
        obj_player2.image_index = 0;
    }
    
    image_index = 0;
    sprite_index = spr_doorkeyopen;
    image_speed = 0.35;
    instance_create(x + 50, y + 50, obj_lock);
    global.key_inv = 0;
}

if (obj_player1.state == states.victory && place_meeting(x, y, obj_player1))
{
    with (obj_player1)
        x = lerp(x, other.x + 50, 0.2);
}

if (obj_player1.state == states.door && place_meeting(x, y, obj_player1))
{
    with (obj_player1)
        x = lerp(x, other.x + 50, min(1, image_index / (image_number - 2)));
}

if (instance_exists(obj_player2))
{
    if (obj_player2.state == states.normal && (obj_player2.key_up && (global.key_inv == 1 && place_meeting(x, y, obj_player2))))
    {
        ds_list_add(global.saveroom, id);
        obj_player2.state = states.victory;
        obj_player2.image_index = 0;
        obj_player1.x = obj_player2.x;
        obj_player1.y = obj_player2.y;
        obj_player1.state = states.victory;
        obj_player1.image_index = 0;
        image_index = 0;
        sprite_index = spr_doorkeyopen;
        image_speed = 0.35;
        instance_create(x + 50, y + 50, obj_lock);
        global.key_inv = 0;
    }
}

with (obj_player)
{
    if (place_meeting(x, y, obj_keydoor) && (other.sprite_index == spr_doorvisited && (key_up && ((state == states.normal || (state == states.mach1 || (state == states.mach2 || state == states.mach3))) && (y == (other.y + 50) && (!instance_exists(obj_noisesatellite) && (!instance_exists(obj_fadeout) && (state != states.door && (state != states.victory && state != states.comingoutdoor)))))))))
    {
        fmod_studio_event_oneshot("event:/sfx/transitions/fade");
        mach2 = 0;
        image_index = 0;
        obj_camera.chargecamera = 0;
        obj_player1.sprite_index = get_charactersprite("spr_lookdoor", obj_player1);
        obj_player1.targetDoor = other.targetDoor;
        obj_player1.targetRoom = other.targetRoom;
        DoorID = other.id;
        obj_player1.image_index = 0;
        obj_player1.state = states.door;
        obj_player1.mach2 = 0;
        
        if (instance_exists(obj_player2) && global.coop == 1)
        {
            obj_player2.sprite_index = get_charactersprite("spr_lookdoor", obj_player2);
            obj_player2.targetDoor = other.targetDoor;
            obj_player2.targetRoom = other.targetRoom;
            obj_player2.image_index = 0;
            obj_player2.state = states.door;
            obj_player2.mach2 = 0;
        }
        
        state = states.door;
        instance_create(x, y, obj_fadeout);
    }
}

if (floor(image_index) == 2)
    image_speed = 0;

if (floor(obj_player1.image_index) == (obj_player1.image_number - 1) && obj_player1.state == states.victory)
{
    with (obj_player1)
    {
        obj_player1.targetDoor = other.targetDoor;
        obj_player1.targetRoom = other.targetRoom;
        
        if (instance_exists(obj_player2) && global.coop == 1)
        {
            obj_player2.targetDoor = other.targetDoor;
            obj_player2.targetRoom = other.targetRoom;
        }
        
        if (!instance_exists(obj_fadeout))
            instance_create(x, y, obj_fadeout);
    }
}

if (place_meeting(x, y, obj_doorA))
    targetDoor = "A";

if (place_meeting(x, y, obj_doorB))
    targetDoor = "B";

if (place_meeting(x, y, obj_doorC))
    targetDoor = "C";

if (place_meeting(x, y, obj_doorD))
    targetDoor = "D";

if (place_meeting(x, y, obj_doorE))
    targetDoor = "E";
