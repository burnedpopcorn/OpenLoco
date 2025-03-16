switch (state)
{
    case baddiestates.idle:
        scr_enemy_idle();
        break;
    
    case UnknownEnum.Value_1:
        scr_enemy_bounce();
        break;
    
    case baddiestates.stun:
        scr_enemy_stun();
        break;
    
    case states.grabbed:
        scr_enemy_grabbed();
        break;
}

if (state == baddiestates.stun && stunned > 40 && birdcreated == 0)
{
    birdcreated = 1;
    
    with (instance_create(x, y, obj_enemybird))
        ID = other.id;
}

if (state != baddiestates.stun)
    birdcreated = 0;

if (state == baddiestates.idle && obj_player.x != x)
    image_xscale = sign(obj_player.x - x);

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != states.grabbed)
    depth = 0;

if (state != baddiestates.stun)
    thrown = 0;
