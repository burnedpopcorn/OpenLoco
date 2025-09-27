function get_charactersprite(_sprite_name = "spr_idle", _player = object_index)
{
    var _sprite_extension = "_damian";
    
    if (_player != obj_player1)
        _player = obj_player1;
    else
    {
        switch (_player.character)
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
    
    var _fullsprite = asset_get_index(_sprite_name + _sprite_extension);
    var _damiansprite = asset_get_index(_sprite_name + "_damian");
    var _placeholderspr = string_starts_with(_sprite_name, "spr_tv") ? spr_tv_placeholder : spr_idle_damian;
    
    if (sprite_exists(_fullsprite))
        return _fullsprite;
    else if (sprite_exists(_damiansprite) && !sprite_exists(_fullsprite))
        return asset_get_index(_sprite_name + "_damian");
    else if (!sprite_exists(_fullsprite) && !sprite_exists(_damiansprite))
        return _placeholderspr;
}

function get_charactername(_player = object_index)
{
    var _charname = "Damian";
    
    if (_player != obj_player1)
        _player = obj_player1;
    else
    {
        switch (_player.character)
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
