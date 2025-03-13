function txr_action_write(argument0, argument1)
{
    var a = argument0;
    var b = argument1;
    buffer_write(b, buffer_u8, a[0]);
    buffer_write(b, buffer_u32, a[1]);
    
    switch (a[0])
    {
        case UnknownEnum.Value_1:
            buffer_write(b, buffer_f64, a[2]);
            break;
        
        case UnknownEnum.Value_3:
            buffer_write(b, buffer_u8, a[2]);
            break;
        
        case UnknownEnum.Value_4:
            buffer_write(b, buffer_u8, a[2]);
            break;
        
        case UnknownEnum.Value_5:
            buffer_write(b, buffer_string, script_get_name(a[2]));
            buffer_write(b, buffer_u32, a[3]);
            break;
        
        case UnknownEnum.Value_6:
        case UnknownEnum.Value_7:
        case UnknownEnum.Value_18:
        case UnknownEnum.Value_20:
            break;
        
        case UnknownEnum.Value_8:
        case UnknownEnum.Value_9:
        case UnknownEnum.Value_14:
        case UnknownEnum.Value_17:
        case UnknownEnum.Value_12:
        case UnknownEnum.Value_13:
        case UnknownEnum.Value_21:
            buffer_write(b, buffer_s32, a[2]);
            break;
        
        case UnknownEnum.Value_10:
        case UnknownEnum.Value_11:
        case UnknownEnum.Value_2:
        case UnknownEnum.Value_15:
        case UnknownEnum.Value_16:
            buffer_write(b, buffer_string, a[2]);
            break;
        
        case UnknownEnum.Value_19:
            var w = a[2];
            var n = array_length_1d(w);
            buffer_write(b, buffer_u32, n);
            
            for (var i = 0; i < n; i++)
                buffer_write(b, buffer_s32, w[i]);
            
            buffer_write(b, buffer_s32, a[3]);
            break;
        
        default:
            show_error(txr_sfmt("Please add a writer for action type % to txr_action_write!", a[0]), 1);
    }
}
