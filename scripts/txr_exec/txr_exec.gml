function txr_exec()
{
    var arr = argument[0];
    var argd = (argument_count > 1) ? argument[1] : undefined;
    var th = txr_thread_create(arr, argd);
    var result = undefined;
    
    switch (txr_thread_resume(th))
    {
        case UnknownEnum.Value_2:
            global.txr_error_val = "";
            result = th[UnknownEnum.Value_5];
            break;
        
        case UnknownEnum.Value_3:
            global.txr_error_val = th[UnknownEnum.Value_5];
            break;
        
        default:
            global.txr_error_val = "Thread paused execution but you are using txr_exec instead of txr_thread_resume";
            break;
    }
    
    txr_thread_destroy(th);
    return result;
}
