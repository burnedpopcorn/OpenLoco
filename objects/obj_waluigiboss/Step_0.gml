switch (state)
{
    case 144:
        break;
    
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
}

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

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
