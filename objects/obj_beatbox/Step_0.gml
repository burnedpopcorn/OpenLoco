if (!fmod_studio_event_instance_is_playing(music))
    fmod_studio_event_instance_start(music);

if (obj_player1.sprite_index != get_charactersprite("spr_breakdance"))
{
    instance_create(x, y, obj_genericpoofeffect);
    instance_destroy();
}

scr_collision();
