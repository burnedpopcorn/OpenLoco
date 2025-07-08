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

if (state == states.capefall && (stunned > 40 && birdcreated == 0))
{
    birdcreated = 1;
    
    with (instance_create(x, y, obj_enemybird))
        ID = other.id;
}

if (state != states.capefall)
    birdcreated = 0;

idlespr = spr_capeend_damian;
stunfallspr = spr_bump_damian;
walkspr = spr_cape_damian;
stunspr = spr_bump_damian;
grabbedspr = spr_bump_damian;

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (hp <= 0)
    instance_destroy();

if (state != states.grabbed)
    depth = 0;

if (state != states.capefall)
    thrown = 0;

if (bombreset > 0)
    bombreset--;

if (x != obj_player.x && (state != states.throwing && bombreset == 0))
{
    if ((obj_player.x > (x - 400) && obj_player.x < (x + 400)) && (y <= (obj_player.y + 20) && y >= (obj_player.y - 20)))
    {
        if (state == states.actor || state == states.normal)
        {
            image_index = 0;
            image_xscale = -sign(x - obj_player.x);
            state = states.throwing;
        }
    }
}
