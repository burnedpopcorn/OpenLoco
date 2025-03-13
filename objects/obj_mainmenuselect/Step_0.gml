if (selected == 0)
{
    if ((obj_player.key_right2 || keyboard_check_pressed(vk_right)) && optionselected < 3)
    {
        optionselected += 1;
        fmod_studio_event_oneshot("event:/sfx/player/step");
    }
    else if ((-obj_player.key_left2 || keyboard_check_pressed(vk_left)) && optionselected > 0)
    {
        optionselected -= 1;
        fmod_studio_event_oneshot("event:/sfx/player/step");
    }
    
    if ((obj_player.key_jump || keyboard_check_pressed(vk_enter)) && optionselected == 0)
    {
        fmod_studio_event_oneshot("event:/sfx/level_structure/collects/plushie");
        obj_file1.sprite_index = spr_file1confirm;
        selected = 1;
        alarm[0] = 60;
    }
    
    if ((obj_player.key_jump || keyboard_check_pressed(vk_enter)) && optionselected == 1)
    {
        fmod_studio_event_oneshot("event:/sfx/level_structure/collects/plushie");
        selected = 1;
        alarm[1] = 5;
    }
    
    if ((obj_player.key_jump || keyboard_check_pressed(vk_enter)) && optionselected == 2)
    {
        fmod_studio_event_oneshot("event:/sfx/level_structure/collects/plushie");
        selected = 1;
        alarm[2] = 5;
    }
    
    if ((obj_player.key_jump || keyboard_check_pressed(vk_enter)) && optionselected == 3)
    {
        selected = 1;
        alarm[3] = 10;
    }
    
    if (keyboard_check_pressed(vk_f5) && !instance_exists(obj_manual))
    {
        selected = 1;
        instance_create(0, 0, obj_manual);
    }
}

var lay_id = layer_get_id("Backgrounds_2");
var back_id = layer_background_get_id(lay_id);
layer_background_index(back_id, optionselected);
