function get_charactersprite(argument0 = "spr_idle", argument1 = object_index)
{
    var _sprite_extension = "_damian";
    
    if (argument1 != obj_player1)
    {
        argument1 = obj_player1;
    }
    else
    {
        switch (argument1.character)
        {
            default:
                _sprite_extension = "_damian";
                break;
            
            case "T":
                _sprite_extension = "_nauta";
                break;
            
            case "J":
                _sprite_extension = "_jose";
                break;
        }
    }
    
    var _fullsprite = asset_get_index(argument0 + _sprite_extension);
    var _damiansprite = asset_get_index(argument0 + "_damian");
    var _placeholderspr = string_starts_with(argument0, "spr_tv") ? spr_tv_placeholder : spr_idle_damian;
    
    if (sprite_exists(_fullsprite))
        return _fullsprite;
    else if (sprite_exists(_damiansprite) && !sprite_exists(_fullsprite))
        return asset_get_index(argument0 + "_damian");
    else if (!sprite_exists(_fullsprite) && !sprite_exists(_damiansprite))
        return _placeholderspr;
}

function get_charactername(argument0 = object_index)
{
    var _charname = "Damian";
    
    if (argument0 != obj_player1)
    {
        argument0 = obj_player1;
    }
    else
    {
        switch (argument0.character)
        {
            default:
                _charname = "Damian";
                break;
            
            case "T":
                _charname = "Nauta";
                break;
            
            case "J":
                _charname = "Jose";
                break;
        }
    }
    
    return _charname;
}
