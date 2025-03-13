function txr_action_read(argument0)
{
    var b = argument0;
    var t = buffer_read(b, buffer_u8);
    var p = buffer_read(b, buffer_u32);
    
    switch (t)
    {
        case UnknownEnum.Value_1:
            return [t, p, buffer_read(b, buffer_f64)];
        
        case UnknownEnum.Value_3:
        case UnknownEnum.Value_4:
            return [t, p, buffer_read(b, buffer_u8)];
        
        case UnknownEnum.Value_5:
            var q = asset_get_index(buffer_read(b, buffer_string));
            return [t, p, q, buffer_read(b, buffer_u32)];
        
        case UnknownEnum.Value_6:
        case UnknownEnum.Value_7:
        case UnknownEnum.Value_18:
        case UnknownEnum.Value_20:
            return [t, p];
        
        case UnknownEnum.Value_8:
        case UnknownEnum.Value_9:
        case UnknownEnum.Value_14:
        case UnknownEnum.Value_17:
        case UnknownEnum.Value_12:
        case UnknownEnum.Value_13:
        case UnknownEnum.Value_21:
            return [t, p, buffer_read(b, buffer_s32)];
            break;
        
        case UnknownEnum.Value_10:
        case UnknownEnum.Value_11:
        case UnknownEnum.Value_2:
        case UnknownEnum.Value_15:
        case UnknownEnum.Value_16:
            return [t, p, buffer_read(b, buffer_string)];
            break;
        
        case UnknownEnum.Value_19:
            var n = buffer_read(b, buffer_u32);
            var w = array_create(n);
            
            for (var i = 0; i < n; i++)
                w[i] = buffer_read(b, buffer_s32);
            
            return [t, p, w, buffer_read(b, buffer_s32)];
        
        default:
            show_error(txr_sfmt("Please add a read for action type % to txr_action_read!", t), 1);
    }
}
