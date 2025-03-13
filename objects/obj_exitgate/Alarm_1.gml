fmod_studio_event_oneshot_3d("event:/sfx/player/bodyslam_land");

with (obj_camera)
{
    shake_mag = 10;
    shake_mag_acc = 30 / room_speed;
}

obj_player.visible = false;
image_index = 0;
alarm[0] = 100;
