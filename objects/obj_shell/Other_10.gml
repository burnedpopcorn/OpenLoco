variable_global_set("sh_help", function(argument0)
{
    if (array_length(argument0) > 1)
    {
        var helpFunction = argument0[1];
        
        if (_array_contains(allFunctions, helpFunction))
        {
            if (variable_struct_exists(functionData, helpFunction))
            {
                var metadata = variable_struct_get(functionData, helpFunction);
                var output = helpFunction;
                
                if (variable_struct_exists(metadata, "arguments"))
                {
                    for (var i = 0; i < array_length(metadata.arguments); i++)
                        output += (" " + metadata.arguments[i]);
                }
                
                if (variable_struct_exists(metadata, "description"))
                    output += (" - " + metadata.description);
                
                output += "\n";
                
                if (variable_struct_exists(metadata, "argumentDescriptions"))
                {
                    for (var i = 0; i < array_length(metadata.argumentDescriptions); i++)
                    {
                        var argName = metadata.arguments[i];
                        var desc = metadata.argumentDescriptions[i];
                        output += (argName + " - " + desc + "\n");
                    }
                }
                
                return output;
            }
            else
            {
                return helpFunction + "\nNo additional information present";
            }
        }
        else
        {
            return "No command [" + helpFunction + "] exists.";
        }
    }
    else
    {
        var output = "List of available commands:\n";
        var hiddenCount = 0;
        
        for (var i = 0; i < array_length(availableFunctions); i++)
        {
            var functionName = availableFunctions[i];
            var hidden = false;
            var metadata = variable_struct_get(functionData, functionName);
            
            if (!is_undefined(metadata))
            {
                if (variable_struct_exists(metadata, "hidden"))
                {
                    hidden = metadata.hidden;
                    hiddenCount += 1;
                }
            }
            
            if (!hidden)
            {
                var terminator = "";
                
                if (((i - hiddenCount) % 2) == 0)
                {
                    var paddingWidth = (width / 2) - (anchorMargin + string_width(functionName));
                    var spaceCount = paddingWidth / string_width(" ");
                    
                    repeat (spaceCount)
                        terminator += " ";
                }
                else
                {
                    terminator = "\n";
                }
                
                output += (functionName + terminator);
            }
        }
        
        return output;
    }
});
variable_global_set("meta_help", function()
{
    return 
    {
        arguments: ["<command name>"],
        suggestions: [availableFunctions],
        description: "display available commands",
        argumentDescriptions: ["optional name of a command to display detailed help information for."]
    };
});
variable_global_set("sh_clear", function(argument0)
{
    if (array_length(argument0) > 1 && argument0[1] == "all")
    {
        array_resize(output, 0);
        array_resize(history, 0);
        return "";
    }
    else
    {
        array_push(output, ">" + consoleString);
        draw_set_font(consoleFont);
        var _newLinesCount = floor(visibleHeight / string_height(prompt));
        
        repeat (_newLinesCount)
            array_push(output, "\n");
        
        return "";
    }
});
variable_global_set("meta_clear", function()
{
    return 
    {
        arguments: ["<all>"],
        suggestions: [["all"]],
        description: "clear the console window",
        argumentDescriptions: ["If provided, previous console output and command history will be deleted."]
    };
});
variable_global_set("sh_shell_set_width", function(argument0)
{
    if (array_length(argument0) > 1)
    {
        if (string_digits(argument0[1]) != "")
            width = real(string_digits(argument0[1]));
        else
            return "Invalid argument: " + argument0[1];
    }
    else
    {
        return "No argument provided.";
    }
});
variable_global_set("meta_shell_set_width", function()
{
    return 
    {
        description: "set the width of the console window",
        arguments: ["width"],
        argumentDescriptions: ["The desired width of the console, in pixels."]
    };
});
variable_global_set("sh_shell_set_height", function(argument0)
{
    if (array_length(argument0) > 1)
    {
        if (string_digits(argument0[1]) != "")
            height = real(string_digits(argument0[1]));
        else
            return "Invalid argument: " + argument0[1];
    }
    else
    {
        return "No argument provided.";
    }
});
variable_global_set("meta_shell_set_height", function()
{
    return 
    {
        description: "set the height of the console window",
        arguments: ["height"],
        argumentDescriptions: ["The desired height of the console, in pixels."]
    };
});
variable_global_set("sh_shell_set_anchor_v", function(argument0)
{
    if (array_length(argument0) > 1)
    {
        var newAnchor = argument0[1];
        
        if (newAnchor == "top" || newAnchor == "middle" || newAnchor == "bottom")
            screenAnchorPointV = newAnchor;
        else
            return "Invalid anchor point.\nPossible values: [top, middle, bottom]";
    }
    else
    {
        return "No argument provided.";
    }
});
variable_global_set("meta_shell_set_anchor_v", function()
{
    return 
    {
        description: "set the vertical anchor point of the console window",
        arguments: ["anchor"],
        suggestions: [["top", "middle", "bottom"]],
        argumentDescriptions: ["The desired vertical anchor point."]
    };
});
variable_global_set("sh_shell_set_anchor_h", function(argument0)
{
    if (array_length(argument0) > 1)
    {
        var newAnchor = argument0[1];
        
        if (newAnchor == "left" || newAnchor == "center" || newAnchor == "right")
            screenAnchorPointH = newAnchor;
        else
            return "Invalid anchor point.\nPossible values: [left, center, right]";
    }
    else
    {
        return "No argument provided.";
    }
});
variable_global_set("meta_shell_set_anchor_h", function()
{
    return 
    {
        description: "set the horizontal anchor point of the console window",
        arguments: ["anchor"],
        suggestions: [["left", "center", "right"]],
        argumentDescriptions: ["The desired horizontal anchor point."]
    };
});
