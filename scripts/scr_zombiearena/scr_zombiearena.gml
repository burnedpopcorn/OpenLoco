function tombstone_wave_add(argument0, argument1)
{
    if (argument_count > 2)
    {
        for (var i = 1; i < argument_count; i++)
            array_push(argument0, argument[i]);
    }
    else
        array_push(argument0, argument1);
}

function tombstone_wave_create(argument0)
{
    ds_list_add(content_list, []);
    return content_list[| argument0];
}
