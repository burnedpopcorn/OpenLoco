if (is_undefined(ds_map_find_value(location_map, room)))
    exit;

with (target_icon)
{
    main = ds_map_find_value(other.location_map, room).icon;
    escape = ds_map_find_value(other.location_map, room).escape_icon;
}

details = ds_map_find_value(location_map, room).text;
alarm[0] = 1;
