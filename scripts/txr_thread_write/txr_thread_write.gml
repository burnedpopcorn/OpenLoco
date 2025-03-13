function txr_thread_write(argument0, argument1)
{
    var th = argument0;
    var b = argument1;
    buffer_write(b, buffer_u8, th[UnknownEnum.Value_6]);
    buffer_write(b, buffer_s32, th[UnknownEnum.Value_1]);
    txr_value_write(th[UnknownEnum.Value_5], b);
    var s = th[UnknownEnum.Value_2];
    var n = ds_stack_size(s);
    var w = array_create(n);
    buffer_write(b, buffer_u32, n);
    var i;
    
    for (i = 0; i < n; i++)
        w[i] = ds_stack_pop(s);
    
    while (--i >= 0)
    {
        v = w[i];
        txr_value_write(v, b);
        ds_stack_push(s, v);
    }
    
    s = th[UnknownEnum.Value_3];
    n = ds_stack_size(s);
    w = array_create(n);
    buffer_write(b, buffer_u32, n);
    
    for (i = 0; i < n; i++)
        w[i] = ds_stack_pop(s);
    
    while (--i >= 0)
    {
        v = w[i];
        buffer_write(b, buffer_s32, v);
        ds_stack_push(s, v);
    }
    
    var m = th[UnknownEnum.Value_4];
    n = ds_map_size(m);
    buffer_write(b, buffer_u32, n);
    var v = ds_map_find_first(m);
    
    repeat (n)
    {
        txr_value_write(v, b);
        txr_value_write(ds_map_find_value(m, v), b);
        v = ds_map_find_next(m, v);
    }
    
    w = th[UnknownEnum.Value_0];
    n = array_length_1d(w);
    buffer_write(b, buffer_u32, n);
    
    for (i = 0; i < n; i++)
        txr_action_write(w[i], b);
}
