image_xscale = playerid.xscale;
x = playerid.x;
y = playerid.y;

if ((playerid.image_index > 3 || playerid.state != 12) && (playerid.state != states.handstandjump && playerid.state != 9) && playerid.state != states.zombieattack)
    instance_destroy();
