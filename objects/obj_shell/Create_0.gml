depth = -9999;
isOpen = false;
isAutocompleteOpen = false;
shellSurface = -4;
scrollSurface = -4;
shellOriginX = 0;
shellOriginY = 0;
visibleWidth = 0;
visibleHeight = 0;
cursorPos = 1;
consoleString = "";
savedConsoleString = "";
scrollPosition = 0;
maxScrollPosition = 0;
targetScrollPosition = 0;
commandSubmitted = false;
insertMode = true;
historyPos = 0;
history = [];
output = [];
outputHeight = 0;
filteredSuggestions = [];
inputArray = [];
suggestionIndex = 0;
autocompleteMaxWidth = 0;
autocompleteScrollPosition = 0;
autocompleteOriginX = 0;
autocompleteOriginY = 0;
mousePreviousX = device_mouse_x_to_gui(0);
mousePreviousY = device_mouse_y_to_gui(0);
shellPropertiesHash = "";
killedString = "";
metaDeleted = false;
metaMovedLeft = false;
metaMovedRight = false;
deferredQueue = ds_queue_create();
savedHistoryFilePath = working_directory + "rt-shell-saved-history.data";
loadedSavedHistory = false;
loadedHistoryScrolled = false;
activeMouseArgType = undefined;
activeMouseArgValue = "";
event_user(0);

if (instance_number(object_index) > 1)
    instance_destroy();

function open()
{
    isOpen = true;
    keyboard_string = "";
    
    if (!is_undefined(openFunction))
        openFunction();
}

function close()
{
    isOpen = false;
    
    if (!is_undefined(closeFunction))
        closeFunction();
    
    while (!ds_queue_empty(deferredQueue))
    {
        var args = ds_queue_dequeue(deferredQueue);
        _execute_script(args, true);
    }
    
    if (saveHistory)
        _save_history();
}

function _close_autocomplete()
{
    array_resize(filteredSuggestions, 0);
}

availableFunctions = [];
allFunctions = [];
functionData = {};
var globalVariables = variable_instance_get_names(global);

for (var i = 0; i < array_length(globalVariables); i++)
{
    if (string_pos("meta_", string_lower(globalVariables[i])) == 1)
    {
        var name = string_delete(string_lower(globalVariables[i]), 1, 5);
        variable_struct_set(functionData, name, variable_instance_get(global, globalVariables[i])());
    }
}

for (var i = 0; i < array_length(globalVariables); i++)
{
    if (string_pos("sh_", string_lower(globalVariables[i])) == 1)
    {
        var name = string_delete(string_lower(globalVariables[i]), 1, 3);
        var hidden = false;
        var metadata = variable_struct_get(functionData, name);
        
        if (!is_undefined(metadata))
        {
            if (variable_struct_exists(metadata, "hidden"))
                hidden = metadata.hidden;
        }
        
        if (!hidden)
            array_push(availableFunctions, name);
        
        array_push(allFunctions, name);
    }
    
    array_sort(availableFunctions, true);
}

function _update_filtered_suggestions()
{
    array_resize(filteredSuggestions, 0);
    autocompleteMaxWidth = 0;
    suggestionIndex = 0;
    activeMouseArgType = undefined;
    var inputString = string(consoleString);
    inputArray = _input_string_split(inputString);
    
    if (string_length(inputString) == 0 || array_length(inputArray) == 0)
        exit;
    
    draw_set_font(consoleFont);
    var spaceCount = array_length(inputArray) - 1;
    
    if (spaceCount == 0)
    {
        for (var i = 0; i < array_length(availableFunctions); i++)
        {
            if (string_pos(inputString, availableFunctions[i]) == 1 && inputString != availableFunctions[i])
            {
                array_push(filteredSuggestions, availableFunctions[i]);
                autocompleteMaxWidth = max(autocompleteMaxWidth, string_width(availableFunctions[i]));
            }
        }
    }
    else
    {
        var functionName = inputArray[0];
        var argumentIndex = spaceCount - 1;
        var dataExists = variable_struct_exists(functionData, functionName);
        var noExtraSpace = string_char_at(inputString, string_last_pos(" ", inputString) - 1) != " ";
        
        if (dataExists && noExtraSpace && spaceCount <= array_length(inputArray))
        {
            var suggestionData = struct_get_from_hash(variable_struct_get(functionData, array_get(inputArray, 0)), variable_get_hash("suggestions"));
            var argumentSuggestions = [];
            
            if (argumentIndex < array_length(suggestionData))
            {
                if (is_array(suggestionData[argumentIndex]))
                    argumentSuggestions = suggestionData[argumentIndex];
                else if (is_method(suggestionData[argumentIndex]))
                    argumentSuggestions = suggestionData[argumentIndex]();
                else if (is_int64(suggestionData[argumentIndex]))
                    activeMouseArgType = suggestionData[argumentIndex];
                
                var currentArgument = inputArray[array_length(inputArray) - 1];
                
                for (var i = 0; i < array_length(argumentSuggestions); i++)
                {
                    var prefixMatch = string_pos(currentArgument, string_lower(argumentSuggestions[i])) == 1;
                    
                    if (string_last_pos(" ", inputString) == string_length(inputString) || prefixMatch)
                    {
                        array_push(filteredSuggestions, argumentSuggestions[i]);
                        autocompleteMaxWidth = max(autocompleteMaxWidth, string_width(argumentSuggestions[i]));
                    }
                }
            }
        }
    }
    
    autocompleteScrollPosition = 0;
    array_sort(filteredSuggestions, true);
}

