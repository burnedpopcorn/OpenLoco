with (obj_player1)
{
    if (place_meeting(x, y, other.id))
    {
        if (state != UnknownEnum.Value_27 && (state != UnknownEnum.Value_24 && (state != 11 && (state != 15 && (state != 13 && (state != UnknownEnum.Value_25 && (state != UnknownEnum.Value_18 && state != states.hurt)))))))
        {
            instance_destroy(other.id);
            global.key_inv = 1;
            key_particles = 1;
            alarm[7] = 30;
            fmod_studio_event_oneshot_3d("event:/sfx/level_structure/keyget");
            obj_player1.state = states.keyget;
            obj_player1.image_index = 0;
        }
    }
}

with (obj_player2)
{
    if (place_meeting(x, y, other.id))
    {
        if (state != UnknownEnum.Value_27 && (state != UnknownEnum.Value_24 && (state != 11 && (state != 15 && (state != 13 && (state != UnknownEnum.Value_25 && (state != UnknownEnum.Value_18 && state != states.hurt)))))))
        {
            instance_destroy(other.id);
            global.key_inv = 1;
            key_particles = 1;
            alarm[7] = 30;
            obj_player2.state = states.keyget;
            obj_player2.image_index = 0;
            fmod_studio_event_oneshot_3d("event:/sfx/level_structure/keyget");
        }
    }
}
