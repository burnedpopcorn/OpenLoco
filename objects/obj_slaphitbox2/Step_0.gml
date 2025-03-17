image_xscale = playerid.xscale;
x = playerid.x;
y = playerid.y;

if (playerid.image_index > 3 || playerid.state != states.unknown12)
    instance_destroy();
