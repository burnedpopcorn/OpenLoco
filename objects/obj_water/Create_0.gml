image_alpha = 0.5;
image_speed = 0.35;
depth = -10;
idstill = 0;
waterbuffer = 0;

canCollide = function(argument0 = obj_player)
{
    switch (argument0)
    {
        case obj_player:
        case obj_player1:
        case obj_player2:
            var _state = argument0.state;
            return _state == states.mach3 || (argument0.state == states.machslide && argument0.sprite_index == get_charactersprite("spr_machslideboost3"));
            break;
        
        default:
            return false;
            break;
    }
};
