if (global.panic)
{
    image_alpha = 1;
    
    if (sprite_index == spr_pizzaportal)
    {
        playerid = noone;
        
        with (obj_player1)
        {
            if (other.playerid == noone && place_meeting(x, y, other))
            {
                if (state != states.portal)
                {
                    fmod_studio_event_oneshot_3d("event:/sfx/level_structure/lapring");
                    storedhsp = hsp;
                    state = states.portal;
                    global.collect += 3000;
                    global.combotime = 60;
                    
                    with (instance_create(x, y, obj_smallnumber))
                        number = "3000";
                }
                
                visible = false;
                other.sprite_index = spr_pizzaportalend;
                other.image_index = 0;
                other.image_speed = 1;
                other.playerid = id;
            }
        }
    }
    else if (sprite_index == spr_pizzaportalend)
    {
        wait_time--;
        
        with (playerid)
        {
            hsp = 0;
            vsp = 0;
            visible = false;
        }
        
        if (animation_end())
            visible = false;
        
        if (wait_time <= 0)
        {
            if (!instance_exists(obj_fadeout))
            {
                with (obj_player1)
                {
                    targetDoor = "LAP";
                    targetRoom = other.targetRoom;
                }
                
                if (global.minutes > 0 || (global.minutes == 0 && global.seconds > 0))
                {
                    with (obj_camera)
                    {
                        gettingfilltimer = 1;
                        
                        for (addseconds += other.seconds; other.minutes > 0; addseconds += 60)
                            other.minutes--;
                        
                        alarm[1] = -1;
                        alarm[3] = 2;
                    }
                }
                
                for (var i = 0; i < ds_list_size(global.escaperoom); i++)
                {
                    var b = global.escaperoom[| i];
                    var q = ds_list_find_index(global.baddieroom, b);
                    var t = 0;
                    
                    if (q == -1)
                    {
                        q = ds_list_find_index(global.saveroom, b);
                        t = 1;
                    }
                    
                    if (q != -1)
                    {
                        if (!t)
                            ds_list_delete(global.baddieroom, q);
                        else
                            ds_list_delete(global.saveroom, q);
                    }
                }
                
                global.laps++;
                global.lap = 1;
                
                if (!instance_exists(obj_lapvisual))
                    instance_create(0, 0, obj_lapvisual);
                
                instance_create(0, 0, obj_fadeout);
                fmod_studio_event_oneshot_3d("event:/sfx/level_structure/lapexit");
            }
        }
    }
}
else
{
    image_alpha = 0.5;
}
