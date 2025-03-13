function txr_build_stat()
{
    var tk = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val++);
    
    switch (tk[0])
    {
        case UnknownEnum.Value_7:
            if (txr_build_expr(0))
                return true;
            
            global.txr_build_node_val = [UnknownEnum.Value_7, tk[1], global.txr_build_node_val];
            break;
        
        case UnknownEnum.Value_8:
            if (txr_build_expr(0))
                return true;
            
            var _cond = global.txr_build_node_val;
            
            if (txr_build_stat())
                return true;
            
            var _then = global.txr_build_node_val;
            var tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
            
            if (tkn[0] == UnknownEnum.Value_9)
            {
                global.txr_build_pos_val += 1;
                
                if (txr_build_stat())
                    return true;
                
                global.txr_build_node_val = [UnknownEnum.Value_10, tk[1], _cond, _then, global.txr_build_node_val];
            }
            else
            {
                global.txr_build_node_val = [UnknownEnum.Value_9, tk[1], _cond, _then];
            }
            
            break;
        
        case UnknownEnum.Value_29:
            if (txr_build_expr(0))
                return true;
            
            var _func = global.txr_build_node_val;
            
            if (_func[0] != UnknownEnum.Value_5)
                return txr_throw_at("Expected a function call", _func);
            
            if (_func[4] != -1)
                return txr_throw_at("Function does not accept extra arguments", _func);
            
            var _args = _func[3];
            var _argc = array_length_1d(_args);
            var tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val++);
            
            if (tkn[0] != UnknownEnum.Value_11)
                return txr_throw_at("Expected a `{`", tkn);
            
            var _opts = [];
            var _optc = 0;
            var _default = undefined;
            var closed = false;
            
            while (global.txr_build_pos_val < global.txr_build_len_val)
            {
                tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val++);
                
                if (tkn[0] == UnknownEnum.Value_12)
                {
                    closed = true;
                    break;
                }
                else if (tkn[0] == UnknownEnum.Value_30 || tkn[0] == UnknownEnum.Value_31)
                {
                    var nodes = [];
                    var found = 0;
                    
                    if (tkn[0] == UnknownEnum.Value_30)
                    {
                        if (txr_build_expr(0))
                            return true;
                        
                        array_set(_args, _argc++, global.txr_build_node_val);
                        array_set(_opts, _optc++, [UnknownEnum.Value_6, tk[1], nodes]);
                    }
                    else
                    {
                        _default = [UnknownEnum.Value_6, tk[1], nodes];
                    }
                    
                    tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val++);
                    
                    if (tkn[0] != UnknownEnum.Value_28)
                        return txr_throw_at("Expected a `:`", tkn);
                    
                    while (global.txr_build_pos_val < global.txr_build_len_val)
                    {
                        tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
                        
                        if (tkn[0] == UnknownEnum.Value_12 || tkn[0] == UnknownEnum.Value_30 || tkn[0] == UnknownEnum.Value_31)
                            break;
                        
                        if (txr_build_stat())
                            return true;
                        
                        array_set(nodes, found++, global.txr_build_node_val);
                    }
                }
                else
                {
                    return txr_throw_at("Expected an `option` or `}`", tkn);
                }
            }
            
            global.txr_build_node_val = [UnknownEnum.Value_24, tk[1], _func, _opts, _default];
            break;
        
        case UnknownEnum.Value_33:
            if (txr_build_expr(0))
                return true;
            
            var _expr = global.txr_build_node_val;
            var tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val++);
            
            if (tkn[0] != UnknownEnum.Value_11)
                return txr_throw_at("Expected a `{`", tkn);
            
            var _args = [];
            var _opts = [];
            var _optc = 0;
            var _default = undefined;
            var closed = false;
            
            while (global.txr_build_pos_val < global.txr_build_len_val)
            {
                tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val++);
                
                if (tkn[0] == UnknownEnum.Value_12)
                {
                    closed = true;
                    break;
                }
                else if (tkn[0] == UnknownEnum.Value_34 || tkn[0] == UnknownEnum.Value_31)
                {
                    var nodes = [];
                    var found = 0;
                    
                    if (tkn[0] == UnknownEnum.Value_34)
                    {
                        if (txr_build_expr(0))
                            return true;
                        
                        array_set(_args, _optc, global.txr_build_node_val);
                        array_set(_opts, _optc++, [UnknownEnum.Value_6, tk[1], nodes]);
                    }
                    else
                    {
                        _default = [UnknownEnum.Value_6, tk[1], nodes];
                    }
                    
                    tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val++);
                    
                    if (tkn[0] != UnknownEnum.Value_28)
                        return txr_throw_at("Expected a `:`", tkn);
                    
                    while (global.txr_build_pos_val < global.txr_build_len_val)
                    {
                        tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
                        
                        if (tkn[0] == UnknownEnum.Value_12 || tkn[0] == UnknownEnum.Value_34 || tkn[0] == UnknownEnum.Value_31)
                            break;
                        
                        if (txr_build_stat())
                            return true;
                        
                        array_set(nodes, found++, global.txr_build_node_val);
                    }
                }
                else
                {
                    return txr_throw_at("Expected an `option` or `}`", tkn);
                }
            }
            
            global.txr_build_node_val = [UnknownEnum.Value_28, tk[1], _expr, _args, _opts, _default];
            break;
        
        case UnknownEnum.Value_11:
            var nodes = [];
            var found = 0;
            var closed = false;
            
            while (global.txr_build_pos_val < global.txr_build_len_val)
            {
                var tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
                
                if (tkn[0] == UnknownEnum.Value_12)
                {
                    global.txr_build_pos_val += 1;
                    closed = true;
                    break;
                }
                
                if (txr_build_stat())
                    return true;
                
                array_set(nodes, found++, global.txr_build_node_val);
            }
            
            if (!closed)
                return txr_throw_at("Unclosed {} starting", tk);
            
            global.txr_build_node_val = [UnknownEnum.Value_6, tk[1], nodes];
            break;
        
        case UnknownEnum.Value_15:
            if (txr_build_expr(0))
                return true;
            
            var _cond = global.txr_build_node_val;
            
            if (txr_build_loop_body())
                return true;
            
            global.txr_build_node_val = [UnknownEnum.Value_13, tk[1], _cond, global.txr_build_node_val];
            break;
        
        case UnknownEnum.Value_16:
            if (txr_build_loop_body())
                return true;
            
            var _loop = global.txr_build_node_val;
            var tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
            
            if (tkn[0] != UnknownEnum.Value_15)
                return txr_throw_at("Expected a `while` after do", tkn);
            
            global.txr_build_pos_val += 1;
            
            if (txr_build_expr(0))
                return true;
            
            global.txr_build_node_val = [UnknownEnum.Value_14, tk[1], _loop, global.txr_build_node_val];
            break;
        
        case UnknownEnum.Value_17:
            var tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
            var _par = tkn[0] == UnknownEnum.Value_2;
            
            if (_par)
                global.txr_build_pos_val += 1;
            
            if (txr_build_stat())
                return true;
            
            var _init = global.txr_build_node_val;
            
            if (txr_build_expr(0))
                return true;
            
            var _cond = global.txr_build_node_val;
            tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
            
            if (tkn[0] == UnknownEnum.Value_18)
                global.txr_build_pos_val += 1;
            
            if (txr_build_stat())
                return true;
            
            var _post = global.txr_build_node_val;
            
            if (_par)
            {
                tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
                
                if (tkn[0] != UnknownEnum.Value_3)
                    return txr_throw_at("Expected a `)`", tkn);
                
                global.txr_build_pos_val += 1;
            }
            
            if (txr_build_loop_body())
                return true;
            
            global.txr_build_node_val = [UnknownEnum.Value_15, tk[1], _init, _cond, _post, global.txr_build_node_val];
            break;
        
        case UnknownEnum.Value_19:
            if (global.txr_build_can_break_val)
                global.txr_build_node_val = [UnknownEnum.Value_16, tk[1]];
            else
                return txr_throw_at("Can't `break` here", tk);
            
            break;
        
        case UnknownEnum.Value_20:
            if (global.txr_build_can_continue_val)
                global.txr_build_node_val = [UnknownEnum.Value_17, tk[1]];
            else
                return txr_throw_at("Can't `continue` here", tk);
            
            break;
        
        case UnknownEnum.Value_21:
            var nodes = [];
            var found = 0;
            
            do
            {
                var tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val++);
                
                if (tkn[0] != UnknownEnum.Value_5)
                    return txr_throw_at("Expected a variable name", tkn);
                
                var name = tkn[2];
                tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
                ds_map_set(global.txr_build_locals_val, name, true);
                
                if (tkn[0] == UnknownEnum.Value_13)
                {
                    global.txr_build_pos_val += 1;
                    
                    if (txr_build_expr(0))
                        return true;
                    
                    nodes[found++] = [UnknownEnum.Value_12, tkn[1], UnknownEnum.Value_m1, [UnknownEnum.Value_2, tkn[1], name], global.txr_build_node_val];
                }
                
                tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
                
                if (tkn[0] == UnknownEnum.Value_6)
                    global.txr_build_pos_val += 1;
                else
                    break;
            }
            until (global.txr_build_pos_val >= global.txr_build_len_val);
            
            global.txr_build_node_val = [UnknownEnum.Value_6, tk[1], nodes];
            break;
        
        case UnknownEnum.Value_24:
            var tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val++);
            
            if (tkn[0] != UnknownEnum.Value_5)
                return txr_throw_at("Expected a label name", tkn);
            
            var name = tkn[2];
            tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
            
            if (tkn[0] == UnknownEnum.Value_28)
                global.txr_build_pos_val++;
            
            if (txr_build_stat())
                return true;
            
            global.txr_build_node_val = [UnknownEnum.Value_20, tk[1], name, global.txr_build_node_val];
            break;
        
        case UnknownEnum.Value_25:
            var tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val++);
            
            if (tkn[0] != UnknownEnum.Value_5)
                return txr_throw_at("Expected a label name", tkn);
            
            global.txr_build_node_val = [UnknownEnum.Value_21, tk[1], tkn[2]];
            break;
        
        case UnknownEnum.Value_26:
            var tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val++);
            
            if (tkn[0] != UnknownEnum.Value_5)
                return txr_throw_at("Expected a label name", tkn);
            
            global.txr_build_node_val = [UnknownEnum.Value_22, tk[1], tkn[2]];
            break;
        
        case UnknownEnum.Value_27:
            global.txr_build_node_val = [UnknownEnum.Value_23, tk[1]];
            break;
        
        default:
            global.txr_build_pos_val -= 1;
            
            if (txr_build_expr(UnknownEnum.Value_1))
                return true;
            
            var _expr = global.txr_build_node_val;
            
            switch (_expr[0])
            {
                case UnknownEnum.Value_25:
                case UnknownEnum.Value_26:
                    array_set(_expr, 1, UnknownEnum.Value_27);
                    break;
                
                case UnknownEnum.Value_5:
                    global.txr_build_node_val = [UnknownEnum.Value_8, _expr[1], _expr];
                    break;
                
                default:
                    var tkn = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
                    
                    if (tkn[0] == UnknownEnum.Value_13)
                    {
                        global.txr_build_pos_val += 1;
                        
                        if (txr_build_expr(0))
                            return true;
                        
                        global.txr_build_node_val = [UnknownEnum.Value_12, tkn[1], tkn[2], _expr, global.txr_build_node_val];
                        break;
                    }
                    
                    return txr_throw_at("Expected a statement", global.txr_build_node_val);
            }
    }
    
    tk = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
    
    if (tk[0] == UnknownEnum.Value_18)
        global.txr_build_pos_val += 1;
}
