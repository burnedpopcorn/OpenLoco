function scr_angle_rotatereverse()
{
    if (global.anglerotation)
    {
        if (!place_meeting_collision(x + sign(hsp), y))
        {
            if (place_meeting_collision(x - sign(hsp), y) || place_meeting_slope(x + sign(hsp), y) || place_meeting_slope(x, y - 1))
            {
                var Slope = instance_place(x, y - 1, obj_slope);
                var SlopeXscale = abs(Slope.image_xscale);
                var SlopeYscale = abs(Slope.image_yscale) / 1.5;
                var targetAngle = (50 / (SlopeXscale / -SlopeYscale)) * (sign(Slope.image_xscale) / sign(Slope.image_yscale));
                angle = lerp(angle, targetAngle, 0.5);
            }
            else
            {
                angle = lerp(angle, 0, 0.5);
            }
        }
        else
        {
            angle = lerp(angle, 0, 0.5);
        }
    }
}
