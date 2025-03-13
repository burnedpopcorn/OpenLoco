if (instance_exists(player) && player.state != states.backbreaker)
    instance_destroy();

x = player.x;
y = player.y;
image_xscale = player.xscale;
