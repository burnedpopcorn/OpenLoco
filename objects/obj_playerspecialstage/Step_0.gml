scr_getinput();

switch (state)
{
    case 0:
        scr_specialplayer_normal();
        break;
    
    case 1:
        scr_specialplayer_slide();
        break;
    
    case 2:
        scr_specialplayer_climbwall();
        break;
    
    case 3:
        scr_specialplayer_bump();
        break;
    
    case 4:
        scr_specialplayer_actor();
        break;
    
    case 5:
        scr_specialplayer_punch();
        break;
    
    case 6:
        scr_specialplayer_death();
        break;
}

xH = Approach(xH, 0, 0.2);
yH = Approach(yH, 0, 0.2);

if (global.anglerotation == true)
    scr_angleplayerspecial_rotate();

if (state == 5 && effectappear == 0)
{
    with (instance_create(x, y, obj_afterimage))
    {
        sprite_index = other.sprite_index;
        image_xscale = other.xscale;
        image_index = other.image_index - 1;
    }
    
    alarm[2] = 8;
    effectappear = 1;
}

if (state == states.normal && effectappear == 0)
{
    alarm[3] = 3;
    effectappear = 1;
}

if (flash == 1 && alarm[1] <= 0)
    alarm[1] = 0.15 * room_speed;

if (input_buffer_jump < 8)
    input_buffer_jump++;

if (input_attack_buffer < 8)
    input_attack_buffer++;

mask_index = spr_player_mask;

if (state != 4 && state != 6)
    scr_collision();
