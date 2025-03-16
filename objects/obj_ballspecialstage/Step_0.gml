scr_ballcollision();
scr_getinput();

switch (state)
{
    case ballstates.air:
        scr_ball_air();
        break;
    
    case ballstates.land:
        scr_ball_land();
        break;
}

if (keyboard_check_pressed(vk_f7) && changeangle == 0 && inprogrsangle == 0)
{
    changeangle = 1;
    inprogrsangle = 1;
}

if (changeangle == 1)
{
    if (anglevertx == 0)
        angledirect = 1;
    
    if (anglevertx == 180)
        angledirect = 2;
    
    changeangle = 0;
    state = ballstates.land;
}

if (inprogrsangle == 1)
{
    if (angledirect == 1)
    {
        anglevertx += 2;
        
        if (anglevertx >= 180)
        {
            anglevertx = 180;
            changeangle = 0;
            angledirect = 0;
            inprogrsangle = 0;
            state = ballstates.air;
        }
    }
    
    if (angledirect == 2)
    {
        anglevertx += 2;
        
        if (anglevertx >= 360)
        {
            anglevertx = 0;
            changeangle = 0;
            angledirect = 0;
            inprogrsangle = 0;
            state = ballstates.air;
        }
    }
}
