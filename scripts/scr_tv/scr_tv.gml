function tv_trigger_whitenoise(argument0, argument1 = 0.25, argument2 = false, argument3 = get_charactersprite("spr_tvwhitenoise"))
{
    with (obj_tv)
    {
        if (state != UnknownEnum.Value_1 || argument2)
        {
            state = UnknownEnum.Value_1;
            whitenoise_index = 0;
            whitenoise_speed = argument1;
            whitenoise_sprite = argument3;
        }
        
        previous_state = argument0;
    }
}

function tv_trigger_expression(argument0, argument1, argument2, argument3 = 0.35, argument4 = true, argument5 = true, argument6 = false)
{
    with (obj_tv)
    {
        var _spr = get_charactersprite(argument0);
        
        if (expression_sprite == _spr)
            exit;
        
        if (state == states.tumble && expression_priority > argument2)
        {
            var _info = 
            {
                sprite: _spr,
                duration: argument1,
                prio: argument2,
                anim_speed: argument3,
                usepal: argument4,
                forced: argument5,
                instant: argument6
            };
            ds_list_add(expression_que, _info);
        }
        else
        {
            expression_sprite = _spr;
        }
        
        if (!argument6)
        {
            tvsprite = expression_sprite;
            tv_trigger_whitenoise(UnknownEnum.Value_2);
        }
        else
        {
            tvsprite = expression_sprite;
            sprite_index = tvsprite;
            state = states.tumble;
        }
        
        usepalette = argument4;
        expression_forced = argument5;
        expression_time = argument1;
        return _spr;
    }
}

function tv_turnoff()
{
    with (obj_tv)
    {
        state = states.finishingblow;
        sprite_index = get_charactersprite("spr_tvoff");
    }
    
    exit;
}

function tv_create_prompt(argument0, argument1, argument2, argument3)
{
    return [argument0, argument1, argument2, argument3];
}

function tv_push_prompt(argument0, argument1, argument2, argument3)
{
    with (obj_tv)
    {
        var b = [argument0, argument1, argument2, argument3];
        var play = 0;
        
        switch (argument1)
        {
            case 0:
                play = 1;
                ds_list_insert(tvprompts_list, 0, b);
                break;
            
            case 1:
                var placed = 0;
                var i = 0;
                
                while (i < ds_list_size(tvprompts_list))
                {
                    var b2 = ds_list_find_value(tvprompts_list, i);
                    
                    if (b2[1] == 2)
                    {
                        if (i == 0)
                            play = 1;
                        
                        ds_list_insert(tvprompts_list, i, b);
                        placed = 1;
                        break;
                    }
                    else
                    {
                        i++;
                        continue;
                    }
                }
                
                if (!placed)
                    ds_list_add(tvprompts_list, b);
                
                break;
            
            case 2:
                ds_list_add(tvprompts_list, b);
                break;
                break;
                continue;
        }
        
        if (play)
            state = 0;
    }
    
    exit;
}

function tv_push_prompt_array(argument0)
{
    var i = 0;
    var b = 0;
    
    for (i = 0; i < array_length(argument0); i++)
    {
        with (obj_tv)
        {
            b = argument0[i];
            tv_push_prompt(b[0], b[1], b[2], b[3]);
        }
    }
    
    exit;
}

function tv_default_condition()
{
    return place_meeting(x, y, obj_player);
}
