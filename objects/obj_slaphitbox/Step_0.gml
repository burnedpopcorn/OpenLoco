image_xscale = playerid.xscale;
x = playerid.x;
y = playerid.y;

if ((playerid.image_index > 3 || playerid.state != states.unknown12) && (playerid.state != states.handstandjump && playerid.state != states.hookshot) && playerid.state != states.zombieattack)
    instance_destroy();
