var _important_objects = [obj_player1, obj_listener, obj_inputAssigner, obj_screen, obj_fmod_studio_manager];

for (var i = 0; i < array_length(_important_objects); i++)
{
    if (!instance_exists(_important_objects[i]))
    {
        alarm[0] = 15;
        exit;
    }
}

room_goto(rm_load);
