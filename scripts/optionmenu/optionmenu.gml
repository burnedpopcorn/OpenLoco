#region Menu Functions
function add_option(_type, _data)
{
    array_push(options, 
    {
        type: _type,
        data: _data
    });
}

function add_toggle(_name, _toggle = false)
{
    add_option("toggle", 
    {
        name: _name,
        toggle: _toggle
    });
}

function add_select(_name, _options, _index)
{
    add_option("select", 
    {
        name: _name,
        options: _options,
        index: _index ?? 0
    });
}

function add_button(_name, _func)
{
    pause_options_map[? _name] = {
        name: _name,
        func: _func
    };
}

function add_button2(_name, _callback)
{
    add_option("button", 
    {
        name: _name,
        callback: _callback
    });
}

function add_hr()
{
    add_option("hr", 
    {
        name: undefined
    });
}
#endregion

function optionmenu_render()
{
    draw_set_alpha(1);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(global.bigfont);
    scr_getinput();
    
    if (--activity_buffer > 0)
        key_jump = 0;
    
    var xx = obj_screen.actualWidth / 2;
    var yy = 150;
    
    for (var i = 0; i < array_length(options); i++)
    {
        var opt = options[i];
        var data = opt.data;
        var name = data.name;
        var sel = selected == i;
        draw_set_color(sel ? c_white : c_gray);
        
        switch (opt.type)
        {
            case "toggle":
                var txt = name + " " + (data.toggle ? "YES" : "NO");
                draw_text(xx, yy, txt);
                yy += string_height(txt);
                
                if (sel && key_jump)
                {
                    data.toggle = !data.toggle;
                    fmod_studio_event_oneshot("event:/sfx/enemy/spitprojectile");
                    event_user((object_index == obj_option) ? 1 : 0);
                }
                
                break;
            
            case "select":
                var op = data.options[data.index];
                var txt = name + " " + op;
                draw_text(xx, yy, txt);
                yy += string_height(txt);
                var move = -key_right2 - key_left2;
                
                if (sel && move != 0)
                {
                    data.index = clamp(data.index + move, 0, array_length(data.options) - 1);
                    fmod_studio_event_oneshot("event:/sfx/enemy/spitprojectile");
                    event_user((object_index == obj_option) ? 1 : 0);
                }
                
                break;
            
            case "button":
                draw_text(xx, yy, name);
                yy += string_height(name);
                
                if (sel && key_jump)
                {
                    data.callback();
                    event_user((object_index == obj_option) ? 1 : 0);
                }
                
                break;
            
            case "hr":
                yy += 10;
                draw_rectangle(xx - 100, yy - 1.5, xx + 100, yy + 1.5, false);
                draw_set_color(c_black);
                draw_rectangle(xx - 100, yy - 2.5, xx + 100, yy + 2.5, true);
                yy += 3;
                yy += 10;
                break;
        }
        
        yy += 10;
    }
}

function optionmenu_step()
{
    if (object_index == obj_option)
    {
        if (!active)
        {
            scr_reset_input();
            exit;
        }
    }
    
    scr_getinput();
    var move = key_down2 - key_up2;
    selected += move;
    
    if (move != 0)
    {
        select_sign = sign(move);
        
        if ((select_sign == 1 && selected < (array_length(options) - 1)) || (select_sign == -1 && selected > 0))
        {
            if (options[selected].type == "hr")
                selected += select_sign;
        }
        
        selected = wrap(selected, 0, array_length(options) - 1);
    }
}

function load_options()
{
    ini_open("saveData.ini");
    var ini_language = ini_read_string("Option", "language", "eng");
    var lang_table = 
    {
        esp: 0,
        eng: 1
    };
    global.option_language = variable_struct_get(lang_table, ini_language);
    global.language = ini_language;
    reload_langfile();
    var ini_fullscreen = ini_read_real("Option", "fullscreen", false);
    global.option_fullscreen = ini_fullscreen;
    window_set_fullscreen(global.option_fullscreen);
    ini_resolution = ini_read_real("Option", "resolution", 0);
    window_set_size(array_get(global.resolutionMap[? ini_resolution], 0), array_get(global.resolutionMap[? ini_resolution], 1));
    ini_close();
    trace("load options", global.option_language, global.option_fullscreen, ini_resolution);
}
