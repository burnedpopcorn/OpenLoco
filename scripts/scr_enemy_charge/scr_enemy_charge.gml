function scr_enemy_charge()
{
    if (object_index == obj_peasanto)
    {
        if (grounded || (grounded && !place_meeting(x, y, obj_platform)))
            hsp = image_xscale * (movespeed * 4);
        else
            hsp = 0;
        
        image_speed = 0.35;
        
        if (((scr_solid(x + 1, y) && image_xscale == 1) || (scr_solid(x - 1, y) && image_xscale == -1)) && !place_meeting(x + sign(hsp), y, obj_slope))
            image_xscale *= -1;
        
        if (!(scr_solid(x + 15, y + 31) || scr_solid(x + 15, y + 31)) && (image_xscale == 1 && movespeed > 0))
            image_xscale *= -1;
        
        if (!(scr_solid(x - 15, y + 31) || scr_solid(x - 15, y + 31)) && (image_xscale == -1 && movespeed > 0))
            image_xscale *= -1;
        
        if (!(grounded || (grounded && !place_meeting(x, y, obj_platform))) && hsp < 0)
            hsp += 0.1;
        else if (!(grounded || (grounded && !place_meeting(x, y, obj_platform))) && hsp > 0)
            hsp -= 0.1;
        
        sprite_index = spr_peasanto_attack;
    }
    
    if (object_index == obj_pizzice)
    {
        hsp = image_xscale * movespeed;
        image_speed = 0.35;
        
        if (((scr_solid(x + 1, y) && image_xscale == 1) || (scr_solid(x - 1, y) && image_xscale == -1)) && !place_meeting(x + sign(hsp), y, obj_slope))
            image_xscale *= -1;
        
        sprite_index = spr_pizzice_walk;
    }
    
    if (object_index == obj_fencer)
    {
        if (grounded || (grounded && !place_meeting(x, y, obj_platform)))
            hsp = image_xscale * movespeed;
        else
            hsp = 0;
        
        if (((place_meeting_solid(x + sign(hsp), y) && !place_meeting_slope(x + sign(hsp), y + 1)) || (grounded && ((place_meeting_collision(x + sign(hsp), y - 64) || place_meeting_solid(x + sign(hsp), y - 64)) && place_meeting_slope(x, y + 1)))) || place_meeting(x + sign(hsp), y, obj_hallway))
            image_xscale *= -1;
    }
    
    if (object_index == obj_ancho)
    {
        hsp = image_xscale * movespeed;
        
        if (place_meeting(x + hsp, y, obj_solid))
        {
            state = states.capefall;
            stunned = 100;
        }
    }
    
    if (object_index == obj_charginchuck)
    {
        var once = 0;
        
        if (grounded)
            once = 1;
        
        if (once)
        {
            hsp = image_xscale * movespeed;
            var player = instance_nearest(x, y, obj_player);
            
            if ((x > player.x && image_xscale == 1) || (x < player.x && image_xscale == -1))
            {
                if (grounded)
                {
                    movespeed = Approach(movespeed, 0, 0.25);
                    
                    if (movespeed <= 2)
                    {
                        movespeed = 0;
                        charging = 0;
                        state = states.actor;
                    }
                }
            }
            else
                movespeed = Approach(movespeed, 16, 0.5);
        }
        
        if ((place_meeting_solid(x + sign(hsp), y) && !place_meeting_slope(x + sign(hsp), y + 1)) || (grounded && ((place_meeting_collision(x + sign(hsp), y - 64) || place_meeting_solid(x + sign(hsp), y - 64)) && place_meeting_slope(x, y + 1))))
        {
            fmod_studio_event_oneshot_3d("event:/sfx/player/punch");
            movespeed = 0;
            hsp = -(image_xscale * 4);
            vsp = -5;
            state = states.capefall;
            stunned = 100;
        }
    }
    
    if (object_index == obj_zombiewater)
    {
        hsp = movespeed;
        image_speed = abs(movespeed) / 10;
        sprite_index = spr_piraneappleattack;
        vsp = Approach(vsp, (y < obj_player.y) ? 4 : -4, 0.4);
        movespeed = Approach(movespeed, 8 * image_xscale, 0.1);
        
        if (obj_player.x != x)
            image_xscale = (obj_player.x > x) ? 1 : -1;
        
        if (place_meeting_collision(x + hsp, y))
        {
            movespeed = -movespeed / 2;
            instance_create(x, y, obj_bumpeffect);
        }
        
        if (place_meeting_collision(x, y + sign(vsp)))
            vsp = 0;
    }
    
    if (object_index == obj_ninja)
    {
        hsp = image_xscale * (movespeed * 2);
        image_speed = 0.35;
        
        if (grounded && vsp > 0)
            state = states.actor;
        
        if (((scr_solid(x + 1, y) && image_xscale == 1) || (scr_solid(x - 1, y) && image_xscale == -1)) && !place_meeting(x + sign(hsp), y, obj_slope))
            image_xscale *= -1;
        
        if (!(grounded || (grounded && !place_meeting(x, y, obj_platform))) && hsp < 0)
            hsp += 0.1;
        else if (!(grounded || (grounded && !place_meeting(x, y, obj_platform))) && hsp > 0)
            hsp -= 0.1;
        
        sprite_index = spr_ninja_attack;
    }
}
