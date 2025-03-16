switch (state)
{
    case baddiestates.idle:
        scr_enemy_idle();
        break;
    
    case baddiestates.charge:
        scr_enemy_charge();
        break;
    
    case baddiestates.turn:
        scr_enemy_turn();
        break;
    
    case states.actor:
        scr_enemy_walk();
        break;
    
    case baddiestates.land:
        scr_enemy_land();
        break;
    
    case baddiestates.hit:
        scr_enemy_hit();
        break;
    
    case baddiestates.stun:
        scr_enemy_stun();
        break;
    
    case baddiestates.throwing:
        scr_pizzagoblin_throw();
        break;
    
    case states.grabbed:
        scr_enemy_grabbed();
        break;
}

paletteselect = (global.laps >= 5) ? 2 : 1;

if (state == baddiestates.stun && (stunned > 100 && birdcreated == 0))
{
    birdcreated = 1;
    
    with (instance_create(x, y, obj_enemybird))
        ID = other.id;
}

if (state != baddiestates.stun)
    birdcreated = 0;

scr_scareenemy();

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (hitboxcreate == 0 && state == states.actor)
{
    hitboxcreate = 1;
    
    with (instance_create(x, y, obj_forkhitbox))
        ID = other.id;
}

if (state != states.grabbed)
    depth = 0;

if (state != baddiestates.stun)
    thrown = 0;

create_baddiecollisionbox();

if (movealarm > 0)
    movealarm--;
