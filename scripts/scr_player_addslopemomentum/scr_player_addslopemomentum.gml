function scr_player_addslopemomentum(argument0 = 0.15, argument1 = 0.1, argument2 = true, argument3 = 12, argument4 = 5)
{
    var colliding_slope = noone;
    
    if (scr_slope())
        colliding_slope = instance_nearest(x, y, obj_slope);
    else if (scr_slope_platform())
        colliding_slope = instance_nearest(x, y, obj_slopePlatform);
    
    if (colliding_slope != noone && scr_slope() && grounded)
    {
        var small_scale = sign(colliding_slope.image_xscale);
        var speed_amplify = argument2 ? (abs(colliding_slope.image_yscale) / abs(colliding_slope.image_xscale)) : 1;
        
        if (argument4 != noone && speed_amplify > argument4)
            speed_amplify = argument4;
        
        if (xscale == small_scale && abs(movespeed) > argument3)
            movespeed -= (argument1 * speed_amplify);
        else if (xscale == -small_scale && abs(movespeed) < 24)
            movespeed += (argument0 * speed_amplify);
    }
    
    return argument3;
}
