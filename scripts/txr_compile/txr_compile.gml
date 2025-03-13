function txr_compile(argument0)
{
    if (txr_parse(argument0))
        return undefined;
    
    if (txr_build())
        return undefined;
    
    var out = global.txr_compile_list_val;
    ds_list_clear(out);
    var lbm = global.txr_compile_labels_val;
    ds_map_clear(lbm);
    
    if (txr_compile_expr(global.txr_build_node_val))
        return undefined;
    
    var k = ds_map_find_first(lbm);
    
    repeat (ds_map_size(lbm))
    {
        var lbs = ds_map_find_value(lbm, k);
        
        if (lbs[0] == undefined && array_length_1d(lbs) > 1)
        {
            var lb = lbs[1];
            txr_throw_at("Using undeclared label " + k, lb);
            return undefined;
        }
        
        var i = array_length_1d(lbs);
        
        while (--i >= 1)
        {
            var lb = lbs[i];
            array_set(lb, 2, lbs[0]);
        }
        
        k = ds_map_find_next(lbm, k);
    }
    
    var n = ds_list_size(out);
    var arr = array_create(n);
    
    for (var i = 0; i < n; i++)
        arr[i] = ds_list_find_value(out, i);
    
    ds_list_clear(out);
    return arr;
}
