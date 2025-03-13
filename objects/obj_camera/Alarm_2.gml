if (global.seconds == 0 && global.minutes == 0)
    alarm[2] = 3;

if (global.miniboss == 1)
{
    with (obj_player)
    {
        instance_create(x, y, obj_bangeffect);
        
        repeat (6)
            instance_create(x, y, obj_slapstar);
        
        state = 4;
        vsp = -10;
        audio_stop_all();
    }
    
    alarm[2] = -1;
    global.miniboss = 0;
}
