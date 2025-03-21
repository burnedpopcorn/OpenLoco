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
    
    case baddiestates.walk:
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
    
    case baddiestates.grabbed:
        scr_enemy_grabbed();
        break;
}

if (state == baddiestates.stun && (stunned > 100 && birdcreated == 0))
{
    birdcreated = 1;
    
    with (instance_create(x, y, obj_enemybird))
        ID = other.id;
}

if (state != baddiestates.grabbed)
    birdcreated = 0;

if (state == baddiestates.stun)
    grav = 0.5;
else
    grav = 0;

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != baddiestates.grabbed)
    depth = 0;

scr_scareenemy();

if (((obj_player.x > (x - 400) && obj_player.x < (x + 400)) && (y + 200) > obj_player.y) && state != baddiestates.charge && state != baddiestates.grabbed && state != baddiestates.hit && state != baddiestates.stun && state != baddiestates.idle)
{
    if (state != baddiestates.charge)
    {
        state = baddiestates.charge;
        
        if (hitboxcreate == 0 && state == baddiestates.charge)
        {
            hitboxcreate = 1;
            
            with (instance_create(x, y, obj_forkhitbox))
                ID = other.id;
        }
        
        sprite_index = spr_piraneappleattack;
    }
}

if (state == baddiestates.stun || state == baddiestates.walk || state == baddiestates.idle)
    movespeed = 0;

if (state != baddiestates.stun)
    thrown = 0;

if (boundbox == 0)
{
    with (instance_create(x, y, obj_baddiecollisionbox))
    {
        sprite_index = other.sprite_index;
        mask_index = other.sprite_index;
        baddieID = other.id;
        other.boundbox = 1;
    }
}
