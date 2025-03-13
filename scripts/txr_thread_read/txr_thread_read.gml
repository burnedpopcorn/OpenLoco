function txr_thread_read(argument0)
{
    var b = argument0;
    var th = array_create(UnknownEnum.Value_7);
    array_set(th, UnknownEnum.Value_6, buffer_read(b, buffer_u8));
    array_set(th, UnknownEnum.Value_1, buffer_read(b, buffer_s32));
    array_set(th, UnknownEnum.Value_5, txr_value_read(b));
    var s = ds_stack_create();
    
    repeat (buffer_read(b, buffer_u32))
        ds_stack_push(s, txr_value_read(b));
    
    array_set(th, UnknownEnum.Value_2, s);
    s = ds_stack_create();
    
    repeat (buffer_read(b, buffer_u32))
        ds_stack_push(s, buffer_read(b, buffer_s32));
    
    array_set(th, UnknownEnum.Value_2, s);
    var m = ds_map_create();
    var n = buffer_read(b, buffer_u32);
    
    repeat (n)
    {
        var v = txr_value_read(b);
        ds_map_set(m, v, txr_value_read(b));
    }
    
    array_set(th, UnknownEnum.Value_4, m);
    n = buffer_read(b, buffer_u32);
    var w = array_create(n);
    
    for (var i = 0; i < n; i++)
        w[i] = txr_action_read(b);
    
    array_set(th, UnknownEnum.Value_0, w);
    return th;
}
