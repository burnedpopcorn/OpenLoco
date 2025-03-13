function txr_program_write(argument0, argument1)
{
    var w = argument0;
    var b = argument1;
    var n = array_length_1d(w);
    buffer_write(b, buffer_u32, n);
    
    for (var i = 0; i < n; i++)
        txr_action_write(w[i], b);
    
    return b;
}
