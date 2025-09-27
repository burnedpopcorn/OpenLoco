switch (state)
{
    case zarena.start:
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
            if (content_list[| other.Round] != undefined)
            {
                var q = instance_create(x, y, obj_zombie_riseup);
                q.obj_array = content_list[| other.Round];
                q.num_max = array_length(q.obj_array);
            }
        }
        
        state = zarena.gameloop;
        break;
    
    case zarena.startcheck:// unused and uneeded
        if (!instance_exists(obj_zombie_riseup))
            state = zarena.gameloop;
        
        break;
    
    case zarena.gameloop:
        if (ds_list_empty(zombie_list) && !instance_exists(obj_zombie_riseup))
        {
            if (Round == totalRounds)
            {
                state = zarena.ending;
            }
            else
            {
                Round++;
                state = zarena.start;
            }
        }
        else
        {
            for (var i = 0; i < ds_list_size(zombie_list); i++)
            {
                if (!instance_exists(zombie_list[| i]))
                {
                    ds_list_delete(zombie_list, i);
                    i--;
                }
            }
        }
        
        break;
    
    case zarena.ending:
        with (obj_zombiearena_gate)
        {
            sprite_index = spr_arenagate_open;
            image_index = 0;
            image_speed = 0.35;
        }
        
        state = zarena.idle;
        break;
}
