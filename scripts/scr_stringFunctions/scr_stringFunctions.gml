function string_extract(argument0, argument1, argument2)
{
    var len = string_length(argument1) - 1;
    
    repeat (argument2)
        argument0 = string_delete(argument0, 1, string_pos(argument1, argument0) + len);
    
    argument0 = string_delete(argument0, string_pos(argument1, argument0), string_length(argument0));
    return argument0;
}

function string_get_split(argument0, argument1)
{
    var slot = 0;
    var splits = [];
    var str2 = "";
    
    for (var i = 1; i < (string_length(argument0) + 1); i++)
    {
        var currStr = string_char_at(argument0, i);
        
        if (currStr == argument1)
        {
            if (str2 != "")
            {
                splits[slot] = str2;
                slot++;
            }
            
            str2 = "";
        }
        else
        {
            str2 = str2 + currStr;
            splits[slot] = str2;
        }
    }
    
    if (str2 == "")
        splits[slot] = str2;
    
    return splits;
}

function string_contains(argument0, argument1)
{
    if (string_length(argument1) > string_length(argument0))
        return false;
    
    return string_pos(argument1, argument0) != 0;
}

function string_startswith(argument0, argument1)
{
    if (string_length(argument1) > string_length(argument0))
        return false;
    
    return string_pos(argument1, argument0) == 1;
}

function string_endswith(argument0, argument1)
{
    if (string_length(argument1) > string_length(argument0))
        return false;
    
    return string_pos(argument1, argument0) == ((string_length(argument0) - string_length(argument1)) + 1);
}
