function txr_program_print(argument0)
{
    var pg = argument0;
    var n = array_length_1d(pg);
    var nn = string_length(string(n));
    var b = global.txr_program_print_buf;
    buffer_seek(b, buffer_seek_start, 0);
    
    for (var i = 0; i < n; i++)
    {
        var ist = string(i);
        
        repeat (nn - string_length(ist))
            buffer_write(b, buffer_u8, 32);
        
        buffer_write(b, buffer_text, ist);
        buffer_write(b, buffer_u8, 32);
        buffer_write(b, buffer_text, txr_action_print(pg[i]));
        buffer_write(b, buffer_u8, 13);
        buffer_write(b, buffer_u8, 10);
    }
    
    buffer_write(b, buffer_u8, 0);
    buffer_seek(b, buffer_seek_start, 0);
    return buffer_read(b, buffer_string);
}
