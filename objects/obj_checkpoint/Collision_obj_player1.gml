if (!active)
{
    fmod_studio_event_oneshot_3d("event:/sfx/level_structure/collects/plushie");
    active = 1;
    
    with (obj_player)
    {
        roomstartx = other.x + 6;
        roomstarty = other.y - 46;
    }
}
