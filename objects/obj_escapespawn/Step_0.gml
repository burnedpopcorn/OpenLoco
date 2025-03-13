switch (state)
{
    case 0:
        if (!global.panic)
        {
            visible = false;
            instance_deactivate_object(baddieID);
            
            with (obj_baddiecollisionbox)
            {
                if (baddieID == other.baddieID)
                    instance_destroy();
            }
        }
        else
        {
            state = 1;
        }
        
        break;
    
    case 1:
        var p = instance_nearest(x, y, obj_player);
        visible = false;
        image_index = 0;
        
        if ((p.x > (x - 600) && p.x < (x + 600)) && (y <= (p.y + 100) && y >= (p.y - 100)))
        {
            state = 2;
            visible = true;
        }
        
        break;
    
    case 2:
        if (floor(image_index) > 5)
        {
            fmod_studio_event_oneshot_3d("event:/sfx/enemy/escapespawn");
            instance_activate_object(baddieID);
            
            with (baddieID)
            {
                x = other.x;
                y = other.y;
                state = states.capefall;
                sprite_index = stunfallspr;
                stunned = 20;
                boundbox = 0;
            }
            
            state = 3;
        }
        
        break;
    
    case 3:
        if (floor(image_index) == (image_number - 1))
            visible = false;
        
        break;
}
