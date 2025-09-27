function scr_reset_input()
{
    key_up = 0;
    key_up2 = 0;
    key_right = 0;
    key_right2 = 0;
    key_left = 0;
    key_left2 = 0;
    key_down = 0;
    key_down2 = 0;
    key_jump = 0;
    key_jump2 = 0;
    key_slap = 0;
    key_slap2 = 0;
    key_taunt = 0;
    key_taunt2 = 0;
    key_attack = 0;
    key_attack2 = 0;
    key_shoot = 0;
    key_shoot2 = 0;
    key_start = 0;
    key_escape = 0;
    key_special = 0;
    key_special2 = 0;
}

function scr_getinput()
{
    key_up = 0;
    key_up2 = 0;
    key_right = 0;
    key_right2 = 0;
    key_left = 0;
    key_left2 = 0;
    key_down = 0;
    key_down2 = 0;
    key_jump = 0;
    key_jump2 = 0;
    key_slap = 0;
    key_slap2 = 0;
    key_taunt = 0;
    key_taunt2 = 0;
    key_attack = 0;
    key_attack2 = 0;
    key_shoot = 0;
    key_shoot2 = 0;
    key_start = 0;
    key_escape = 0;
    key_special = 0;
    key_special2 = 0;
    
    if (instance_exists(obj_shell) && obj_shell.isOpen == true)
        exit;
    
    gamepad_set_axis_deadzone(1, 0.4);
    var _dvc = obj_inputAssigner.player_input_device[0];
    gamepad_set_axis_deadzone(_dvc, 0.4);
    key_up = input_check("key_up", _dvc) || gamepad_axis_value(_dvc, gp_axislv) < 0;
    key_up2 = input_check2("key_up", _dvc) || (gamepad_axis_value(_dvc, gp_axislv) < -0.5 && stickpressed == 0);
    key_right = input_check("key_right", _dvc) || gamepad_axis_value(_dvc, gp_axislh) > 0;
    key_right2 = input_check2("key_right", _dvc) || (gamepad_axis_value(_dvc, gp_axislh) > 0.5 && stickpressed == 0);
    key_left = -(input_check("key_left", _dvc) || gamepad_axis_value(_dvc, gp_axislh) < 0);
    key_left2 = -(input_check2("key_left", _dvc) || (gamepad_axis_value(_dvc, gp_axislh) < -0.5 && stickpressed == 0));
    key_down = input_check("key_down", _dvc) || gamepad_axis_value(_dvc, gp_axislv) > 0;
    key_down2 = input_check2("key_down", _dvc) || (gamepad_axis_value(_dvc, gp_axislv) > 0.5 && stickpressed == 0);
    key_jump = input_check2("key_jump", _dvc);
    key_jump2 = input_check("key_jump", _dvc);
    key_slap = input_check("key_slap", _dvc);
    key_slap2 = input_check2("key_slap", _dvc);
    key_taunt = input_check("key_taunt", _dvc);
    key_taunt2 = input_check2("key_taunt", _dvc);
    key_attack = input_check("key_attack", _dvc) || gamepad_button_check(_dvc, gp_shoulderrb);
    key_attack2 = input_check2("key_attack", _dvc) || gamepad_button_check_pressed(_dvc, gp_shoulderrb);
    key_shoot = input_check("key_shoot", _dvc);
    key_shoot2 = input_check2("key_shoot", _dvc);
    key_special = input_check("key_special", _dvc);
    key_special2 = input_check2("key_special", _dvc);
    key_start = input_check2("key_start", _dvc);
    key_escape = keyboard_check_pressed(vk_escape) || gamepad_button_check(_dvc, gp_select);
    
    if (gamepad_axis_value(_dvc, gp_axislh) > 0.5 || gamepad_axis_value(_dvc, gp_axislh) < -0.5 || gamepad_axis_value(_dvc, gp_axislv) > 0.5 || gamepad_axis_value(_dvc, gp_axislv) < -0.5)
        stickpressed = 1;
    else
        stickpressed = 0;
    
    if (object_index == obj_player1 && state == 99)
    {
        var haxis = gamepad_axis_value(_dvc, gp_axislh);
        var vaxis = gamepad_axis_value(_dvc, gp_axislv);
        
        if (haxis != 0 || vaxis != 0)
        {
            var _dir = point_direction(0, 0, haxis, vaxis);
            trace(_dir);
            var _deadzone = 5;
            
            if (_dir >= _deadzone && _dir <= (180 - _deadzone))
                key_up = 1;
        }
    }
}

function input_check2(argument0, argument1)
{
    if (argument1 == 1)
        argument0 += "N";
    
    return keyboard_check_pressed(variable_global_get(argument0)) || gamepad_button_check_pressed(argument1, variable_global_get(argument0 + "C"));
}

function input_check(argument0, argument1)
{
    if (argument1 == 1)
        argument0 += "N";
    
    return keyboard_check(variable_global_get(argument0)) || gamepad_button_check(argument1, variable_global_get(argument0 + "C"));
}
