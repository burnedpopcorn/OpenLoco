function txr_thread_resume()
{
    var th = argument[0];
    var val = (argument_count > 1) ? argument[1] : undefined;
    var arr = th[UnknownEnum.Value_0];
    
    if (arr == undefined)
        exit;
    
    var _previous = global.txr_thread_current_val;
    global.txr_thread_current_val = th;
    var stack = th[UnknownEnum.Value_2];
    
    switch (th[UnknownEnum.Value_6])
    {
        case UnknownEnum.Value_3:
        case UnknownEnum.Value_2:
            return th[UnknownEnum.Value_6];
        
        case UnknownEnum.Value_4:
            ds_stack_push(stack, val);
            break;
    }
    
    array_set(th, UnknownEnum.Value_5, val);
    var pos = th[UnknownEnum.Value_1];
    var len = array_length_1d(arr);
    var locals = th[UnknownEnum.Value_4];
    var q = undefined;
    var halt = undefined;
    array_set(th, UnknownEnum.Value_6, UnknownEnum.Value_1);
    
    while (pos < len)
    {
        if (halt != undefined)
            break;
        
        q = arr[pos++];
        
        switch (q[0])
        {
            case UnknownEnum.Value_1:
                ds_stack_push(stack, q[2]);
                break;
            
            case UnknownEnum.Value_10:
                ds_stack_push(stack, q[2]);
                break;
            
            case UnknownEnum.Value_3:
                var v = ds_stack_pop(stack);
                
                if (q[2] == UnknownEnum.Value_2)
                {
                    ds_stack_push(stack, v ? false : true);
                }
                else if (is_string(v))
                {
                    halt = "Can't apply unary - to a string";
                    continue;
                }
                else
                {
                    ds_stack_push(stack, -v);
                }
                
                break;
            
            case UnknownEnum.Value_4:
                var b = ds_stack_pop(stack);
                var a = ds_stack_pop(stack);
                
                if (q[2] == UnknownEnum.Value_64)
                {
                    a = a == b;
                }
                else if (q[2] == UnknownEnum.Value_65)
                {
                    a = a != b;
                }
                else if (is_string(a) || is_string(b))
                {
                    if (q[2] == UnknownEnum.Value_16)
                    {
                        if (!is_string(a))
                            a = string(a);
                        
                        if (!is_string(b))
                            b = string(b);
                        
                        a += b;
                    }
                    else
                    {
                        halt = txr_sfmt("Can't apply % to `%`[%] and `%`[%]", global.txr_op_names[q[2]], a, typeof(a), b, typeof(b));
                        continue;
                    }
                }
                else if (txr_is_number(a) && txr_is_number(b))
                {
                    switch (q[2])
                    {
                        case UnknownEnum.Value_16:
                            a += b;
                            break;
                        
                        case UnknownEnum.Value_17:
                            a -= b;
                            break;
                        
                        case UnknownEnum.Value_1:
                            a *= b;
                            break;
                        
                        case UnknownEnum.Value_2:
                            a /= b;
                            break;
                        
                        case UnknownEnum.Value_3:
                            if (b != 0)
                                a %= b;
                            else
                                a = 0;
                            
                            break;
                        
                        case UnknownEnum.Value_4:
                            if (b != 0)
                                a = a div b;
                            else
                                a = 0;
                            
                            break;
                        
                        case UnknownEnum.Value_32:
                            a = a << b;
                            break;
                        
                        case UnknownEnum.Value_33:
                            a = a >> b;
                            break;
                        
                        case UnknownEnum.Value_48:
                            a &= b;
                            break;
                        
                        case UnknownEnum.Value_49:
                            a |= b;
                            break;
                        
                        case UnknownEnum.Value_50:
                            a ^= b;
                            break;
                        
                        case UnknownEnum.Value_66:
                            a = a < b;
                            break;
                        
                        case UnknownEnum.Value_67:
                            a = a <= b;
                            break;
                        
                        case UnknownEnum.Value_68:
                            a = a > b;
                            break;
                        
                        case UnknownEnum.Value_69:
                            a = a >= b;
                            break;
                        
                        default:
                            halt = txr_sfmt("Can't apply %", global.txr_op_names[q[2]]);
                            continue;
                    }
                }
                else
                {
                    halt = txr_sfmt("Can't apply % to `%`[%] and `%`[%]", global.txr_op_names[q[2]], a, typeof(a), b, typeof(b));
                    continue;
                }
                
                ds_stack_push(stack, a);
                break;
            
            case UnknownEnum.Value_2:
                var v = variable_instance_get(id, q[2]);
                ds_stack_push(stack, v);
                break;
            
            case UnknownEnum.Value_11:
                variable_instance_set(id, q[2], ds_stack_pop(stack));
                break;
            
            case UnknownEnum.Value_15:
                ds_stack_push(stack, ds_map_find_value(locals, array_get(q, 2)));
                break;
            
            case UnknownEnum.Value_16:
                ds_map_set(locals, array_get(q, 2), ds_stack_pop(stack));
                break;
            
            case UnknownEnum.Value_5:
                var args = global.txr_exec_args;
                ds_list_clear(args);
                var i = q[3];
                
                while (--i >= 0)
                    ds_list_set(args, i, ds_stack_pop(stack));
                
                global.txr_function_error_val = undefined;
                array_set(th, UnknownEnum.Value_1, pos);
                var v;
                
                switch (q[3])
                {
                    case 0:
                        v = script_execute(q[2]);
                        break;
                    
                    case 1:
                        v = script_execute(q[2], ds_list_find_value(args, 0));
                        break;
                    
                    case 2:
                        v = script_execute(q[2], ds_list_find_value(args, 0), ds_list_find_value(args, 1));
                        break;
                    
                    case 3:
                        v = script_execute(q[2], ds_list_find_value(args, 0), ds_list_find_value(args, 1), ds_list_find_value(args, 2));
                        break;
                    
                    case 4:
                        v = script_execute(q[2], ds_list_find_value(args, 0), ds_list_find_value(args, 1), ds_list_find_value(args, 2), ds_list_find_value(args, 3));
                        break;
                    
                    case 5:
                        v = script_execute(q[2], ds_list_find_value(args, 0), ds_list_find_value(args, 1), ds_list_find_value(args, 2), ds_list_find_value(args, 3), ds_list_find_value(args, 4));
                        break;
                    
                    case 6:
                        v = script_execute(q[2], ds_list_find_value(args, 0), ds_list_find_value(args, 1), ds_list_find_value(args, 2), ds_list_find_value(args, 3), ds_list_find_value(args, 4), ds_list_find_value(args, 5));
                        break;
                    
                    case 7:
                        v = script_execute(q[2], ds_list_find_value(args, 0), ds_list_find_value(args, 1), ds_list_find_value(args, 2), ds_list_find_value(args, 3), ds_list_find_value(args, 4), ds_list_find_value(args, 5), ds_list_find_value(args, 6));
                        break;
                    
                    case 8:
                        v = script_execute(q[2], ds_list_find_value(args, 0), ds_list_find_value(args, 1), ds_list_find_value(args, 2), ds_list_find_value(args, 3), ds_list_find_value(args, 4), ds_list_find_value(args, 5), ds_list_find_value(args, 6), ds_list_find_value(args, 7));
                        break;
                    
                    case 9:
                        v = script_execute(q[2], ds_list_find_value(args, 0), ds_list_find_value(args, 1), ds_list_find_value(args, 2), ds_list_find_value(args, 3), ds_list_find_value(args, 4), ds_list_find_value(args, 5), ds_list_find_value(args, 6), ds_list_find_value(args, 7), ds_list_find_value(args, 8));
                        break;
                    
                    case 10:
                        v = script_execute(q[2], ds_list_find_value(args, 0), ds_list_find_value(args, 1), ds_list_find_value(args, 2), ds_list_find_value(args, 3), ds_list_find_value(args, 4), ds_list_find_value(args, 5), ds_list_find_value(args, 6), ds_list_find_value(args, 7), ds_list_find_value(args, 8), ds_list_find_value(args, 9));
                        break;
                    
                    case 11:
                        v = script_execute(q[2], ds_list_find_value(args, 0), ds_list_find_value(args, 1), ds_list_find_value(args, 2), ds_list_find_value(args, 3), ds_list_find_value(args, 4), ds_list_find_value(args, 5), ds_list_find_value(args, 6), ds_list_find_value(args, 7), ds_list_find_value(args, 8), ds_list_find_value(args, 9), ds_list_find_value(args, 10));
                        break;
                    
                    case 12:
                        v = script_execute(q[2], ds_list_find_value(args, 0), ds_list_find_value(args, 1), ds_list_find_value(args, 2), ds_list_find_value(args, 3), ds_list_find_value(args, 4), ds_list_find_value(args, 5), ds_list_find_value(args, 6), ds_list_find_value(args, 7), ds_list_find_value(args, 8), ds_list_find_value(args, 9), ds_list_find_value(args, 10), ds_list_find_value(args, 11));
                        break;
                    
                    case 13:
                        v = script_execute(q[2], ds_list_find_value(args, 0), ds_list_find_value(args, 1), ds_list_find_value(args, 2), ds_list_find_value(args, 3), ds_list_find_value(args, 4), ds_list_find_value(args, 5), ds_list_find_value(args, 6), ds_list_find_value(args, 7), ds_list_find_value(args, 8), ds_list_find_value(args, 9), ds_list_find_value(args, 10), ds_list_find_value(args, 11), ds_list_find_value(args, 12));
                        break;
                    
                    case 14:
                        v = script_execute(q[2], ds_list_find_value(args, 0), ds_list_find_value(args, 1), ds_list_find_value(args, 2), ds_list_find_value(args, 3), ds_list_find_value(args, 4), ds_list_find_value(args, 5), ds_list_find_value(args, 6), ds_list_find_value(args, 7), ds_list_find_value(args, 8), ds_list_find_value(args, 9), ds_list_find_value(args, 10), ds_list_find_value(args, 11), ds_list_find_value(args, 12), ds_list_find_value(args, 13));
                        break;
                    
                    case 15:
                        v = script_execute(q[2], ds_list_find_value(args, 0), ds_list_find_value(args, 1), ds_list_find_value(args, 2), ds_list_find_value(args, 3), ds_list_find_value(args, 4), ds_list_find_value(args, 5), ds_list_find_value(args, 6), ds_list_find_value(args, 7), ds_list_find_value(args, 8), ds_list_find_value(args, 9), ds_list_find_value(args, 10), ds_list_find_value(args, 11), ds_list_find_value(args, 12), ds_list_find_value(args, 13), ds_list_find_value(args, 14));
                        break;
                    
                    case 16:
                        v = script_execute(q[2], ds_list_find_value(args, 0), ds_list_find_value(args, 1), ds_list_find_value(args, 2), ds_list_find_value(args, 3), ds_list_find_value(args, 4), ds_list_find_value(args, 5), ds_list_find_value(args, 6), ds_list_find_value(args, 7), ds_list_find_value(args, 8), ds_list_find_value(args, 9), ds_list_find_value(args, 10), ds_list_find_value(args, 11), ds_list_find_value(args, 12), ds_list_find_value(args, 13), ds_list_find_value(args, 14), ds_list_find_value(args, 15));
                        break;
                    
                    default:
                        halt = txr_sfmt("Too many arguments (%)", q[3]);
                        continue;
                }
                
                halt = global.txr_function_error_val;
                
                if (halt != undefined)
                    continue;
                
                if (th[UnknownEnum.Value_6] != UnknownEnum.Value_1)
                {
                    halt = th[UnknownEnum.Value_6];
                    continue;
                }
                
                ds_stack_push(stack, v);
                break;
            
            case UnknownEnum.Value_6:
                pos = len;
                break;
            
            case UnknownEnum.Value_7:
                ds_stack_pop(stack);
                break;
            
            case UnknownEnum.Value_8:
                pos = q[2];
                break;
            
            case UnknownEnum.Value_9:
                if (ds_stack_pop(stack))
                {
                }
                else
                {
                    pos = q[2];
                }
                
                break;
            
            case UnknownEnum.Value_14:
                if (ds_stack_pop(stack))
                    pos = q[2];
                
                break;
            
            case UnknownEnum.Value_12:
                if (ds_stack_top(stack))
                    ds_stack_pop(stack);
                else
                    pos = q[2];
                
                break;
            
            case UnknownEnum.Value_13:
                if (ds_stack_top(stack))
                    pos = q[2];
                else
                    ds_stack_pop(stack);
                
                break;
            
            case UnknownEnum.Value_17:
                ds_stack_push(th[UnknownEnum.Value_3], pos);
                pos = q[2];
                break;
            
            case UnknownEnum.Value_18:
                pos = ds_stack_pop(th[UnknownEnum.Value_3]);
                break;
            
            case UnknownEnum.Value_19:
                var v = ds_stack_pop(stack);
                var posx = q[2];
                
                if (txr_is_number(v) && v >= 0 && v < array_length_1d(posx))
                    pos = posx[v];
                else
                    pos = q[3];
                
                break;
            
            case UnknownEnum.Value_20:
                ds_stack_push(stack, ds_stack_top(stack));
                break;
            
            case UnknownEnum.Value_21:
                var v = ds_stack_pop(stack);
                
                if (v == ds_stack_top(stack))
                {
                    ds_stack_pop(stack);
                    pos = q[2];
                }
                
                break;
            
            default:
                halt = txr_sfmt("Can't run action ID %", q[0]);
                continue;
        }
    }
    
    if (halt == undefined)
    {
        array_set(th, UnknownEnum.Value_6, UnknownEnum.Value_2);
        
        if (ds_stack_empty(stack))
            array_set(th, UnknownEnum.Value_5, 0);
        else
            array_set(th, UnknownEnum.Value_5, ds_stack_pop(stack));
    }
    else if (is_string(halt))
    {
        array_set(th, UnknownEnum.Value_6, UnknownEnum.Value_3);
        array_set(th, UnknownEnum.Value_5, halt + " at " + txr_print_pos(q[1]));
    }
    
    array_set(th, UnknownEnum.Value_1, pos);
    global.txr_thread_current_val = _previous;
    return th[UnknownEnum.Value_6];
}
