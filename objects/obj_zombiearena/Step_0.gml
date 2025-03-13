switch (state)
{
    case UnknownEnum.Value_1:
        if (!closedGates)
        {
            with (obj_zombiearena_gate)
            {
                image_index = 0;
                image_speed = 0.35;
                sprite_index = spr_arenagate_close;
            }
            
            closedGates = true;
        }
        
        with (obj_zombiearena_tombstone)
        {
            if (ds_list_find_value(content_list, other.Round) != undefined)
            {
                var q = instance_create(x, y, obj_zombie_riseup);
                q.obj_array = ds_list_find_value(content_list, other.Round);
                q.num_max = array_length(q.obj_array);
            }
        }
        
        state = states.finishingblow;
        break;
    
    case states.tumble:
        if (!instance_exists(obj_zombie_riseup))
            state = states.finishingblow;
        
        break;
    
    case states.finishingblow:
        if (ds_list_empty(zombie_list) && !instance_exists(obj_zombie_riseup))
        {
            if (Round == totalRounds)
            {
                state = states.ejected;
            }
            else
            {
                Round++;
                state = UnknownEnum.Value_1;
            }
        }
        else
        {
            for (var i = 0; i < ds_list_size(zombie_list); i++)
            {
                if (!instance_exists(ds_list_find_value(zombie_list, i)))
                {
                    ds_list_delete(zombie_list, i);
                    i--;
                }
            }
        }
        
        break;
    
    case states.ejected:
        with (obj_zombiearena_gate)
        {
            sprite_index = spr_arenagate_open;
            image_index = 0;
            image_speed = 0.35;
        }
        
        state = states.normal;
        break;
}
