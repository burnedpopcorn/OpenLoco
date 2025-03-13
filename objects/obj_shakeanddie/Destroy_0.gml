with (instance_create(x, y, obj_sausageman_dead))
{
    fmod_studio_event_oneshot_3d("event:/sfx/player/misc/kill");
    sprite_index = other.sprite_index;
    image_xscale = other.image_xscale;
}

instance_destroy();
