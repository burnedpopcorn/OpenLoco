image_xscale = playerid.xscale;
x = playerid.x;
y = playerid.y;

if (playerid.state != UnknownEnum.Value_25 && playerid.state != 3)
    instance_destroy();
