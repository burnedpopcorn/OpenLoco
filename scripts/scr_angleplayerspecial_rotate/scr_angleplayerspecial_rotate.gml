function scr_angleplayerspecial_rotate()
{
    if (state == states.normal || state == 1)
    {
        if (grounded && !place_meeting(x, y + 1, obj_solid))
        {
            if (scr_slope())
            {
                var Slope = instance_place(x, y + 1, obj_slope);
                var SlopeXscale = abs(Slope.image_xscale);
                var SlopeYscale = abs(Slope.image_yscale) / 1.5;
                var targetAngle = (50 / (SlopeXscale / SlopeYscale)) * (sign(Slope.image_xscale) / sign(Slope.image_yscale));
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
    else
    {
        angle = lerp(angle, 0, 0.5);
    }
}
