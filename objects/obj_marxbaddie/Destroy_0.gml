if (!marxunpunched)
{
    if (ds_list_find_index(global.baddieroom, id) == -1 && (!elite || elitehit <= 0))
    {
        with (instance_create(x, y, obj_sausageman_dead))
            sprite_index = other.spr_dead;
    }
    
    if (ds_list_find_index(global.baddieroom, id) == -1 && (!elite || elitehit <= 0) && important == 0)
    {
        fmod_studio_event_oneshot_3d("event:/sfx/enemy/marx/death");
        fmod_studio_event_oneshot_3d("event:/sfx/player/misc/kill");
    }
    
    if (ds_list_find_index(global.baddieroom, id) == -1 && important == 0)
    {
        scr_sleep(50);
        instance_create(x, y, obj_slapstar);
        instance_create(x, y, obj_slapstar);
        instance_create(x, y, obj_slapstar);
        instance_create(x, y, obj_baddiegibs);
        instance_create(x, y, obj_baddiegibs);
        instance_create(x, y, obj_baddiegibs);
        
        with (obj_camera)
        {
            shake_mag = 3;
            shake_mag_acc = 3 / room_speed;
        }
        
        ds_list_add(global.baddieroom, id);
        
        if (escape || underescape)
            ds_list_add(global.escaperoom, id);
        
        if (!elite || elitehit <= 0)
        {
            with (obj_player1)
                supercharge += 1;
        }
        
        if (!elite || elitehit <= 0)
            global.combo += 1;
        
        if (!elite || elitehit <= 0)
        {
            var combototal = 10 + round(10 * (global.combo * 0.5));
            global.collect += combototal;
            global.comboscore += combototal;
        }
    }
    else if (ds_list_find_index(global.baddieroom, id) == -1 && important == 1)
    {
        scr_sleep(50);
        instance_create(x, y, obj_slapstar);
        instance_create(x, y, obj_slapstar);
        instance_create(x, y, obj_slapstar);
        instance_create(x, y, obj_baddiegibs);
        instance_create(x, y, obj_baddiegibs);
        instance_create(x, y, obj_baddiegibs);
        
        with (obj_camera)
        {
            shake_mag = 3;
            shake_mag_acc = 3 / room_speed;
        }
        
        with (instance_create(x, y, obj_sausageman_dead))
            sprite_index = other.spr_dead;
    }
    
    if (!instance_exists(obj_backgroundchange))
    {
        with (obj_camera)
        {
            marxstunned = true;
            marxseconds = 15;
            marxdist = 900;
            marxadd = 40;
            alarm[5] = 60;
            
            with (instance_create(y, x, obj_backgroundchange))
            {
                dontrepeat = true;
                image_index = 2;
                image_speed = 0;
                ending = true;
            }
        }
    }
}
