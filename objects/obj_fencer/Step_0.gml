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

scr_scareenemy();

if (x != obj_player1.x && grounded)
{
    if ((obj_player1.x > (x - 400) && obj_player1.x < (x + 400)) && (y <= (obj_player1.y + 60) && y >= (obj_player1.y - 60)))
    {
        if (state == baddiestates.walk && charging == 0)
        {
            with (instance_create(x, y, obj_forkhitbox))
                ID = other.id;
            
            charging = 1;
            state = baddiestates.charge;
            movespeed = 5;
            vsp = -7;
            fmod_studio_event_oneshot_3d("event:/sfx/enemy/charge");
            sprite_index = spr_fencer_chargestart;
        }
    }
}

if (instance_exists(obj_player2))
{
    if (x != obj_player2.x && grounded)
    {
        if ((obj_player2.x > (x - 400) && obj_player2.x < (x + 400)) && (y <= (obj_player2.y + 20) && y >= (obj_player2.y - 20)))
        {
            if (state == baddiestates.walk && charging == 0)
            {
                with (instance_create(x, y, obj_forkhitbox))
                    ID = other.id;
                
                charging = 1;
                state = baddiestates.charge;
                movespeed = 5;
                vsp = -7;
                sprite_index = spr_fencer_chargestart;
            }
        }
    }
}

if (state == baddiestates.stun || state == baddiestates.walk)
{
    charging = 0;
    movespeed = 0;
}

if (sprite_index == spr_fencer_chargestart && floor(image_index) == (image_number - 1))
    sprite_index = spr_fencer_charge;

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (hitboxcreate == 0 && state == baddiestates.walk)
{
    hitboxcreate = 1;
    
    with (instance_create(x, y, obj_forkhitbox))
        ID = other.id;
}

if (state != baddiestates.grabbed)
    depth = 0;

if (state != baddiestates.stun)
    thrown = 0;

if (boundbox == 0)
{
    with (instance_create(x, y, obj_baddiecollisionbox))
    {
        sprite_index = other.sprite_index;
        baddieID = other.id;
        other.boundbox = 1;
    }
}
