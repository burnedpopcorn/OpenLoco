function txr_build()
{
    global.txr_build_list_val = global.txr_parse_tokens_val;
    global.txr_build_pos_val = 0;
    global.txr_build_len_val = ds_list_size(global.txr_build_list_val) - 1;
    global.txr_build_can_break_val = false;
    global.txr_build_can_continue_val = false;
    ds_map_clear(global.txr_build_locals_val);
    var nodes = [];
    var found = 0;
    
    while (global.txr_build_pos_val < global.txr_build_len_val)
    {
        if (txr_build_stat())
            return true;
        
        nodes[found++] = global.txr_build_node_val;
    }
    
    global.txr_build_node_val = [UnknownEnum.Value_6, 0, nodes];
    return false;
}
