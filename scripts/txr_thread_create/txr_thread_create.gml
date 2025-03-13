function txr_thread_create()
{
    var arr = argument[0];
    var argd = (argument_count > 1) ? argument[1] : undefined;
    var th = array_create(UnknownEnum.Value_7);
    array_set(th, UnknownEnum.Value_0, arr);
    array_set(th, UnknownEnum.Value_1, 0);
    array_set(th, UnknownEnum.Value_2, ds_stack_create());
    array_set(th, UnknownEnum.Value_3, ds_stack_create());
    var locals = ds_map_create();
    
    if (argd != undefined)
    {
        if (is_array(argd))
        {
            var i = array_length_1d(argd);
            ds_map_set(locals, "argument_count", i);
            ds_map_set(locals, "argument", argd);
            
            while (--i >= 0)
                ds_map_set(locals, "argument" + string(i), argd[i]);
        }
        else
        {
            ds_map_copy(locals, argd);
        }
    }
    
    array_set(th, UnknownEnum.Value_4, locals);
    array_set(th, UnknownEnum.Value_6, UnknownEnum.Value_1);
    return th;
}
