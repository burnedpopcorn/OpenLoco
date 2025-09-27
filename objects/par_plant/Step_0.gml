scr_collision();
xscale_mult = lerp(xscale_mult, 1, 0.05);
yscale_mult = lerp(yscale_mult, 1, 0.05);
hsp = approach(hsp, 0, 0.1);

switch (state)
{
    case states.normal:
        if (step_func != noone)
            step_func();
        
        break;
    
    case states.grabbed:
        x = grabber.x;
        y = grabber.y - sprite_height;
        sprite_index = spr_idle;
        image_xscale = grabber.xscale;
        vsp = 0;
        
        if (grabber.state != states.grab && grabber.state != states.superslam && grabber.state != states.machslide && grabber.state != states.mach2)
            state = states.normal;
        
        break;
}
