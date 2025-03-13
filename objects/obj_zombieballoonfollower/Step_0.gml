if ((obj_player1.x > (x - 300) && obj_player1.x < (x + 300)) && (y <= (obj_player1.y + 300) && y >= (obj_player1.y - 300)))
{
    if (!instance_exists(obj_zombiefollow))
    {
        instance_create(x, y, obj_zombiefollow);
        fmod_studio_event_oneshot_3d("event:/sfx/level_structure/collects/plushie");
    }
    
    instance_destroy();
}
