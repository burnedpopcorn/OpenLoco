with (other)
{
    if (vsp > 0 && state != states.lawnmower && state != states.lawnmowerslide && !place_meeting(x, y, obj_secretportal) && !place_meeting(x, y, obj_secretportalstart))
    {
        instance_create(x, y, obj_genericpoofeffect);
        
        with (instance_create(0, 0, obj_transformationtext))
        {
            effect = texteffect.crazyshake;
            message = "[T] (In air) taunt";
        }
        
        state = states.lawnmower;
        xscale = other.image_xscale;
        movespeed = 3;
    }
}
