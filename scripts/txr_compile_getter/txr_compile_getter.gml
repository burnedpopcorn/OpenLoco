function txr_compile_getter(argument0)
{
    var q = argument0;
    var out = global.txr_compile_list_val;
    
    switch (q[0])
    {
        case UnknownEnum.Value_2:
            if (ds_map_exists(global.txr_build_locals_val, q[2]))
                ds_list_add(out, [UnknownEnum.Value_15, q[1], q[2]]);
            else
                ds_list_add(out, [UnknownEnum.Value_2, q[1], q[2]]);
            
            return false;
        
        default:
            return txr_throw_at("Expression is not gettable", q);
    }
}
