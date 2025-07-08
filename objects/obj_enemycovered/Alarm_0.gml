instance_activate_object(baddieID);

with (baddieID)
{
    x = other.x + 18;
    y = other.y - 18;
    vsp = -6;
    state = states.actor;
    sprite_index = walkspr;
    stunned = 20;
    boundbox = 0;
}

visible = false;
fmod_studio_event_oneshot_3d("event:/sfx/enemy/dig");

repeat (4)
{
    with (create_debris(x + random_range(0, 32), y + random_range(0, 32), spr_debris, 1))
    {
        hsp = random_range(-5, 5);
        vsp = random_range(-10, 10);
        image_speed = 0;
    }
}

dissapear = 1;
