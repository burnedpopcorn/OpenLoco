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

if (state == baddiestates.stun && (stunned > 40 && birdcreated == 0))
{
    birdcreated = 1;
    
    with (instance_create(x, y, obj_enemybird))
        ID = other.id;
}

if (state != baddiestates.stun)
    birdcreated = 0;

if (hitboxcreate == 0 && (state == baddiestates.charge && (obj_player.state != states.mach3 && obj_player.state != states.mach2)))
{
    hitboxcreate = 1;
    
    with (instance_create(x, y, obj_forkhitbox))
    {
        sprite_index = spr_player_mask;
        ID = other.id;
    }
}

if (attack == 0)
    sprite_index = spr_mii;

if (attack == 0 && (state != baddiestates.grabbed && state != baddiestates.grabbed))
{
    state = baddiestates.idle;
    roaming = 0;
}

if (state != baddiestates.idle)
    roaming = 1;

if (x != obj_player.x)
{
    if ((obj_player.x > (x - 200) && obj_player.x < (x + 200)) && obj_player.y == y)
    {
        if (state == baddiestates.walk || state == baddiestates.idle)
        {
            if (sprite_index == spr_mii)
                instance_create(x, y, obj_balloonpop);
            
            image_xscale = -sign(x - obj_player.x);
            roaming = 1;
            attack = 1;
            vsp = -11;
            image_index = 0;
            image_xscale = -sign(x - obj_player.x);
            state = baddiestates.charge;
        }
    }
}

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != baddiestates.grabbed)
    depth = 0;

if (state != baddiestates.stun)
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
