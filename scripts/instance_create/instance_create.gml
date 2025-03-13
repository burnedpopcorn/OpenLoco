function instance_create(argument0, argument1, argument2)
{
    return instance_create_depth(argument0, argument1, object_get_depth(argument2), argument2);
}
