function txr_action_print(argument0)
{
    var q = argument0;
    var s = "[" + txr_print_pos(q[1]) + "]";
    
    switch (q[0])
    {
        case UnknownEnum.Value_1:
            return txr_sfmt("% number %", s, q[2]);
        
        case UnknownEnum.Value_10:
            return txr_sfmt("% string `%`", s, q[2]);
        
        case UnknownEnum.Value_4:
            return txr_sfmt("% binop %", s, global.txr_op_names[q[2]]);
        
        case UnknownEnum.Value_7:
            return s + " discard";
        
        case UnknownEnum.Value_20:
            return s + " dup";
        
        case UnknownEnum.Value_5:
            return txr_sfmt("% %(%)", s, script_get_name(q[2]), q[3]);
        
        case UnknownEnum.Value_2:
            return txr_sfmt("% get ident %", s, q[2]);
        
        case UnknownEnum.Value_11:
            return txr_sfmt("% set ident %", s, q[2]);
        
        case UnknownEnum.Value_15:
            return txr_sfmt("% get local %", s, q[2]);
        
        case UnknownEnum.Value_16:
            return txr_sfmt("% set local %", s, q[2]);
        
        case UnknownEnum.Value_8:
            return txr_sfmt("% jump %", s, q[2]);
        
        case UnknownEnum.Value_14:
            return txr_sfmt("% jump_if %", s, q[2]);
        
        case UnknownEnum.Value_9:
            return txr_sfmt("% jump_unless %", s, q[2]);
        
        case UnknownEnum.Value_21:
            return txr_sfmt("% switch_jump %", s, q[2]);
        
        default:
            s = txr_sfmt("% A%", s, q[0]);
            var n = array_length_1d(q);
            
            for (var i = 2; i < n; i++)
                s += (" " + string(q[i]));
            
            return s;
    }
}
