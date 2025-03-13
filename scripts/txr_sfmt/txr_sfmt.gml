function txr_sfmt()
{
    var f = argument[0];
    var w = ds_map_find_value(global.txr_sfmt_map, f);
    var n;
    
    if (w == undefined)
    {
        w[0] = "";
        ds_map_set(global.txr_sfmt_map, f, w);
        var i = string_pos("%", f);
        n = 0;
        
        while (i)
        {
            w[n++] = string_copy(f, 1, i - 1);
            f = string_delete(f, 1, i);
            i = string_pos("%", f);
        }
        
        w[n++] = f;
    }
    else
    {
        n = array_length_1d(w);
    }
    
    var b = global.txr_sfmt_buf;
    buffer_seek(b, buffer_seek_start, 0);
    buffer_write(b, buffer_text, w[0]);
    var m = argument_count;
    
    for (var i = 1; i < n; i++)
    {
        if (i < m)
        {
            f = string(argument[i]);
            
            if (f != "")
                buffer_write(b, buffer_text, f);
        }
        
        f = w[i];
        
        if (f != "")
            buffer_write(b, buffer_text, f);
    }
    
    buffer_write(b, buffer_u8, 0);
    buffer_seek(b, buffer_seek_start, 0);
    return buffer_read(b, buffer_string);
}
