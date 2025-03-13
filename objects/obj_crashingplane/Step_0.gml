if (y > 600 && !sound_played)
{
    fmod_studio_event_oneshot("event:/sfx/misc/planecrash");
    sound_played = true;
}

if (y > 750)
{
    instance_destroy();
    instance_create(x, y, obj_crashplanescreen);
}
