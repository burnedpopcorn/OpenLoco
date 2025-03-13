function txr_parse(argument0)
{
    var str = argument0;
    var len = string_length(str);
    var out = global.txr_parse_tokens_val;
    ds_list_clear(out);
    var pos = 1;
    var line_start = 1;
    var line_number = 0;
    
    while (pos <= len)
    {
        var start = pos;
        var inf = (line_number * 32000) + clamp(pos - line_start, 0, 31999);
        var char = string_ord_at(str, pos);
        pos += 1;
        
        switch (char)
        {
            case 32:
            case 9:
            case 13:
                break;
            
            case 10:
                line_number++;
                line_start = pos;
                break;
            
            case 59:
                ds_list_add(out, [UnknownEnum.Value_18, inf]);
                break;
            
            case 58:
                ds_list_add(out, [UnknownEnum.Value_28, inf]);
                break;
            
            case 40:
                ds_list_add(out, [UnknownEnum.Value_2, inf]);
                break;
            
            case 41:
                ds_list_add(out, [UnknownEnum.Value_3, inf]);
                break;
            
            case 123:
                ds_list_add(out, [UnknownEnum.Value_11, inf]);
                break;
            
            case 125:
                ds_list_add(out, [UnknownEnum.Value_12, inf]);
                break;
            
            case 44:
                ds_list_add(out, [UnknownEnum.Value_6, inf]);
                break;
            
            case 43:
                switch (string_ord_at(str, pos))
                {
                    case 61:
                        pos += 1;
                        ds_list_add(out, [UnknownEnum.Value_13, inf, UnknownEnum.Value_16]);
                        break;
                    
                    case 43:
                        pos += 1;
                        ds_list_add(out, [UnknownEnum.Value_32, inf, 1]);
                        break;
                    
                    default:
                        ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_16]);
                }
                
                break;
            
            case 45:
                switch (string_ord_at(str, pos))
                {
                    case 61:
                        pos += 1;
                        ds_list_add(out, [UnknownEnum.Value_13, inf, UnknownEnum.Value_17]);
                        break;
                    
                    case 45:
                        pos += 1;
                        ds_list_add(out, [UnknownEnum.Value_32, inf, -1]);
                        break;
                    
                    default:
                        ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_17]);
                }
                
                break;
            
            case 42:
                if (string_ord_at(str, pos) == 61)
                {
                    pos += 1;
                    ds_list_add(out, [UnknownEnum.Value_13, inf, UnknownEnum.Value_1]);
                }
                else
                {
                    ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_1]);
                }
                
                break;
            
            case 47:
                switch (string_ord_at(str, pos))
                {
                    case 61:
                        pos += 1;
                        ds_list_add(out, [UnknownEnum.Value_13, inf, UnknownEnum.Value_2]);
                        break;
                    
                    case 47:
                        while (pos <= len)
                        {
                            char = string_ord_at(str, pos);
                            
                            if (char == 13 || char == 10)
                                break;
                            
                            pos += 1;
                        }
                        
                        break;
                    
                    case 42:
                        for (pos += 1; pos <= len; pos += 1)
                        {
                            if (string_ord_at(str, pos) == 42 && string_ord_at(str, pos + 1) == 47)
                            {
                                pos += 2;
                                break;
                            }
                        }
                        
                        break;
                    
                    default:
                        ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_2]);
                }
                
                break;
            
            case 37:
                if (string_ord_at(str, pos) == 61)
                {
                    pos += 1;
                    ds_list_add(out, [UnknownEnum.Value_13, inf, UnknownEnum.Value_3]);
                }
                else
                {
                    ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_3]);
                }
                
                break;
            
            case 33:
                if (string_ord_at(str, pos) == 61)
                {
                    pos += 1;
                    ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_65]);
                }
                else
                {
                    ds_list_add(out, [UnknownEnum.Value_14, inf, UnknownEnum.Value_2]);
                }
                
                break;
            
            case 61:
                if (string_ord_at(str, pos) == 61)
                {
                    pos += 1;
                    ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_64]);
                }
                else
                {
                    ds_list_add(out, [UnknownEnum.Value_13, inf, UnknownEnum.Value_m1]);
                }
                
                break;
            
            case 60:
                switch (string_ord_at(str, pos))
                {
                    case 61:
                        pos += 1;
                        ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_67]);
                        break;
                    
                    case 60:
                        pos += 1;
                        ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_32]);
                        break;
                    
                    default:
                        ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_66]);
                }
                
                break;
            
            case 62:
                switch (string_ord_at(str, pos))
                {
                    case 61:
                        pos += 1;
                        ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_69]);
                        break;
                    
                    case 62:
                        pos += 1;
                        ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_33]);
                        break;
                    
                    default:
                        ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_68]);
                }
                
                break;
            
            case 39:
            case 34:
                while (pos <= len)
                {
                    if (string_ord_at(str, pos) == char)
                        break;
                    
                    pos += 1;
                }
                
                if (pos <= len)
                {
                    pos += 1;
                    ds_list_add(out, [UnknownEnum.Value_10, inf, string_copy(str, start + 1, pos - start - 2)]);
                }
                else
                {
                    return txr_throw("Unclosed string starting", txr_print_pos(inf));
                }
                
                break;
            
            case 124:
                switch (string_ord_at(str, pos))
                {
                    case 124:
                        pos += 1;
                        ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_96]);
                        break;
                    
                    case 61:
                        pos += 1;
                        ds_list_add(out, [UnknownEnum.Value_13, inf, UnknownEnum.Value_49]);
                        break;
                    
                    default:
                        ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_49]);
                }
                
                break;
            
            case 38:
                switch (string_ord_at(str, pos))
                {
                    case 38:
                        pos += 1;
                        ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_80]);
                        break;
                    
                    case 61:
                        pos += 1;
                        ds_list_add(out, [UnknownEnum.Value_13, inf, UnknownEnum.Value_48]);
                        break;
                    
                    default:
                        ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_48]);
                }
                
                break;
            
            case 94:
                if (string_ord_at(str, pos) == 61)
                {
                    pos += 1;
                    ds_list_add(out, [UnknownEnum.Value_13, inf, UnknownEnum.Value_50]);
                }
                else
                {
                    ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_50]);
                }
                
                break;
            
            default:
                if (char >= 48 && char <= 57)
                {
                    var pre_dot = true;
                    
                    while (pos <= len)
                    {
                        char = string_ord_at(str, pos);
                        
                        if (char == 46)
                        {
                            if (pre_dot)
                            {
                                pre_dot = false;
                                pos += 1;
                            }
                            else
                            {
                                break;
                            }
                        }
                        else if (char >= 48 && char <= 57)
                        {
                            pos += 1;
                        }
                        else
                        {
                            break;
                        }
                    }
                    
                    var val = real(string_copy(str, start, pos - start));
                    ds_list_add(out, [UnknownEnum.Value_4, inf, val]);
                    break;
                }
                
                if (char == 95 || (char >= 97 && char <= 122) || (char >= 65 && char <= 90))
                {
                    while (pos <= len)
                    {
                        char = string_ord_at(str, pos);
                        
                        if (char == 95 || (char >= 48 && char <= 57) || (char >= 97 && char <= 122) || (char >= 65 && char <= 90))
                            pos += 1;
                        else
                            break;
                    }
                    
                    var name = string_copy(str, start, pos - start);
                    
                    switch (name)
                    {
                        case "true":
                            ds_list_add(out, [UnknownEnum.Value_4, inf, true]);
                            break;
                        
                        case "false":
                            ds_list_add(out, [UnknownEnum.Value_4, inf, false]);
                            break;
                        
                        case "mod":
                            ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_3]);
                            break;
                        
                        case "div":
                            ds_list_add(out, [UnknownEnum.Value_1, inf, UnknownEnum.Value_4]);
                            break;
                        
                        case "if":
                            ds_list_add(out, [UnknownEnum.Value_8, inf]);
                            break;
                        
                        case "else":
                            ds_list_add(out, [UnknownEnum.Value_9, inf]);
                            break;
                        
                        case "return":
                            ds_list_add(out, [UnknownEnum.Value_7, inf]);
                            break;
                        
                        case "while":
                            ds_list_add(out, [UnknownEnum.Value_15, inf]);
                            break;
                        
                        case "do":
                            ds_list_add(out, [UnknownEnum.Value_16, inf]);
                            break;
                        
                        case "for":
                            ds_list_add(out, [UnknownEnum.Value_17, inf]);
                            break;
                        
                        case "break":
                            ds_list_add(out, [UnknownEnum.Value_19, inf]);
                            break;
                        
                        case "continue":
                            ds_list_add(out, [UnknownEnum.Value_20, inf]);
                            break;
                        
                        case "var":
                            ds_list_add(out, [UnknownEnum.Value_21, inf]);
                            break;
                        
                        case "argument_count":
                            ds_list_add(out, [UnknownEnum.Value_23, inf]);
                            break;
                        
                        case "label":
                            ds_list_add(out, [UnknownEnum.Value_24, inf]);
                            break;
                        
                        case "jump":
                            ds_list_add(out, [UnknownEnum.Value_25, inf]);
                            break;
                        
                        case "call":
                            ds_list_add(out, [UnknownEnum.Value_26, inf]);
                            break;
                        
                        case "back":
                            ds_list_add(out, [UnknownEnum.Value_27, inf]);
                            break;
                        
                        case "select":
                            ds_list_add(out, [UnknownEnum.Value_29, inf]);
                            break;
                        
                        case "option":
                            ds_list_add(out, [UnknownEnum.Value_30, inf]);
                            break;
                        
                        case "default":
                            ds_list_add(out, [UnknownEnum.Value_31, inf]);
                            break;
                        
                        case "switch":
                            ds_list_add(out, [UnknownEnum.Value_33, inf]);
                            break;
                        
                        case "case":
                            ds_list_add(out, [UnknownEnum.Value_34, inf]);
                            break;
                        
                        default:
                            if (string_length(name) > 8 && string_copy(name, 1, 8) == "argument")
                            {
                                var sfx = string_delete(name, 1, 8);
                                
                                if (string_digits(sfx) == sfx)
                                {
                                    ds_list_add(out, [UnknownEnum.Value_22, inf, real(sfx), name]);
                                    break;
                                }
                            }
                            
                            ds_list_add(out, [UnknownEnum.Value_5, inf, name]);
                            break;
                    }
                    
                    break;
                }
                
                ds_list_clear(out);
                return txr_throw("Unexpected character `" + chr(char) + "`", txr_print_pos(inf));
        }
    }
    
    ds_list_add(out, [UnknownEnum.Value_0, string_length(str)]);
    return false;
}