function _find_common_prefix()
{
    if (array_length(filteredSuggestions) == 0)
        return "";
    
    var first = string(filteredSuggestions[0]);
    var last = string(filteredSuggestions[array_length(filteredSuggestions) - 1]);
    var result = "";
    var spaceCount = string_count(" ", consoleString);
    
    if (spaceCount > 0)
    {
        for (var i = 0; i < spaceCount; i++)
            result += (inputArray[i] + " ");
    }
    
    for (var i = 1; i < (string_length(first) + 1); i++)
    {
        if (string_char_at(first, i) == string_char_at(last, i))
            result += string_char_at(first, i);
        else
            break;
    }
    
    return result;
}

function _key_combo_pressed(argument0, argument1)
{
    for (var i = 0; i < array_length(argument0); i++)
    {
        if (!keyboard_check(argument0[i]))
            return false;
    }
    
    if (keyboard_check_pressed(argument1))
    {
        if (array_length(argument0) == 0)
        {
            if (keyboard_check(vk_shift) || keyboard_check(vk_control) || keyboard_check(vk_alt))
                return false;
        }
        
        return true;
    }
}

delayFrame = 0;
delayFrames = 1;

function _keyboard_check_delay(argument0)
{
    if (keyboard_check_released(argument0))
    {
        delayFrame = 0;
        delayFrames = 1;
        return false;
    }
    else if (!keyboard_check(argument0))
    {
        return false;
    }
    
    delayFrame = (delayFrame + 1) % delayFrames;
    
    if (delayFrame == 0)
        delayFrames = keyRepeatDelay;
    
    if (keyboard_check_pressed(argument0))
    {
        delayFrame = 0;
        delayFrames = keyRepeatInitialDelay;
        return true;
    }
    else if (keyboard_check(argument0) && delayFrame == 0)
    {
        return true;
    }
    
    return false;
}

function _shell_properties_hash()
{
    return md5_string_unicode(string(width) + "~" + string(height) + "~" + string(anchorMargin) + "~" + string(consolePaddingH) + "~" + string(scrollbarWidth) + "~" + string(consolePaddingV) + "~" + string(screenAnchorPointH) + "~" + string(screenAnchorPointV));
}

function _recalculate_shell_properties()
{
    var screenCenterX = display_get_gui_width() / 2;
    var screenCenterY = display_get_gui_height() / 2;
    draw_set_font(consoleFont);
    var emHeight = string_height("M");
    var maxWidth = display_get_gui_width() - (anchorMargin * 2);
    var maxHeight = display_get_gui_height() - (anchorMargin * 2);
    width = clamp(width, 50, maxWidth);
    height = clamp(height, emHeight, maxHeight);
    var halfWidth = width / 2;
    var halfHeight = height / 2;
    
    switch (screenAnchorPointH)
    {
        case "left":
            shellOriginX = anchorMargin - 1;
            break;
        
        case "center":
            shellOriginX = screenCenterX - halfWidth - 1;
            break;
        
        case "right":
            shellOriginX = display_get_gui_width() - width - anchorMargin - 1;
            break;
    }
    
    switch (screenAnchorPointV)
    {
        case "top":
            shellOriginY = anchorMargin - 1;
            break;
        
        case "middle":
            shellOriginY = screenCenterY - halfHeight - 1;
            break;
        
        case "bottom":
            shellOriginY = display_get_gui_height() - height - anchorMargin - 1;
            break;
    }
    
    visibleWidth = width - (2 * anchorMargin) - scrollbarWidth - (2 * consolePaddingH);
    visibleHeight = height - (2 * consolePaddingV);
    shellPropertiesHash = _shell_properties_hash();
}

