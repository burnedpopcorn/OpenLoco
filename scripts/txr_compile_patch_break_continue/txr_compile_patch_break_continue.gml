function txr_compile_patch_break_continue(argument0, argument1, argument2, argument3)
{
    var start = argument0;
    var till = argument1;
    var _break = argument2;
    var _continue = argument3;
    var out = global.txr_compile_list_val;
    
    for (var i = start; i < till; i++)
    {
        var act = ds_list_find_value(out, i);
        
        if (act[0] == UnknownEnum.Value_8)
        {
            switch (act[2])
            {
                case -10:
                    if (_break >= 0)
                        array_set(act, 2, _break);
                    
                    break;
                
                case -11:
                    if (_continue >= 0)
                        array_set(act, 2, _continue);
                    
                    break;
            }
        }
    }
}
