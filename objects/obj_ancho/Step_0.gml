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

if (state != states.capefall)
    birdcreated = 0;

if (state == states.actor && (y > ystart && !scr_solid(x, y - 1)))
    y--;

if (state == states.actor && (y < ystart && !scr_solid(x, y + 1)))
    y++;

if (state == states.capefall)
    grav = 0.5;
else
    grav = 0;

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != states.grabbed)
    depth = 0;

scr_scareenemy();

if (sprite_index == spr_ancho_chargestart && floor(image_index) == (image_number - 1))
{
    if (hitboxcreate == 0 && state == states.charge)
    {
        hitboxcreate = 1;
        
        with (instance_create(x, y, obj_forkhitbox))
            ID = other.id;
    }
    
    sprite_index = spr_ancho_charge;
    movespeed = 10;
}

if (x != obj_player1.x && (state != states.charge && y == ystart))
{
    if ((obj_player1.x > (x - 200) && obj_player1.x < (x + 200)) && (y <= (obj_player1.y + 50) && y >= (obj_player1.y - 50)))
    {
        if (state == states.actor)
        {
            image_index = 0;
            image_xscale = -sign(x - obj_player.x);
            state = states.charge;
            sprite_index = spr_ancho_chargestart;
        }
    }
}

if (instance_exists(obj_player2))
{
    if (x != obj_player2.x && (state != states.charge && y == ystart))
    {
        if ((obj_player2.x > (x - 200) && obj_player2.x < (x + 200)) && (y <= (obj_player2.y + 50) && y >= (obj_player2.y - 50)))
        {
            if (state == states.actor)
            {
                image_index = 0;
                image_xscale = -sign(x - obj_player.x);
                state = states.charge;
                sprite_index = spr_ancho_chargestart;
            }
        }
    }
}

if (state == states.capefall || state == states.actor)
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
