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

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != states.grabbed)
    depth = 0;

if (state != states.capefall)
    thrown = 0;

scr_scareenemy();

if (bombreset > 0)
    bombreset--;

if (x != obj_player1.x && (state != states.throwing && ((obj_player1.state != states.tumble && obj_player1.state != states.slipbanana) && (bombreset == 0 && grounded))))
{
    if ((obj_player1.x > (x - 80) && obj_player1.x < (x + 80)) && (y <= (obj_player1.y + 100) && y >= (obj_player1.y - 100)))
    {
        if (state == states.actor)
        {
            if (!(global.laps >= 5))
            {
                image_index = 0;
                sprite_index = spr_pepgoblin_kick;
                image_xscale = -sign(x - obj_player1.x);
                state = states.throwing;
            }
            else
            {
                image_index = 0;
                sprite_index = spr_pepgoblin_kick;
                image_xscale = -sign(x - obj_player1.x);
                flash = 1;
                alarm[4] = 5;
                state = states.throwing;
            }
        }
    }
}

if (grounded && (state == states.throwing && floor(image_index) == 3))
    vsp = -5;

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
