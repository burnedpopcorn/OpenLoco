function txr_init()
{
    global.txr_parse_tokens_val = ds_list_create();
    var ops = array_create(UnknownEnum.Value_112, "an operator");
    array_set(ops, UnknownEnum.Value_1, "*");
    array_set(ops, UnknownEnum.Value_2, "/");
    array_set(ops, UnknownEnum.Value_3, "%");
    array_set(ops, UnknownEnum.Value_4, "div");
    array_set(ops, UnknownEnum.Value_16, "+");
    array_set(ops, UnknownEnum.Value_17, "-");
    array_set(ops, UnknownEnum.Value_32, "<<");
    array_set(ops, UnknownEnum.Value_33, ">>");
    array_set(ops, UnknownEnum.Value_48, "&");
    array_set(ops, UnknownEnum.Value_49, "|");
    array_set(ops, UnknownEnum.Value_50, "^");
    array_set(ops, UnknownEnum.Value_64, "==");
    array_set(ops, UnknownEnum.Value_65, "!=");
    array_set(ops, UnknownEnum.Value_66, "<");
    array_set(ops, UnknownEnum.Value_67, "<=");
    array_set(ops, UnknownEnum.Value_68, ">");
    array_set(ops, UnknownEnum.Value_69, ">=");
    array_set(ops, UnknownEnum.Value_80, "&&");
    array_set(ops, UnknownEnum.Value_96, "||");
    global.txr_op_names = ops;
    global.txr_build_locals_val = ds_map_create();
    global.txr_function_map = ds_map_create();
    global.txr_compile_list_val = ds_list_create();
    global.txr_compile_labels_val = ds_map_create();
    global.txr_function_default_val = -1;
    global.txr_function_error_val = undefined;
    global.txr_thread_current_val = undefined;
    global.txr_exec_args = ds_list_create();
}
