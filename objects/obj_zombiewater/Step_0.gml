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

if (state == states.capefall)
    grav = 0.5;
else
    grav = 0;

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != states.grabbed)
    depth = 0;

scr_scareenemy();

if (((obj_player.x > (x - 400) && obj_player.x < (x + 400)) && (y + 200) > obj_player.y) && state != states.charge && state != states.grabbed && state != states.hit && state != states.capefall && state != states.normal)
{
    if (state != states.charge)
    {
        state = states.charge;
        
        if (hitboxcreate == 0 && state == states.charge)
        {
            hitboxcreate = 1;
            
            with (instance_create(x, y, obj_forkhitbox))
                ID = other.id;
        }
        
        sprite_index = spr_piraneappleattack;
    }
}

if (state == states.capefall || state == states.actor || state == states.normal)
    movespeed = 0;

if (state != states.capefall)
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
