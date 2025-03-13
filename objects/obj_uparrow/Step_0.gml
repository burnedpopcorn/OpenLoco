image_speed = 0.35;

with (playerid)
{
    if ((!place_meeting(x, y, obj_dresser) && (!place_meeting(x, y, obj_door) && (!place_meeting(x, y, obj_keydoor) && !place_meeting(x, y, obj_exitgate)))) || (!grounded || state != states.normal))
        instance_destroy(other.id);
}

x = playerid.x;
y = playerid.y - 50;
