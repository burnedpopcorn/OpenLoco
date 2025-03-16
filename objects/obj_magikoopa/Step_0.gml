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

if (state != baddiestates.stun)
    birdcreated = 0;

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != baddiestates.grabbed)
    depth = 0;

if (state != baddiestates.stun)
    thrown = 0;

scr_scareenemy();

if (bombreset > 0)
    bombreset--;

var p = instance_nearest(x, y, obj_player);

if (x != p.x && (p.state != UnknownEnum.Value_18 && (p.state != UnknownEnum.Value_24 && (state != UnknownEnum.Value_126 && (bombreset == 0 && grounded)))))
{
    if ((p.x > (x - 400) && p.x < (x + 400)) && (y <= (p.y + 20) && y >= (p.y - 20)))
    {
        if (state == baddiestates.walk)
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
