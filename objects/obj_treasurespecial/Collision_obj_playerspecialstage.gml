if (visible == true && !gotcaught)
{
    obj_specialhud.done = 1;
    
    with (other)
    {
        state = 4;
        sprite_index = spr_machfreefall;
    }
    
    alarm[0] = 100;
    gotcaught = true;
    
    with (instance_create(x, y, obj_smallnumber))
        number = "1000";
    
    global.collect += 1000;
}
