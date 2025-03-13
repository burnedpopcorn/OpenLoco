if (global.panic == 1 && global.fill > 0 && obj_camera.gettingfilltimer == 0 && !instance_exists(obj_ghostcollectibles) && !instance_exists(obj_specialdoor))
    global.fill -= 1;

if (global.fill <= 0 && global.panic == 1 && !instance_exists(obj_marx) && room_done == 0 && !instance_exists(obj_ghostcollectibles) && !instance_exists(obj_specialdoor))
{
    instance_create(obj_player1.x, obj_player1.y, obj_marx);
    room_done = 1;
}

floor(global.fill / 100);
