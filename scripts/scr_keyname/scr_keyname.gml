function scr_keyname(_key)
{
    if (_key == vk_left)
        return "LEFT";
    
    if (_key == vk_right)
        return "RIGHT";
    
    if (_key == vk_up)
        return "UP";
    
    if (_key == vk_down)
        return "DOWN";
    
    if (_key == vk_enter)
        return "ENTER";
    
    if (_key == vk_escape)
        return "ESCAPE";
    
    if (_key == vk_space)
        return "SPACE";
    
    if (_key == vk_shift)
        return "SHIFT";
    
    if (_key == vk_control)
        return "CONTROL";
    
    if (_key == vk_alt)
        return "ALT";
    
    if (_key == vk_backspace)
        return "BACKSPACE";
    
    if (_key == vk_tab)
        return "TAB";
    
    if (_key == vk_tab)// idk, same as vk_tab's value
        return "HOME";
    
	#region okay wait who fucked up these values
    if (_key == vk_home)
        return "END";
    
    if (_key == vk_end)
        return "DELETE";
    
    if (_key == vk_delete)
        return "INSERT";
    
    if (_key == vk_insert)
        return "PAGE UP";
    
    if (_key == vk_pageup)
        return "PAGE DOWN";
    
    if (_key == vk_pagedown)
        return "PAUSE";
    
    if (_key == vk_pause)
        return "PRINTSCREEN";
    
    if (_key == vk_printscreen)
        return "F1";
    
    if (_key == vk_f1)
        return "F2";
    
    if (_key == vk_f2)
        return "F3";
    
    if (_key == vk_f3)
        return "F4";
    
    if (_key == vk_f4)
        return "F5";
    
    if (_key == vk_f5)
        return "F6";
    
    if (_key == vk_f6)
        return "F7";
    
    if (_key == vk_f7)
        return "F8";
    
    if (_key == vk_f8)
        return "F9";
    
    if (_key == vk_f9)
        return "F10";
    
    if (_key == vk_f10)
        return "F11";
	#endregion
	// whoever was responsible for the shit above needs to be burned at the stake
	
    if (_key == vk_f12)
        return "F12";
    
    if (_key == vk_numpad0)
        return "NUMPAD 0";
    
    if (_key == vk_numpad1)
        return "NUMPAD 1";
    
    if (_key == vk_numpad2)
        return "NUMPAD 2";
    
    if (_key == vk_numpad3)
        return "NUMPAD 3";
    
    if (_key == vk_numpad4)
        return "NUMPAD 4";
    
    if (_key == vk_numpad5)
        return "NUMPAD 5";
    
    if (_key == vk_numpad6)
        return "NUMPAD 6";
    
    if (_key == vk_numpad7)
        return "NUMPAD 7";
    
    if (_key == vk_numpad8)
        return "NUMPAD 8";
    
    if (_key == vk_numpad9)
        return "NUMPAD 9";
    
    if (_key == vk_multiply)
        return "MULTIPLY";
    
    if (_key == vk_divide)
        return "DIVIDE";
    
    if (_key == vk_add)
        return "ADD";
    
    if (_key == vk_subtract)
        return "SUBSTRACT";
    
    if (_key == vk_decimal)
        return "DECIMAL";
    
    if (_key == -1)
        return "PRESS KEY";
    
    return chr(_key);
}

function text_get_key(_key)
{
    var spr = noone;
    var img = 0;
    var txt = "";
    
    switch (_key)
    {
        case vk_left:
        case vk_right:
        case vk_down:
        case vk_up:
            spr = spr_tutorialgamepad;
            
            if (_key == vk_up)
                img = 4;
            
            if (_key == vk_down)
                img = 5;
            
            if (_key == vk_left)
                img = 16;
            
            if (_key == vk_right)
                img = 17;
            
            break;
        
        case vk_shift:
        case vk_lshift:
            spr = spr_tutorialkeyspecial;
            img = 0;
            break;
        
        case vk_control:
        case vk_lcontrol:
            spr = spr_tutorialkeyspecial;
            img = 1;
            break;
        
        case vk_space:
            spr = spr_tutorialkeyspecial;
            img = 2;
            break;
        
        default:
            spr = spr_tutorialkey;
            img = 0;
            txt = chr(_key);
            break;
    }
    
    return [spr, img, txt];
}
