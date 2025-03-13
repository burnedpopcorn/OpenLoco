event_inherited();

canCollide = function(argument0 = obj_player)
{
    switch (argument0)
    {
        case obj_player:
        case obj_player1:
        case obj_player2:
            var _state = argument0.state;
            return _state == states.lawnmowerslide || _state == states.lawnmower || (_state == states.backbreaker && argument0.styledtaunting);
            break;
        
        default:
            return false;
            break;
    }
};
