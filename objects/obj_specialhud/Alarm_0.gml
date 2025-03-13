if (!(global.secondsspecial == 0 && global.minutesspecial == 0) && done == 0)
{
    if (global.secondsspecial <= 1 && global.minutesspecial == 0)
        alarm[1] = 100;
    
    global.secondsspecial -= 1;
    
    if (global.secondsspecial < 0)
    {
        global.secondsspecial = 59;
        global.minutesspecial -= 1;
    }
    
    if (global.secondsspecial <= 30 && global.minutesspecial == 0)
    {
        xscaletimer = 1.5;
        yscaletimer = 1.5;
        angletimer = 50 * angledirection;
        angledirection *= -1;
        
        if (global.secondsspecial <= 10 && global.minutesspecial == 0 && global.secondsspecial > 5)
            alarm[2] = 30;
        
        if (global.secondsspecial <= 5 && global.minutesspecial == 0 && global.secondsspecial > 0)
        {
            alarm[2] = 20;
            alarm[3] = 40;
        }
    }
    
    alarm[0] = 60;
}
