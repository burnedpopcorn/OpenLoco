switch (state)
{
    case states.normal:
        scr_enemy_idle();
        break;
    
    case states.charge:
        scr_enemy_charge();
        break;
    
    case states.cape:
        scr_enemy_turn();
        break;
    
    case states.actor:
        scr_enemy_walk();
        break;
    
    case states.land:
        scr_enemy_land();
        break;
    
    case states.hit:
        scr_enemy_hit();
        break;
    
    case states.capefall:
        scr_enemy_stun();
        break;
    
    case states.throwing:
        scr_pizzagoblin_throw();
        break;
    
    case states.grabbed:
        scr_enemy_grabbed();
        break;
}

if (state == states.capefall && (stunned > 100 && birdcreated == 0))
{
    birdcreated = 1;
    
    with (instance_create(x, y, obj_enemybird))
        ID = other.id;
}

if (state != states.grabbed)
    birdcreated = 0;

if (global.miniboss == 0)
    instance_destroy();

if ((obj_player1.x > (x - 400) && obj_player1.x < (x + 400)) && (y <= (obj_player1.y + 60) && y >= (obj_player1.y - 60)))
{
    if (state != states.normal && obj_player1.state == states.mach3)
    {
        state = states.normal;
        sprite_index = scaredspr;
        
        if (x != obj_player1.x)
            image_xscale = -sign(x - obj_player1.x);
    }
}

if (instance_exists(obj_player2))
{
    if ((obj_player2.x > (x - 400) && obj_player2.x < (x + 400)) && (y <= (obj_player2.y + 60) && y >= (obj_player2.y - 60)))
    {
        if (state != states.normal && obj_player2.state == states.mach3)
        {
            state = states.normal;
            sprite_index = scaredspr;
            
            if (x != obj_player2.x)
                image_xscale = -sign(x - obj_player2.x);
        }
    }
}

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

if (state != states.grabbed)
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
