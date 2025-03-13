if (active)
{
    if (!gaining && hspeed > -4)
    {
        hspeed -= 0.1;
        
        if (hspeed < -3)
            gaining = true;
    }
    
    if (gaining)
        hspeed += 0.3;
    
    if (x > 960 && !instance_exists(obj_fadeout))
    {
        if (intro)
        {
            with (instance_create(x, y, obj_fadeout))
            {
                obj_player.targetRoom = rm_introcustene;
                obj_player.state = 8;
            }
        }
        else
        {
            with (instance_create(x, y, obj_fadeout))
            {
                obj_player.targetRoom = Titlescreen;
                obj_player.state = 8;
            }
        }
    }
}

if (sprite_index == spr_pepcooter && !instance_exists(obj_superdashcloud))
{
    with (instance_create(x - 100, y, obj_superdashcloud))
        image_xscale = 1;
}
