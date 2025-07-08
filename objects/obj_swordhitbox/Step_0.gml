image_xscale = playerid.xscale;
x = playerid.x;
y = playerid.y;

if (playerid.state != states.knightpepattack && playerid.state != states.finishingblow)
    instance_destroy();
