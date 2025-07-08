switch (state)
{
    case states.normal:
        scr_enemy_idle();
        break;
    
    case states.bounce:
        scr_enemy_bounce();
        break;
    
    case states.capefall:
        scr_enemy_stun();
        break;
    
    case states.grabbed:
        scr_enemy_grabbed();
        break;
}

if (state == states.capefall && stunned > 40 && birdcreated == 0)
{
    birdcreated = 1;
    
    with (instance_create(x, y, obj_enemybird))
        ID = other.id;
}

if (state != states.capefall)
    birdcreated = 0;

if (state == states.normal && obj_player.x != x)
    image_xscale = sign(obj_player.x - x);

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != states.grabbed)
    depth = 0;

if (state != states.capefall)
    thrown = 0;
