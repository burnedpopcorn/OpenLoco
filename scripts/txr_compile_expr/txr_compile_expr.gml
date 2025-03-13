function txr_compile_expr(argument0)
{
    var q = argument0;
    var out = global.txr_compile_list_val;
    
    switch (q[0])
    {
        case UnknownEnum.Value_1:
            ds_list_add(out, [UnknownEnum.Value_1, q[1], q[2]]);
            break;
        
        case UnknownEnum.Value_11:
            ds_list_add(out, [UnknownEnum.Value_10, q[1], q[2]]);
            break;
        
        case UnknownEnum.Value_2:
            if (txr_compile_getter(q))
                return true;
            
            break;
        
        case UnknownEnum.Value_18:
            ds_list_add(out, [UnknownEnum.Value_15, q[1], q[3]]);
            break;
        
        case UnknownEnum.Value_19:
            ds_list_add(out, [UnknownEnum.Value_15, q[1], "argument_count"]);
            break;
        
        case UnknownEnum.Value_3:
            if (txr_compile_expr(q[3]))
                return true;
            
            ds_list_add(out, [UnknownEnum.Value_3, q[1], q[2]]);
            break;
        
        case UnknownEnum.Value_4:
            switch (q[2])
            {
                case UnknownEnum.Value_80:
                    if (txr_compile_expr(q[3]))
                        return true;
                    
                    var jmp = [UnknownEnum.Value_12, q[1], 0];
                    ds_list_add(out, jmp);
                    
                    if (txr_compile_expr(q[4]))
                        return true;
                    
                    array_set(jmp, 2, ds_list_size(out));
                    break;
                
                case UnknownEnum.Value_96:
                    if (txr_compile_expr(q[3]))
                        return true;
                    
                    var jmp = [UnknownEnum.Value_13, q[1], 0];
                    ds_list_add(out, jmp);
                    
                    if (txr_compile_expr(q[4]))
                        return true;
                    
                    array_set(jmp, 2, ds_list_size(out));
                    break;
                
                default:
                    if (txr_compile_expr(q[3]))
                        return true;
                    
                    if (txr_compile_expr(q[4]))
                        return true;
                    
                    ds_list_add(out, [UnknownEnum.Value_4, q[1], q[2]]);
            }
            
            break;
        
        case UnknownEnum.Value_5:
            var args = q[3];
            var argc = array_length_1d(args);
            
            for (var i = 0; i < argc; i++)
            {
                if (txr_compile_expr(args[i]))
                    return true;
            }
            
            ds_list_add(out, [UnknownEnum.Value_5, q[1], q[2], argc]);
            break;
        
        case UnknownEnum.Value_6:
            var nodes = q[2];
            var n = array_length_1d(nodes);
            
            for (var i = 0; i < n; i++)
            {
                if (txr_compile_expr(nodes[i]))
                    return true;
            }
            
            break;
        
        case UnknownEnum.Value_7:
            if (txr_compile_expr(q[2]))
                return true;
            
            ds_list_add(out, [UnknownEnum.Value_6, q[1]]);
            break;
        
        case UnknownEnum.Value_8:
            if (txr_compile_expr(q[2]))
                return true;
            
            ds_list_add(out, [UnknownEnum.Value_7, q[1]]);
            break;
        
        case UnknownEnum.Value_9:
            if (txr_compile_expr(q[2]))
                return true;
            
            var jmp = [UnknownEnum.Value_9, q[1], 0];
            ds_list_add(out, jmp);
            
            if (txr_compile_expr(q[3]))
                return true;
            
            array_set(jmp, 2, ds_list_size(out));
            break;
        
        case UnknownEnum.Value_10:
            if (txr_compile_expr(q[2]))
                return true;
            
            var jmp_else = [UnknownEnum.Value_9, q[1], 0];
            ds_list_add(out, jmp_else);
            
            if (txr_compile_expr(q[3]))
                return true;
            
            var jmp_then = [UnknownEnum.Value_8, q[1], 0];
            ds_list_add(out, jmp_then);
            array_set(jmp_else, 2, ds_list_size(out));
            
            if (txr_compile_expr(q[4]))
                return true;
            
            array_set(jmp_then, 2, ds_list_size(out));
            break;
        
        case UnknownEnum.Value_24:
            if (txr_compile_expr(q[2]))
                return true;
            
            var opts = q[3];
            var optc = array_length_1d(opts);
            var sel_jmps = array_create(optc);
            var opt_jmps = array_create(optc);
            var _sel = [UnknownEnum.Value_19, q[1], sel_jmps, 0];
            ds_list_add(out, _sel);
            
            for (var i = 0; i < optc; i++)
            {
                array_set(sel_jmps, i, ds_list_size(out));
                
                if (txr_compile_expr(opts[i]))
                    return true;
                
                var jmp = [UnknownEnum.Value_8, q[1], 0];
                array_set(opt_jmps, i, jmp);
                ds_list_add(out, jmp);
            }
            
            array_set(_sel, 3, ds_list_size(out));
            
            if (q[4] != undefined)
            {
                if (txr_compile_expr(q[4]))
                    return true;
            }
            
            for (var i = 0; i < optc; i++)
            {
                var jmp = opt_jmps[i];
                array_set(jmp, 2, ds_list_size(out));
            }
            
            break;
        
        case UnknownEnum.Value_28:
            var args = q[3];
            var opts = q[4];
            var optc = array_length_1d(opts);
            var arg_jmps = array_create(optc);
            
            if (txr_compile_expr(q[2]))
                return true;
            
            for (var i = 0; i < optc; i++)
            {
                if (txr_compile_expr(args[i]))
                    return true;
                
                var jmp = [UnknownEnum.Value_21, q[1], 0];
                array_set(arg_jmps, i, jmp);
                ds_list_add(out, jmp);
            }
            
            ds_list_add(out, [UnknownEnum.Value_7, q[1]]);
            var def_jmp = [UnknownEnum.Value_8, q[1], 0];
            ds_list_add(out, def_jmp);
            var pos_start = ds_list_size(out);
            
            for (var i = 0; i < optc; i++)
            {
                var jmp = arg_jmps[i];
                array_set(jmp, 2, ds_list_size(out));
                
                if (txr_compile_expr(opts[i]))
                    return true;
            }
            
            array_set(def_jmp, 2, ds_list_size(out));
            
            if (q[5] != undefined)
            {
                if (txr_compile_expr(q[5]))
                    return true;
            }
            
            var pos_break = ds_list_size(out);
            txr_compile_patch_break_continue(pos_start, pos_break, pos_break, -1);
            break;
        
        case UnknownEnum.Value_12:
            if (q[2] == UnknownEnum.Value_m1)
            {
                if (txr_compile_expr(q[4]))
                    return true;
            }
            else
            {
                if (txr_compile_getter(q[3]))
                    return true;
                
                if (txr_compile_expr(q[4]))
                    return true;
                
                ds_list_add(out, [UnknownEnum.Value_4, q[1], q[2]]);
            }
            
            if (txr_compile_setter(q[3]))
                return true;
            
            break;
        
        case UnknownEnum.Value_27:
            if (txr_compile_getter(q[2]))
                return true;
            
            ds_list_add(out, [UnknownEnum.Value_1, q[1], q[3]]);
            ds_list_add(out, [UnknownEnum.Value_4, q[1], UnknownEnum.Value_16]);
            
            if (txr_compile_setter(q[2]))
                return true;
            
            break;
        
        case UnknownEnum.Value_25:
            if (txr_compile_getter(q[2]))
                return true;
            
            ds_list_add(out, [UnknownEnum.Value_1, q[1], q[3]]);
            ds_list_add(out, [UnknownEnum.Value_4, q[1], UnknownEnum.Value_16]);
            ds_list_add(out, [UnknownEnum.Value_20, q[1]]);
            
            if (txr_compile_setter(q[2]))
                return true;
            
            break;
        
        case UnknownEnum.Value_26:
            if (txr_compile_getter(q[2]))
                return true;
            
            ds_list_add(out, [UnknownEnum.Value_20, q[1]]);
            ds_list_add(out, [UnknownEnum.Value_1, q[1], q[3]]);
            ds_list_add(out, [UnknownEnum.Value_4, q[1], UnknownEnum.Value_16]);
            
            if (txr_compile_setter(q[2]))
                return true;
            
            break;
        
        case UnknownEnum.Value_13:
            var pos_cont = ds_list_size(out);
            
            if (txr_compile_expr(q[2]))
                return true;
            
            var jmp = [UnknownEnum.Value_9, q[1], 0];
            ds_list_add(out, jmp);
            var pos_start = ds_list_size(out);
            
            if (txr_compile_expr(q[3]))
                return true;
            
            ds_list_add(out, [UnknownEnum.Value_8, q[1], pos_cont]);
            var pos_break = ds_list_size(out);
            array_set(jmp, 2, pos_break);
            txr_compile_patch_break_continue(pos_start, pos_break, pos_break, pos_cont);
            break;
        
        case UnknownEnum.Value_14:
            var pos_start = ds_list_size(out);
            
            if (txr_compile_expr(q[2]))
                return true;
            
            var pos_cont = ds_list_size(out);
            
            if (txr_compile_expr(q[3]))
                return true;
            
            ds_list_add(out, [UnknownEnum.Value_14, q[1], pos_start]);
            var pos_break = ds_list_size(out);
            txr_compile_patch_break_continue(pos_start, pos_break, pos_break, pos_cont);
            break;
        
        case UnknownEnum.Value_15:
            if (txr_compile_expr(q[2]))
                return true;
            
            var pos_loop = ds_list_size(out);
            
            if (txr_compile_expr(q[3]))
                return true;
            
            var jmp = [UnknownEnum.Value_9, q[1], 0];
            ds_list_add(out, jmp);
            var pos_start = ds_list_size(out);
            
            if (txr_compile_expr(q[5]))
                return true;
            
            var pos_cont = ds_list_size(out);
            
            if (txr_compile_expr(q[4]))
                return true;
            
            ds_list_add(out, [UnknownEnum.Value_8, q[1], pos_loop]);
            var pos_break = ds_list_size(out);
            array_set(jmp, 2, pos_break);
            txr_compile_patch_break_continue(pos_start, pos_break, pos_break, pos_cont);
            break;
        
        case UnknownEnum.Value_16:
            ds_list_add(out, [UnknownEnum.Value_8, q[1], -10]);
            break;
        
        case UnknownEnum.Value_17:
            ds_list_add(out, [UnknownEnum.Value_8, q[1], -11]);
            break;
        
        case UnknownEnum.Value_20:
            var lbs = ds_map_find_value(global.txr_compile_labels_val, array_get(q, 2));
            
            if (lbs == undefined)
            {
                lbs = [ds_list_size(out)];
                ds_map_set(global.txr_compile_labels_val, array_get(q, 2), lbs);
            }
            else
            {
                array_set(lbs, 0, ds_list_size(out));
            }
            
            txr_compile_expr(q[3]);
            break;
        
        case UnknownEnum.Value_21:
        case UnknownEnum.Value_22:
            var lbs = ds_map_find_value(global.txr_compile_labels_val, array_get(q, 2));
            
            if (lbs == undefined)
            {
                lbs = [undefined];
                ds_map_set(global.txr_compile_labels_val, array_get(q, 2), lbs);
            }
            
            var i = (q[0] == UnknownEnum.Value_21) ? UnknownEnum.Value_8 : UnknownEnum.Value_17;
            var jmp = [i, q[1], undefined];
            ds_list_add(out, jmp);
            array_set(lbs, array_length_1d(lbs), jmp);
            break;
        
        case UnknownEnum.Value_23:
            ds_list_add(out, [UnknownEnum.Value_18, q[1]]);
            break;
        
        default:
            return txr_throw_at("Cannot compile node type " + string(q[0]), q);
    }
    
    return false;
}
