x = playerid.x;
y = playerid.y;

with (playerid)
{
    if (state != states.grab)
        instance_destroy(other.id);
}
