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
    
    case states.cappythrow:
        scr_enemy_rage();
        break;
}

paletteselect = (global.laps >= 5) ? 1 : 0;

if (state == states.capefall && (stunned > 100 && birdcreated == 0))
{
    birdcreated = 1;
    
    with (instance_create(x, y, obj_enemybird))
        ID = other.id;
}

var player = instance_nearest(x, y, obj_player);
scr_scareenemy();

if (global.laps >= 5)
{
    var check = (image_xscale > 0) ? (player.x > x && player.x < (x + 200)) : (player.x < x && player.x > (x - 200));
    
    if (state == states.actor)
    {
        if (check && y <= (player.y + 60) && y >= (player.y - 60))
        {
            if (state != states.cappythrow && ragebuffer == 0)
            {
                state = states.cappythrow;
                sprite_index = ragespr;
                
                if (x != player.x)
                    image_xscale = -sign(x - player.x);
                
                ragebuffer = 100;
                image_index = 0;
                image_speed = 0.5;
                flash = 1;
                alarm[4] = 5;
            }
        }
    }
    
    if (ragebuffer > 0)
        ragebuffer--;
}

if (state != states.capefall)
    birdcreated = 0;

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != states.grabbed)
    depth = 0;

if (state != states.capefall)
    thrown = 0;

if (boundbox == 0)
{
    with (instance_create(x, y, obj_baddiecollisionbox))
    {
        sprite_index = other.sprite_index;
        mask_index = spr_marxhitbox;
        baddieID = other.id;
        other.boundbox = 1;
    }
}
