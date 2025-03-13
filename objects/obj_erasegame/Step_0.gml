if (!instance_exists(obj_keyconfig))
{
    if ((-obj_player.key_left2 || keyboard_check_pressed(vk_left)) && optionselected > 0)
    {
        optionselected -= 1;
        fmod_studio_event_oneshot("event:/sfx/player/step");
    }
    
    if ((obj_player.key_right2 || keyboard_check_pressed(vk_right)) && optionselected < 1)
    {
        optionselected += 1;
        fmod_studio_event_oneshot("event:/sfx/player/step");
    }
}

if (optionselected == 1 && (obj_player.key_jump || keyboard_check_pressed(vk_enter)))
{
    var str = concat("saves/saveData", filetoerase, ".ini");
    
    if (file_exists(str))
        file_delete(str);
    
    fmod_studio_event_oneshot("event:/sfx/misc/explosion");
    
    if (instance_exists(obj_mainmenuselect))
        obj_mainmenuselect.selected = 0;
    else
        obj_titleselect.optionselect = 0;
    
    if (instance_exists(obj_fileselect))
        instance_destroy(obj_fileselect);
    
    instance_destroy();
}

if ((obj_player.key_slap2 || keyboard_check_pressed(vk_escape)) || (optionselected == 0 && (obj_player.key_jump || keyboard_check_pressed(vk_enter))))
{
    fmod_studio_event_oneshot("event:/sfx/enemy/spitprojectile");
    
    if (instance_exists(obj_mainmenuselect))
        obj_mainmenuselect.selected = 0;
    else
        obj_titleselect.optionselect = 0;
    
    instance_destroy();
}
