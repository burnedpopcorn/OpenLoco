function reload_langfile()
{
    ds_map_clear(global.languagemap);
    var file = file_text_open_read(string("languages/language_{0}.txt", global.language));
    
    while (!file_text_eof(file))
    {
        var line = file_text_readln(file);
        
        if (line != "" && !string_starts_with(line, "//") && string_pos("=", line))
        {
            var arr = string_split(line, "=", true);
            
            for (var i = 0; i < array_length(arr); i++)
                arr[i] = string_trim(arr[i]);
            
            var name = arr[0];
            var val = arr[1];
            
            if (val == "true")
                val = true;
            
            if (val == "false")
                val = false;
            
            if (string_letters(val) == "" && string_characters(val) == "" && string_digits(val) != "")
                val = real(val);
            
            ds_map_add(global.languagemap, name, val);
        }
    }
    
    file_text_close(file);
}

function embed_value_string(argument0, argument1)
{
    var str_copy = string_copy(argument0, 1, string_length(argument0));
    
    for (var i = 0; i < array_length(argument1); i++)
    {
        var b = string(argument1[i]);
        str_copy = string_replace(str_copy, "%", b);
    }
    
    return str_copy;
}

function langstr_get(argument0)
{
    var r = global.languagemap[? argument0];
    
    if (r == undefined)
    {
        trace("failed to fetch lang string: ", argument0);
        return argument0;
    }
    
    return r;
}

function string_characters(argument0)
{
    if (!is_string(argument0))
        return "";
    
    var output = "";
    
    for (var i = 1; i < (string_length(argument0) + 1); i++)
    {
        var ch = string_char_at(argument0, i);
        
        if (string_letters(ch) == "" && string_digits(ch) == "")
            output += ch;
    }
    
    return output;
}
