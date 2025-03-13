if (global.language != "none")
{
    alarm[2] = 1;
    exit;
}

scr_getinput();
var sizeAccel = 0.07;
var alphaAccel = 0.07;

if (activate)
{
    yoffest = lerp(yoffest, 100, 0.07);
    alpha = lerp(alpha, 1, 0.07);
}

if (activateall)
{
    size1 = (langselected == 1) ? lerp(size1, 2, sizeAccel) : lerp(size1, 1, sizeAccel);
    alpha1 = (langselected == 1) ? lerp(alpha1, 1, alphaAccel) : lerp(alpha1, 0.5, alphaAccel);
    size2 = (langselected == 2) ? lerp(size2, 2, sizeAccel) : lerp(size2, 1, sizeAccel);
    alpha2 = (langselected == 2) ? lerp(alpha2, 1, alphaAccel) : lerp(alpha2, 0.5, alphaAccel);
    
    if (size1 > 0.7 && size2 > 0.7 && !ended)
        control = 1;
    
    if (control)
    {
        if (key_down2 && langselected < 2)
        {
            fmod_studio_event_oneshot("event:/sfx/player/step");
            langselected += 1;
        }
        
        if (key_up2 && langselected > 1)
        {
            fmod_studio_event_oneshot("event:/sfx/player/step");
            langselected -= 1;
        }
        
        if (key_jump)
        {
            switch (langselected)
            {
                case 1:
                    ini_open("saveData.ini");
                    ini_write_string("Option", "language", "esp");
                    ini_close();
                    global.language = "esp";
                    reload_langfile();
                    break;
                
                case 2:
                    ini_open("saveData.ini");
                    ini_write_string("Option", "language", "eng");
                    ini_close();
                    global.language = "eng";
                    reload_langfile();
                    break;
                
                default:
                    fmod_studio_event_oneshot("event:/sfx/player/damage");
                    break;
            }
            
            if (langselected == 1 || langselected == 2)
            {
                activate = 0;
                activateall = 0;
                control = 0;
                ended = 1;
                alarm[2] = 150;
            }
        }
    }
}

if (ended)
{
    yoffest = lerp(yoffest, 0, 0.07);
    alpha = lerp(alpha, 0, 0.07);
    size1 = lerp(size1, 0, 0.07);
    alpha1 = lerp(alpha1, 0, 0.07);
    size2 = lerp(size2, 0, 0.07);
    alpha2 = lerp(alpha2, 0, 0.07);
}
