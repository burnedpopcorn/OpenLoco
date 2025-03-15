with (obj_player1)
{
    visible = true;
    TUx = 20;
    TUy = 20;
    instance_destroy(obj_fadeout);
    targetDoor = "A";
    room = timesuproom;
    state = states.timesup;
    image_speed = 0.35;
    sprite_index = get_charactersprite("spr_timesup");
    image_index = 0;
    fmod_studio_event_oneshot("event:/music/level_structure/timesup");
    fmod_studio_event_instance_kill(obj_marx.laser_sound_instance);
    
    with (global.music)
    {
        fmod_studio_event_instance_stop(event_instance, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
        fmod_studio_event_instance_stop(secret_event_instance, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    }
}

instance_destroy();
