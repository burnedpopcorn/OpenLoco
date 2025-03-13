function txr_build_ops(argument0)
{
    var nodes = ds_list_create();
    ds_list_add(nodes, global.txr_build_node_val);
    var ops = ds_list_create();
    ds_list_add(ops, argument0);
    
    while (true)
    {
        if (txr_build_expr(UnknownEnum.Value_1))
        {
            ds_list_destroy(nodes);
            ds_list_destroy(ops);
            return true;
        }
        
        ds_list_add(nodes, global.txr_build_node_val);
        var tk = ds_list_find_value(global.txr_build_list_val, global.txr_build_pos_val);
        
        if (tk[0] == UnknownEnum.Value_1)
        {
            global.txr_build_pos_val++;
            ds_list_add(ops, tk);
        }
        else
        {
            break;
        }
    }
    
    var n = ds_list_size(ops);
    var pmax = UnknownEnum.Value_7;
    
    for (var pri = 0; pri < pmax; pri += 1)
    {
        for (var i = 0; i < n; i++)
        {
            var tk = ds_list_find_value(ops, i);
            
            if ((tk[2] >> 4) != pri)
                continue;
            
            ds_list_set(nodes, i, [UnknownEnum.Value_4, tk[1], tk[2], ds_list_find_value(nodes, i), ds_list_find_value(nodes, i + 1)]);
            ds_list_delete(nodes, i + 1);
            ds_list_delete(ops, i);
            n -= 1;
            i -= 1;
        }
    }
    
    global.txr_build_node_val = ds_list_find_value(nodes, 0);
    ds_list_destroy(nodes);
    ds_list_destroy(ops);
    return false;
}
