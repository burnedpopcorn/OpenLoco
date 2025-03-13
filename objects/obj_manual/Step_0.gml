if (obj_player.key_right2 && i < 12)
{
    i += 1;
    fmod_studio_event_oneshot("event:/sfx/player/step");
}

if (-obj_player.key_left2 && i > 0)
{
    i -= 1;
    fmod_studio_event_oneshot("event:/sfx/player/step");
}

if (obj_player.key_slap2 || (keyboard_check_pressed(vk_f5) || obj_player.key_start))
{
    instance_destroy();
    obj_mainmenuselect.selected = 0;
}
