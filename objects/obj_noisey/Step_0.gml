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

if (global.miniboss == 0)
    instance_destroy();

if ((obj_player1.x > (x - 400) && obj_player1.x < (x + 400)) && (y <= (obj_player1.y + 60) && y >= (obj_player1.y - 60)))
{
    if (state != baddiestates.idle && obj_player1.state == states.mach3)
    {
        state = baddiestates.idle;
        sprite_index = scaredspr;
        
        if (x != obj_player1.x)
            image_xscale = -sign(x - obj_player1.x);
    }
}

if (instance_exists(obj_player2))
{
    if ((obj_player2.x > (x - 400) && obj_player2.x < (x + 400)) && (y <= (obj_player2.y + 60) && y >= (obj_player2.y - 60)))
    {
        if (state != baddiestates.idle && obj_player2.state == states.mach3)
        {
            state = baddiestates.idle;
            sprite_index = scaredspr;
            
            if (x != obj_player2.x)
                image_xscale = -sign(x - obj_player2.x);
        }
    }
}

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

if (state != baddiestates.grabbed)
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
