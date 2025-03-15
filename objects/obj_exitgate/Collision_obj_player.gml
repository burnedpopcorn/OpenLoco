if (image_index == 1 && global.panic == 0 && endlevel == 0)
{
    with (obj_player)
    {
        if (sprite_index == get_charactersprite("spr_walkfront") && floor(image_index) == (image_number - 2))
        {
            fmod_studio_event_oneshot_3d("event:/sfx/player/bodyslam_land");
            sprite_index = get_charactersprite("spr_timesup");
            image_index = 0;
            
            with (obj_camera)
            {
                shake_mag = 10;
                shake_mag_acc = 30 / room_speed;
            }
            
            other.image_index = 0;
            ds_list_add(global.saveroom, other.id);
        }
    }
}

with (obj_player)
{
    if (grounded && ((x > (other.x - 160) && x < (other.x + 160)) && (key_up && ((state == states.normal || (state == states.mach1 || (state == states.mach2 || state == states.mach3))) && (global.panic == 1 || global.snickchallenge == 1)))))
    {
        if (global.timeattack == 1)
            obj_timeattack.stop = 1;
        
        targetDoor = "none";
        obj_camera.alarm[2] = -1;
        scr_savescore(global.leveltosave);
        
        with (obj_camera)
            alphaend = 0;
        
        with (obj_tv)
            alphaend = 0;
        
        if (instance_exists(obj_keyman))
            obj_keyman.visible = false;
        
        if (instance_exists(obj_zombiefollow))
            obj_zombiefollow.visible = false;
        
        if (global.combo > 0)
        {
            global.combotime = 0;
            global.combo = 0;
            obj_camera.alarm[4] = -1;
            
            for (var i = 0; i < global.comboscore; i += 10)
                create_collect(obj_player1.x + irandom_range(-60, 60), (obj_player1.y - 100) + irandom_range(-60, 60), choose(spr_shroomcollect, spr_tomatocollect, spr_cheesecollect, spr_sausagecollect, spr_pineapplecollect), 10);
            
            global.comboscore = 0;
        }
        
        obj_player.state = states.door;
        obj_player.sprite_index = get_charactersprite("spr_lookdoor", obj_player1);
        other.endlevel = 1;
        other.alarm[1] = 20;
        image_index = 0;
        global.panic = 0;
        global.lap = 0;
        global.snickchallenge = 0;
        gamesave_async_save();
        
        with (global.music)
        {
            fmod_studio_event_instance_stop(event_instance, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
            fmod_studio_event_instance_stop(secret_event_instance, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
        }
    }
}
