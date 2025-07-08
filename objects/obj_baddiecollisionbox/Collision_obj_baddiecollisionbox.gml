if (instance_exists(other.baddieID) && instance_exists(baddieID))
{
    if (baddieID != other.baddieID && !other.baddieID.mach3destroy && baddieID.state != states.hit && other.baddieID != id && baddieID.state != states.grabbed && !baddieID.thrown && other.baddieID.thrown)
    {
        fmod_studio_event_oneshot_3d("event:/sfx/player/punch");
        baddieID.hitLag = 5;
        baddieID.hitX = baddieID.x;
        baddieID.hitY = baddieID.y;
        baddieID.hp -= 1;
        
        if (!other.baddieID.important)
            global.combotime = 60;
        
        instance_create(baddieID.x, baddieID.y, obj_parryeffect);
        baddieID.alarm[3] = 3;
        baddieID.state = states.hit;
        baddieID.hitvsp = -8;
        baddieID.hithsp = -other.baddieID.image_xscale * 15;
        baddieID.grabbedby = 0;
        
        if (baddieID.elite)
        {
            with (baddieID)
            {
                elitehit--;
                
                if (elitehit < 0)
                    elitehit = 0;
                
                if (elitehit > 0)
                {
                    event_perform(ev_destroy, 0);
                    var b = ds_list_find_index(global.baddieroom, id);
                    
                    if (b != -1)
                        ds_list_delete(global.baddieroom, b);
                }
            }
        }
        
        if (baddieID.destroyable && (!baddieID.elite || baddieID.elitehit <= 0))
            instance_destroy(baddieID);
    }
}
