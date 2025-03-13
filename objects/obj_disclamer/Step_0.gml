var accel = 0.025;

if (!fadeout && waittilalarm)
{
    fade = Approach(fade, 0, accel);
    
    if (fade <= 0)
    {
        fadeout = 1;
        accel = 0.015;
        alarm[0] = 240;
    }
}
else if (changeroom)
{
    accel = 0.015;
    fade = Approach(fade, 1, accel);
    
    if (fade >= 1 && !instance_exists(obj_fadeout))
    {
        with (obj_player)
        {
            state = 8;
            targetRoom = rm_intro;
        }
        
        instance_create(0, 0, obj_fadeout);
    }
}
