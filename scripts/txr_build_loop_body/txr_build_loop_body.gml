function txr_build_loop_body()
{
    var could_break = global.txr_build_can_break_val;
    var could_continue = global.txr_build_can_continue_val;
    global.txr_build_can_break_val = true;
    global.txr_build_can_continue_val = true;
    var trouble = txr_build_stat();
    global.txr_build_can_break_val = could_break;
    global.txr_build_can_continue_val = could_continue;
    return trouble;
}
