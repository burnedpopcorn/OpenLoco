switch (state)
{
    case states.normal:
        scr_enemy_idle();
        break;
    
    case UnknownEnum.Value_109:
        scr_enemy_charge();
        break;
    
    case states.cape:
        scr_enemy_turn();
        break;
    
    case states.actor:
        scr_enemy_walk();
        break;
    
    case UnknownEnum.Value_108:
        scr_enemy_land();
        break;
    
    case UnknownEnum.Value_107:
        scr_enemy_hit();
        break;
    
    case states.capefall:
        scr_enemy_stun();
        break;
    
    case UnknownEnum.Value_97:
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

var p = instance_nearest(x, y, obj_player);

if (x != p.x && (p.state != UnknownEnum.Value_18 && (p.state != UnknownEnum.Value_24 && (state != UnknownEnum.Value_126 && (bombreset == 0 && grounded)))))
{
    if ((p.x > (x - 400) && p.x < (x + 400)) && (y <= (p.y + 20) && y >= (p.y - 20)))
    {
        if (state == states.actor)
        {
            image_index = 0;
            sprite_index = spr_pizzard_shoot;
            image_xscale = -sign(x - obj_player1.x);
            state = UnknownEnum.Value_126;
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
