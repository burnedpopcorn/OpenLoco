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

idlespr = spr_pizzagoblin_idle;
stunfallspr = spr_pizzagoblin_stun;
walkspr = spr_pizzagoblin_walk;
stunspr = spr_pizzagoblin_stun;
grabbedspr = spr_pizzagoblin_stun;
scr_scareenemy();

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != states.grabbed)
    depth = 0;

if (state != states.capefall)
    thrown = 0;

if (bombreset > 0)
    bombreset--;

if (x != obj_player1.x && (obj_player1.state != states.bombpep && (state != states.throwing && (bombreset == 0 && grounded))))
{
    if ((obj_player1.x > (x - 400) && obj_player1.x < (x + 400)) && (y <= (obj_player1.y + 20) && y >= (obj_player1.y - 20)))
    {
        if (state == states.actor || state == states.normal)
        {
            image_index = 0;
            image_xscale = -sign(x - obj_player1.x);
            state = states.throwing;
        }
    }
}

if (instance_exists(obj_player2))
{
    if (x != obj_player2.x && (obj_player2.state != states.bombpep && (state != states.throwing && (bombreset == 0 && grounded))))
    {
        if ((obj_player2.x > (x - 400) && obj_player2.x < (x + 400)) && (y <= (obj_player2.y + 20) && y >= (obj_player2.y - 20)))
        {
            if (state == states.actor || state == states.normal)
            {
                image_index = 0;
                image_xscale = -sign(x - obj_player2.x);
                state = states.throwing;
            }
        }
    }
}

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
