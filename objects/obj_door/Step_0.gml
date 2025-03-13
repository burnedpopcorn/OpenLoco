if (visited == 1 && sprite_index == spr_doorunvisited)
    sprite_index = spr_doorvisited;

if (instance_exists(obj_noisesatellite))
    sprite_index = spr_doorblocked;

if (room != rm_treasure)
{
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
}
else
{
    targetDoor = global.treasurelastdoor;
    targetRoom = global.treasurelastroom;
}
