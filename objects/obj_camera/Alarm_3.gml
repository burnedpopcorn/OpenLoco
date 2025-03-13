addseconds--;
global.seconds++;

if (global.seconds >= 60)
{
    global.minutes++;
    global.seconds = 0;
}

if (addseconds > 0)
{
    alarm[3] = 2;
}
else
{
    global.fill = ((global.minutes * 60) + global.seconds) * 60;
    
    if (global.fill >= obj_tv.chunkmax)
        obj_tv.chunkmax = global.fill;
    
    if (global.fill >= global.maxwave)
        global.maxwave = global.fill;
    
    gettingfilltimer = 0;
    alarm[1] = 60;
}
