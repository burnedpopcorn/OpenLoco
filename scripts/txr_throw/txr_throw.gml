function txr_throw(argument0, argument1)
{
    global.txr_error_val = argument0 + " at " + string(argument1);
    return true;
}
