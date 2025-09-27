globoxsprite = testdialog;
globoxindex = 0;
alpha = 0;
xscale = 0;
yscale = 0;

function sprite_meeting(argument0, argument1, argument2, argument3)
{
    var prevmask = mask_index;
    mask_index = argument1;
    var check = instance_place(argument2, argument3, argument0);
    mask_index = prevmask;
    return check;
}

disappear = function()
{
    alpha = approach(alpha, 0, 0.15);
    xscale = approach(xscale, 0, 0.1);
    yscale = xscale;
    sprite_index = spr_miniblocker;
};

appear = function()
{
    if (sprite_meeting(obj_player1, globoxsprite, x, bbox_top))
        alpha = approach(alpha, 0.5, 0.05);
    else
        alpha = approach(alpha, 1, 0.15);
    
    xscale = approach(xscale, 1, 0.1);
    yscale = xscale;
    sprite_index = spr_miniblocker;
};

imagelist = ds_list_create();
transitioning = false;
showbuffer = 300;
switchstate = 0;
listimage = 0;

appearmultiimage = function()
{
    globoxsprite = imagelist[| listimage];
    
    if (showbuffer > 0)
        showbuffer--;
    else if (showbuffer == 0 && !transitioning)
        transitioning = true;
    
    if (!transitioning)
    {
        if (sprite_meeting(obj_player1, globoxsprite, x, bbox_top))
            alpha = approach(alpha, 0.5, 0.05);
        else
            alpha = approach(alpha, 1, 0.15);
        
        xscale = approach(xscale, 1, 0.1);
        yscale = xscale;
    }
    else
    {
        alpha = approach(alpha, (switchstate == 1) ? 1 : 0, 0.15);
        xscale = approach(xscale, (switchstate == 1) ? 1 : 0, 0.1);
        yscale = xscale;
        
        if (xscale == 0 && switchstate == 0)
        {
            switchstate++;
            listimage++;
        }
        else if (xscale == 1 && switchstate == 1)
        {
            switchstate = 0;
            transitioning = false;
            showbuffer = 300;
        }
    }
    
    if (listimage > (ds_list_size(imagelist) - 1))
        listimage = 0;
    
    sprite_index = spr_miniblocker;
};

if (global.panic && sprite_index == spr_miniblocker)
    alarm[0] = 5;
