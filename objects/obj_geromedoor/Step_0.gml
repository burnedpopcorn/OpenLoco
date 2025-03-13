global.treasurelastroom = room;
global.treasurelastdoor = targetDoor;
var rm = targetRoom;
var dr = targetDoor;

with (obj_player)
{
    var canenter = key_up && (state == states.normal || state == states.mach1 || state == states.mach2 || state == states.mach3 || obj_player1.state == states.Sjumpprep);
    var otherPlayer = (object_index == obj_player1) ? obj_player2 : obj_player1;
    
    if (place_meeting(x, y, obj_geromedoor))
    {
        if (grounded && canenter && global.gerome == 1)
        {
            ds_list_add(global.saveroom, other.id);
            state = states.victory;
            image_index = 0;
            sprite_index = get_charactersprite("spr_victory");
            
            if (global.gerome)
            {
                obj_geromefollow.visible = false;
                
                with (instance_create(x - 30, y, obj_geromeanim))
                {
                    sprite_index = spr_gerome_opendoor;
                    image_index = 0;
                    image_speed = 0.35;
                }
                
                state = states.victory;
                
                if (instance_exists(otherPlayer) && global.coop == 1)
                {
                    otherPlayer.x = x;
                    otherPlayer.y = y;
                    otherPlayer.state = states.victory;
                    otherPlayer.image_index = 0;
                    otherPlayer.sprite_index = get_charactersprite("spr_victory");
                }
                
                global.gerome = 0;
            }
            
            other.image_index = 1;
        }
        
        if (!instance_exists(obj_fadeout) && grounded && other.image_index == 1 && (canenter && state != states.door && state != states.victory && state != states.comingoutdoor))
        {
            obj_camera.chargecamera = 0;
            mach2 = 0;
            image_index = 0;
            sprite_index = get_charactersprite("spr_lookdoor");
            targetDoor = dr;
            targetRoom = rm;
            state = states.door;
            
            if (instance_exists(otherPlayer) && global.coop == 1)
            {
                with (otherPlayer)
                {
                    sprite_index = get_charactersprite("spr_lookdoor");
                    targetDoor = dr;
                    targetRoom = rm;
                    image_index = 0;
                    state = states.door;
                    mach2 = 0;
                }
            }
            
            instance_create(0, 0, obj_fadeout);
        }
        
        if (floor(image_index) == (image_number - 1) && state == states.victory)
        {
            targetDoor = dr;
            targetRoom = rm;
            
            if (instance_exists(otherPlayer) && global.coop == 1)
            {
                otherPlayer.targetDoor = dr;
                otherPlayer.targetRoom = rm;
            }
            
            if (!instance_exists(obj_fadeout))
                instance_create(x, y, obj_fadeout);
        }
        
        if (state == states.door && place_meeting(x, y, other))
            x = lerp(x, other.x, min(1, image_index / (image_number - 2)));
        
        if (state == states.victory && place_meeting(x, y, other))
            x = lerp(x, other.x, 0.2);
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
