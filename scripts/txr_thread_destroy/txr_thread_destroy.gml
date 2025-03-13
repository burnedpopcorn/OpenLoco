function txr_thread_destroy(argument0)
{
    var th = argument0;
    
    if (th[UnknownEnum.Value_0] != undefined)
    {
        ds_stack_destroy(th[UnknownEnum.Value_2]);
        ds_stack_destroy(th[UnknownEnum.Value_3]);
        ds_map_destroy(th[UnknownEnum.Value_4]);
        array_set(th, UnknownEnum.Value_0, undefined);
        array_set(th, UnknownEnum.Value_6, UnknownEnum.Value_0);
    }
}
