if (is_undefined(location_map[? room]))
    exit;

with (target_icon)
{
    main = other.location_map[? room].icon;
    escape = other.location_map[? room].escape_icon;
}

details = location_map[? room].text;
alarm[0] = 1;
