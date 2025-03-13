image_xscale = playerid.xscale;
image_angle = playerid.angle;

if (blink_buffer > 0)
    blink_buffer--;
else
    blink_buffer = irandom(8);

if (playerid.state != states.mach3)
    instance_destroy();

x = playerid.x;
y = playerid.y;
