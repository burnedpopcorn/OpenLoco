function tv_trigger_whitenoise(_prev_state, _speed = 0.25, _override = false, _sprite = get_charactersprite("spr_tvwhitenoise"))
{
    with (obj_tv)
    {
        if (state != TVstates.whitenoise || _override)
        {
            state = TVstates.whitenoise;
            whitenoise_index = 0;
            whitenoise_speed = _speed;
            whitenoise_sprite = _sprite;
        }
        
        previous_state = _prev_state;
    }
}

function tv_trigger_expression(_sprite, _duration, _priority, _anim_spd = 0.35, _usepal = true, _forced = true, _instant = false)
{
    with (obj_tv)
    {
        var _spr = get_charactersprite(_sprite);
        
        if (expression_sprite == _spr)
            exit;
        
        if (state == TVstates.delay && expression_priority > _priority)
        {
            var _info = 
            {
                sprite: _spr,
                duration: _duration,
                prio: _priority,
                anim_speed: _anim_spd,
                usepal: _usepal,
                forced: _forced,
                instant: _instant
            };
            ds_list_add(expression_que, _info);
        }
        else
            expression_sprite = _spr;
        
        if (!_instant)
        {
            tvsprite = expression_sprite;
            tv_trigger_whitenoise(TVstates.delay);
        }
        else
        {
            tvsprite = expression_sprite;
            sprite_index = tvsprite;
            state = TVstates.delay;
        }
        
        usepalette = _usepal;
        expression_forced = _forced;
        expression_time = _duration;
        return _spr;
    }
}

function tv_turnoff()
{
    with (obj_tv)
    {
        state = TVstates.start;
        sprite_index = get_charactersprite("spr_tvoff");
    }
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
                    var b2 = tvprompts_list[| i];
                    
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
            state = TVstates.maintv;
    }
}

function tv_push_prompt_array(_tv_array)
{
    for (var i = 0; i < array_length(_tv_array); i++)
    {
        with (obj_tv)
        {
            var b = _tv_array[i];
            tv_push_prompt(b[0], b[1], b[2], b[3]);
        }
    }
}

function tv_default_condition()
{
    return place_meeting(x, y, obj_player);
}
