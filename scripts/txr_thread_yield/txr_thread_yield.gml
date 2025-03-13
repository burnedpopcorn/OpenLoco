function txr_thread_yield()
{
    var th = global.txr_thread_current_val;
    
    if (th != undefined)
    {
        array_set(th, UnknownEnum.Value_6, UnknownEnum.Value_4);
        return th;
    }
    else
    {
        return undefined;
    }
}
