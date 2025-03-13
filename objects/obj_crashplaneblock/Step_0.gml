if (place_meeting(x, y + 1, obj_player) && !instance_exists(obj_crashingplane))
    instance_create(obj_player1.x, obj_player1.y, obj_crashingplane);
