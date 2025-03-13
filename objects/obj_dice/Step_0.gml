timer -= tspeed;

if (hitanim > 0)
    hitanim--;

if (hitanim < 0)
    hitanim++;

if (hit && hitanim == 0)
    sprite_index = spr_dice;

if (timer < 0)
{
    timer = 60;
    
    if (sprite_index == spr_diceblue)
        sprite_index = spr_dicered;
    else if (sprite_index == spr_dicered)
        sprite_index = spr_diceblue;
}

with (obj_player)
{
    if (!other.hit)
    {
        if (place_meeting(x, y + vsp, other.id) && vsp < 0)
        {
            other.hit = true;
            other.hitanim = -20;
        }
        
        if (state == states.freefallland && place_meeting(x, y + 1, other.id))
        {
            other.hit = true;
            other.hitanim = 20;
        }
        
        if (other.hit)
        {
            if (other.sprite_index == spr_diceblue)
            {
                with (instance_create(x, y, obj_dicecollect))
                {
                    collect = 200;
                    alarm[0] = 1;
                }
            }
            
            if (other.sprite_index == spr_dicered)
            {
                with (instance_create(x, y, obj_dicecollect))
                {
                    collect = -200;
                    alarm[1] = 1;
                }
            }
        }
    }
}

with (obj_baddie)
{
    if (!other.hit)
    {
        if (thrown && place_meeting(x, y + vsp, other.id) && vsp < 0)
        {
            other.hit = true;
            other.hitanim = -20;
        }
        
        if (other.hit)
        {
            if (other.sprite_index == spr_diceblue)
            {
                with (instance_create(x, y, obj_dicecollect))
                {
                    collect = 200;
                    alarm[0] = 1;
                }
            }
            
            if (other.sprite_index == spr_dicered)
            {
                with (instance_create(x, y, obj_dicecollect))
                {
                    collect = -200;
                    alarm[1] = 1;
                }
            }
        }
    }
}
