function scr_angle_rotate()
{
    var Slope = noone;
    
    if (!place_meeting(x, y, obj_slopePlatformskateboard))
        Slope = instance_place(x, y + 1, obj_slope);
    else
        Slope = instance_place(x, y + 1, obj_slopePlatformskateboard);
    
    if (global.anglerotation && grounded && !place_meeting(x, y + 1, obj_solid) && Slope != noone && state != states.backbreaker && state != states.bump)
    {
        var SlopeXscale = abs(Slope.image_xscale);
        var SlopeYscale = abs(Slope.image_yscale);
        var targetAngle = (50 / (SlopeXscale / SlopeYscale)) * (sign(Slope.image_xscale) / sign(Slope.image_yscale));
        angle = lerp(angle, targetAngle, 0.75);
    }
    else if (state == states.backbreaker || state == states.bump)
        angle = 0;
    else
        angle = lerp(angle, 0, 0.75);
}
