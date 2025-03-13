visible = obj_tv.visible;

if (global.style > 55 && global.stylethreshold < 3)
{
    global.stylethreshold += 1;
    global.style = global.style - 55;
    scr_heatup();
}

if (global.style < 0 && global.stylethreshold != 0)
{
    global.stylethreshold -= 1;
    global.style = global.style + 55;
    scr_heatdown();
}

if (global.style < 0 && global.stylethreshold == 0)
    global.style = 0;

if (global.stylethreshold == 3 && global.style > 55)
    global.style = 55;

visible = obj_tv.visible;
global.stylemultiplier = (global.style + (global.stylethreshold * 55)) / 220;
