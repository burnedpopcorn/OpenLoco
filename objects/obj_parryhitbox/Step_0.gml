lifespan--;
var _player = obj_player1;

if (player_id == 2)
    _player = obj_player2;

if (_player.state != states.backbreaker || lifespan <= 0)
    instance_destroy();
