function scr_keyname(argument0)
{
    if (argument0 == 37)
        return "LEFT";
    
    if (argument0 == 39)
        return "RIGHT";
    
    if (argument0 == 38)
        return "UP";
    
    if (argument0 == 40)
        return "DOWN";
    
    if (argument0 == 13)
        return "ENTER";
    
    if (argument0 == 27)
        return "ESCAPE";
    
    if (argument0 == 32)
        return "SPACE";
    
    if (argument0 == 16)
        return "SHIFT";
    
    if (argument0 == 17)
        return "CONTROL";
    
    if (argument0 == 18)
        return "ALT";
    
    if (argument0 == 8)
        return "BACKSPACE";
    
    if (argument0 == 9)
        return "TAB";
    
    if (argument0 == 9)
        return "HOME";
    
    if (argument0 == 36)
        return "END";
    
    if (argument0 == 35)
        return "DELETE";
    
    if (argument0 == 46)
        return "INSERT";
    
    if (argument0 == 45)
        return "PAGE UP";
    
    if (argument0 == 33)
        return "PAGE DOWN";
    
    if (argument0 == 34)
        return "PAUSE";
    
    if (argument0 == 19)
        return "PRINTSCREEN";
    
    if (argument0 == 44)
        return "F1";
    
    if (argument0 == 112)
        return "F2";
    
    if (argument0 == 113)
        return "F3";
    
    if (argument0 == 114)
        return "F4";
    
    if (argument0 == 115)
        return "F5";
    
    if (argument0 == 116)
        return "F6";
    
    if (argument0 == 117)
        return "F7";
    
    if (argument0 == 118)
        return "F8";
    
    if (argument0 == 119)
        return "F9";
    
    if (argument0 == 120)
        return "F10";
    
    if (argument0 == 121)
        return "F11";
    
    if (argument0 == 123)
        return "F12";
    
    if (argument0 == 96)
        return "NUMPAD 0";
    
    if (argument0 == 97)
        return "NUMPAD 1";
    
    if (argument0 == 98)
        return "NUMPAD 2";
    
    if (argument0 == 99)
        return "NUMPAD 3";
    
    if (argument0 == 100)
        return "NUMPAD 4";
    
    if (argument0 == 101)
        return "NUMPAD 5";
    
    if (argument0 == 102)
        return "NUMPAD 6";
    
    if (argument0 == 103)
        return "NUMPAD 7";
    
    if (argument0 == 104)
        return "NUMPAD 8";
    
    if (argument0 == 105)
        return "NUMPAD 9";
    
    if (argument0 == 106)
        return "MULTIPLY";
    
    if (argument0 == 111)
        return "DIVIDE";
    
    if (argument0 == 107)
        return "ADD";
    
    if (argument0 == 109)
        return "SUBSTRACT";
    
    if (argument0 == 110)
        return "DECIMAL";
    
    if (argument0 == -1)
        return "PRESS KEY";
    
    return chr(argument0);
}

function text_get_key(argument0)
{
    var spr = -4;
    var img = 0;
    var txt = "";
    
    switch (argument0)
    {
        case 37:
        case 39:
        case 40:
        case 38:
            spr = spr_tutorialgamepad;
            
            if (argument0 == 38)
                img = 4;
            
            if (argument0 == 40)
                img = 5;
            
            if (argument0 == 37)
                img = 16;
            
            if (argument0 == 39)
                img = 17;
            
            break;
        
        case 16:
        case 160:
            spr = spr_tutorialkeyspecial;
            img = 0;
            break;
        
        case 17:
        case 162:
            spr = spr_tutorialkeyspecial;
            img = 1;
            break;
        
        case 32:
            spr = spr_tutorialkeyspecial;
            img = 2;
            break;
        
        default:
            spr = spr_tutorialkey;
            img = 0;
            txt = chr(argument0);
            break;
    }
    
    return [spr, img, txt];
}
