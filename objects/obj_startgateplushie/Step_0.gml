scr_collision();

switch (state)
{
    case "idle":
        hsp = 0;
        move_cooldown--;
        
        if (move_cooldown <= 0)
        {
            state = "walk";
            move_duration = irandom_range(30, 90);
            sprite_index = movespr;
            image_index = 0;
            
            if (distance_to_object(gateid) <= 150)
                image_xscale = choose(-1, 1);
            else if (gateid.x >= x)
                image_xscale = 1;
            else
                image_xscale = -1;
        }
        
        if (obj_player.state == states.backbreaker)
            plushietaunt();
        
        break;
    
    case "walk":
        move_duration--;
        hsp = 1 * image_xscale;
        
        if (move_duration <= 0)
        {
            state = "idle";
            move_cooldown = irandom_range(60, 120);
            sprite_index = idlespr;
            image_index = 0;
        }
        
        if (place_meeting(x + 1, y + 32 + 1, par_collision) || place_meeting(x + hsp, y, obj_solid))
            image_xscale *= -1;
        
        if (obj_player.state == states.backbreaker)
            plushietaunt();
        
        break;
    
    case "taunt":
        if (obj_player.state != states.backbreaker)
        {
            if (instance_exists(obj_tinytaunt))
                instance_destroy(obj_tinytaunt);
            
            sprite_index = storedspr;
            hsp = stored_walkspeed;
            state = storedstate;
        }
        
        break;
}
