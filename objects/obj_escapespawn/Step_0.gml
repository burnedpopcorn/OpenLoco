switch (state)
{
    case spawnbaddies.idle:
        if (!global.panic)
        {
            visible = false;
            instance_deactivate_object(baddieID);
            
            with (obj_baddiecollisionbox)
                if (baddieID == other.baddieID)
                    instance_destroy();
        }
        else
            state = spawnbaddies.checkplayer;
        break;
    
    case spawnbaddies.checkplayer:
        var p = instance_nearest(x, y, obj_player);
        visible = false;
        image_index = 0;
        
        if ((p.x > (x - 600) && p.x < (x + 600)) && (y <= (p.y + 100) && y >= (p.y - 100)))
        {
            state = spawnbaddies.spawn;
            visible = true;
        }
        
        break;
    
    case spawnbaddies.spawn:
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
            
            state = spawnbaddies.die;
        }
        break;
    
    case spawnbaddies.die:
        if (floor(image_index) == (image_number - 1))
            visible = false;
        break;
}
