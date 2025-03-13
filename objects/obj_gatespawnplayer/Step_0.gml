if (playerID != -4)
{
    if (state != states.tumble)
    {
        playerID.x = x;
        playerID.y = y;
    }
    
    switch (state)
    {
        case 0:
            visible = true;
            image_index = 0;
            image_speed = 0.25;
            state = 1;
            break;
        
        case 1:
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
                
                state = 2;
            }
            
            break;
        
        case 2:
            if (floor(image_index) == (image_number - 1))
                instance_destroy();
            
            break;
    }
}
