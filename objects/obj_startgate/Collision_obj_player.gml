var gate = id;

with (obj_player1)
{
    if (key_up && (grounded && ((state == states.normal || (state == states.mach1 || (state == states.mach2 || state == states.mach3))) && (!instance_exists(obj_noisesatellite) && (!instance_exists(obj_fadeout) && (state != states.victory && (state != states.comingoutdoor && obj_player1.spotlight == 1)))))))
    {
        with (global.music)
        {
            fmod_studio_event_instance_stop(event_instance, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
            fmod_studio_event_instance_stop(secret_event_instance, FMOD_STUDIO_STOP_MODE.ALLOWFADEOUT);
        }
        
        global.leveltosave = other.level;
        global.combodrop = 0;
        global.hub_bgsprite = other.sprite_index;
        obj_tv.tvbg_scroll = 0;
        obj_tv.tvbg_secret_scroll = 0;
        lasthub = room;
        lastdoorhub = other.targetdoorhub;
        backtohubstartx = x;
        backtohubstarty = y;
        backtohubroom = room;
        mach2 = 0;
        obj_camera.chargecamera = 0;
        image_index = 0;
        state = states.victory;
        obj_player2.backtohubstartx = x;
        obj_player2.backtohubstarty = y;
        obj_player2.backtohubroom = room;
        
        if (global.coop == 1)
        {
            with (obj_player2)
            {
                x = obj_player1.x;
                mach2 = 0;
                obj_camera.chargecamera = 0;
                image_index = 0;
                state = states.victory;
            }
        }
    }
}

if (obj_player1.state == states.victory)
{
    with (obj_player1)
        x = lerp(x, other.x, 0.2);
}

with (obj_player2)
{
    if (key_up && (grounded && ((state == states.normal || (state == states.mach1 || (state == states.mach2 || state == states.mach3))) && (!instance_exists(obj_noisesatellite) && (!instance_exists(obj_fadeout) && (state != states.victory && (state != states.comingoutdoor && obj_player1.spotlight == 0)))))))
    {
        audio_stop_all();
        global.leveltosave = other.level;
        backtohubstartx = x;
        backtohubstarty = y;
        backtohubroom = room;
        mach2 = 0;
        DoorID = other.id;
        obj_camera.chargecamera = 0;
        image_index = 0;
        state = states.victory;
        obj_player1.backtohubstartx = x;
        obj_player1.backtohubstarty = y;
        obj_player1.backtohubroom = room;
        
        if (global.coop == 1)
        {
            with (obj_player1)
            {
                x = obj_player2.x;
                mach2 = 0;
                obj_camera.chargecamera = 0;
                image_index = 0;
                state = states.victory;
            }
        }
    }
}

if ((floor(obj_player1.image_index) == (obj_player1.image_number - 1) && obj_player1.state == states.victory) || (floor(obj_player2.image_index) == (obj_player2.image_number - 1) && obj_player2.state == states.victory))
{
    with (obj_player)
    {
        global.lowpassEffect.bypass = 1;
        
        if (other.level == "tutorial")
        {
            obj_music.fadeoff = 0;
            targetDoor = other.targetDoor;
            targetRoom = other.targetRoom;
            global.roomtorestart = other.targetRoom;
            
            if (!instance_exists(obj_fadeout))
                instance_create(x, y, obj_fadeout);
        }
        else
        {
            obj_music.fadeoff = 0;
            targetDoor = other.targetDoor;
            targetRoom = rm_titlecard;
            roomafter = other.targetRoom;
            global.roomtorestart = other.targetRoom;
            
            if (!other.donotrepeat)
            {
                with (obj_camera)
                    alphaend = 0;
                
                with (obj_tv)
                    alphaend = 0;
                
                if (!instance_exists(obj_titlecard))
                {
                    with (instance_create(x, y, obj_titlecard))
                    {
                        title_music = gate.title_music;
                        titlecard_sprite = gate.titlecard_sprite;
                        title_sprite = gate.title_sprite;
                        event_user(0);
                    }
                    
                    other.donotrepeat = 1;
                }
            }
        }
    }
}
