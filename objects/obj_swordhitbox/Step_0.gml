image_xscale = playerid.xscale;
x = playerid.x;
y = playerid.y;

if (playerid.state != states.unknown25 && playerid.state != states.finishingblow)
    instance_destroy();