function _calculate_scroll_from_suggestion_index()
{
    if (suggestionIndex == 0)
        autocompleteScrollPosition = 0;
    else if (suggestionIndex >= (autocompleteScrollPosition + autocompleteMaxLines))
        autocompleteScrollPosition = max(0, (suggestionIndex - autocompleteMaxLines) + 1);
    else if (suggestionIndex < autocompleteScrollPosition)
        autocompleteScrollPosition -= suggestionIndex;
}

function _confirm_current_suggestion()
{
    var spaceCount = string_count(" ", consoleString);
    consoleString = "";
    
    for (var i = 0; i < spaceCount; i++)
        consoleString += (inputArray[i] + " ");
    
    consoleString += (filteredSuggestions[suggestionIndex] + " ");
    cursorPos = string_length(consoleString) + 1;
}

function _confirm_current_mouse_argument_data()
{
    if (activeMouseArgValue != "")
    {
        consoleString += (string(activeMouseArgValue) + " ");
        cursorPos = string_length(consoleString) + 1;
    }
}

function _execute_script(argument0, argument1 = false)
{
    var script = variable_global_get("sh_" + argument0[0]);
    
    if (!is_undefined(script))
    {
        var response;
        
        try
        {
            response = script_execute(asset_get_index(script_get_name(script)), argument0);
        }
        catch (_exception)
        {
            response = "-- ERROR: see debug output for details --";
            show_debug_message("---- ERROR executing rt-shell command [" + argument0[0] + "] ----");
            show_debug_message(self._exception.message);
            show_debug_message(self._exception.longMessage);
            show_debug_message(self._exception.script);
            show_debug_message(self._exception.stacktrace);
            show_debug_message("----------------------------");
        }
        
        if (!argument1)
        {
            array_push(history, consoleString);
            
            if (response != "")
                array_push(output, ">" + consoleString);
        }
        
        if (is_string(response))
            array_push(output, response);
        
        _update_positions();
    }
    else
    {
        array_push(output, ">" + consoleString);
        array_push(output, "No such command: " + consoleString);
        array_push(history, consoleString);
        _update_positions();
    }
}

function _update_positions()
{
    historyPos = array_length(history);
    consoleString = "";
    savedConsoleString = "";
    cursorPos = 1;
}

function _save_history()
{
    var truncatedHistory = [];
    var truncatedOutput = [];
    array_copy(truncatedHistory, 0, history, max(0, array_length(history) - savedHistoryMaxSize), min(array_length(history), savedHistoryMaxSize));
    array_copy(truncatedOutput, 0, output, max(0, array_length(output) - savedHistoryMaxSize), min(array_length(output), savedHistoryMaxSize));
    var toSave = 
    {
        history: truncatedHistory,
        output: truncatedOutput
    };
    var openFile = file_text_open_write(savedHistoryFilePath);
    file_text_write_string(openFile, json_stringify(toSave));
    file_text_close(openFile);
}

function _load_history()
{
    var saveDataFile = file_find_first(savedHistoryFilePath, 16);
    
    if (saveDataFile != "")
    {
        var openFile = file_text_open_read(savedHistoryFilePath);
        var tempData = json_parse(file_text_read_string(openFile));
        file_text_close(openFile);
        history = tempData.history;
        output = tempData.output;
        historyPos = array_length(history);
    }
}

function _input_string_split(argument0)
{
    var slot = 0;
    var splits = [];
    var str2 = "";
    var inQuotes = false;
    
    for (var i = 1; i < (string_length(argument0) + 1); i++)
    {
        var currStr = string_char_at(argument0, i);
        
        if (!inQuotes)
        {
            if (currStr == "\"")
            {
                inQuotes = true;
                continue;
            }
            
            if (currStr == " ")
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
        else if (currStr == "\"")
        {
            inQuotes = false;
            splits[slot] = str2;
        }
        else
        {
            str2 = str2 + currStr;
        }
    }
    
    if (str2 == "" || inQuotes)
        splits[slot] = str2;
    
    return splits;
}

function _array_contains(argument0, argument1)
{
    for (var i = 0; i < array_length(argument0); i++)
    {
        if (argument0[i] == argument1)
            return true;
    }
    
    return false;
}

function _remap(argument0, argument1, argument2, argument3, argument4)
{
    var _t = (argument0 - argument1) / (argument2 - argument1);
    return lerp(argument3, argument4, _t);
}
