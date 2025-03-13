function txr_build_expr(argument0)
{
    var flags = argument0;
    var tk = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val++);
    
    switch (tk[0])
    {
        case UnknownEnum.Value_4:
            global.txr_build_node_val = [UnknownEnum.Value_1, tk[1], tk[2]];
            break;
        
        case UnknownEnum.Value_10:
            global.txr_build_node_val = [UnknownEnum.Value_11, tk[1], tk[2]];
            break;
        
        case UnknownEnum.Value_5:
            var tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
            
            if (tkn[0] == UnknownEnum.Value_2)
            {
                global.txr_build_pos_val += 1;
                var args = [];
                var argc = 0;
                var fn = ds_map_find_value(global.txr_function_map, array_get(tk, 2));
                var fn_argc, fn_script;
                
                if (fn == undefined)
                {
                    fn_script = global.txr_function_default_val;
                    
                    if (fn_script != -1)
                    {
                        fn_argc = -1;
                        args[argc++] = [UnknownEnum.Value_11, tk[1], tk[2]];
                    }
                    else
                    {
                        return txr_throw_at("Unknown function `" + tk[2] + "`", tk);
                    }
                }
                else
                {
                    fn_script = fn[0];
                    fn_argc = fn[1];
                }
                
                var closed = false;
                
                while (global.txr_build_pos_val < global.txr_build_len_val)
                {
                    tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
                    
                    if (tkn[0] == UnknownEnum.Value_3)
                    {
                        global.txr_build_pos_val += 1;
                        closed = true;
                        break;
                    }
                    
                    if (txr_build_expr(0))
                        return true;
                    
                    args[argc++] = global.txr_build_node_val;
                    tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
                    
                    if (tkn[0] == UnknownEnum.Value_6)
                        global.txr_build_pos_val += 1;
                    else if (tkn[0] != UnknownEnum.Value_3)
                        return txr_throw_at("Expected a `,` or `)`", tkn);
                }
                
                if (!closed)
                    return txr_throw_at("Unclosed `()` after", tk);
                
                if (fn_argc >= 0 && argc != fn_argc)
                    return txr_throw_at("`" + tk[2] + "` takes " + string(fn_argc) + " argument(s), got " + string(argc), tk);
                
                global.txr_build_node_val = [UnknownEnum.Value_5, tk[1], fn_script, args, fn_argc];
            }
            else
            {
                global.txr_build_node_val = [UnknownEnum.Value_2, tk[1], tk[2]];
            }
            
            break;
        
        case UnknownEnum.Value_22:
            global.txr_build_node_val = [UnknownEnum.Value_18, tk[1], tk[2], tk[3]];
            break;
        
        case UnknownEnum.Value_23:
            global.txr_build_node_val = [UnknownEnum.Value_19, tk[1]];
            break;
        
        case UnknownEnum.Value_2:
            if (txr_build_expr(0))
                return true;
            
            tk = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val++);
            
            if (tk[0] != UnknownEnum.Value_3)
                return txr_throw_at("Expected a `)`", tk);
            
            break;
        
        case UnknownEnum.Value_1:
            switch (tk[2])
            {
                case UnknownEnum.Value_16:
                    if (txr_build_expr(UnknownEnum.Value_1))
                        return true;
                    
                    break;
                
                case UnknownEnum.Value_17:
                    if (txr_build_expr(UnknownEnum.Value_1))
                        return true;
                    
                    global.txr_build_node_val = [UnknownEnum.Value_3, tk[1], UnknownEnum.Value_1, global.txr_build_node_val];
                    break;
                
                default:
                    return txr_throw_at("Expected an expression", tk);
            }
            
            break;
        
        case UnknownEnum.Value_14:
            if (txr_build_expr(UnknownEnum.Value_1))
                return true;
            
            global.txr_build_node_val = [UnknownEnum.Value_3, tk[1], tk[2], global.txr_build_node_val];
            break;
        
        case UnknownEnum.Value_32:
            if (txr_build_expr(UnknownEnum.Value_1))
                return true;
            
            global.txr_build_node_val = [UnknownEnum.Value_25, tk[1], global.txr_build_node_val, tk[2]];
            break;
        
        default:
            return txr_throw_at("Expected an expression", tk);
    }
    
    tk = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
    
    if (tk[0] == UnknownEnum.Value_32)
    {
        global.txr_build_pos_val += 1;
        global.txr_build_node_val = [UnknownEnum.Value_26, tk[1], global.txr_build_node_val, tk[2]];
    }
    
    if ((flags & UnknownEnum.Value_1) == 0)
    {
        tk = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
        
        if (tk[0] == UnknownEnum.Value_1)
        {
            global.txr_build_pos_val += 1;
            
            if (txr_build_ops(tk))
                return true;
        }
    }
    
    return false;
}
