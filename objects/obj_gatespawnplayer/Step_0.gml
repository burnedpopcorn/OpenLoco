if (playerID != noone)
{
    if (state != gatespawn.die)
    {
        playerID.x = x;
        playerID.y = y;
    }
    
    switch (state)
    {
        case gatespawn.init:
            visible = true;
            image_index = 0;
            image_speed = 0.25;
            state = 1;
            break;
        
        case gatespawn.spawn:
            if (floor(image_index) > 5)
            {
                fmod_studio_event_oneshot_3d("event:/sfx/enemy/escapespawn");
                
                with (playerID)
                {
                    sprite_index = get_charactersprite("spr_slipbanan1", playerID);
                    vsp = -16;
                    visible = true;
                    image_index = 0;
                    state = states.slipbanana;
                }
                
                state = gatespawn.die;
            }
            
            break;
        
        case gatespawn.die:
            if (floor(image_index) == (image_number - 1))
                instance_destroy();
            
            break;
    }
}
