with (other)
{
    if (state != states.Sjump)
    {
        if (state == states.knightpep || (state == states.knightpepattack || state == states.knightpepslopes))
        {
            with (instance_create(x, y, obj_knightdebris))
                image_index = 0;
            
            with (instance_create(x, y, obj_knightdebris))
                image_index = 1;
            
            with (instance_create(x, y, obj_knightdebris))
                image_index = 2;
            
            with (instance_create(x, y, obj_knightdebris))
                image_index = 3;
            
            with (instance_create(x, y, obj_knightdebris))
                image_index = 4;
            
            with (instance_create(x, y, obj_knightdebris))
                image_index = 5;
        }
        
        x = other.x;
        
        if (state == states.bombpep)
            instance_create(x, y, obj_bombexplosion);
        
        if (other.image_yscale == 1)
        {
            sprite_index = get_charactersprite("spr_presentbox");
            state = states.Sjump;
            vsp = -10;
        }
        else
        {
            fmod_studio_event_oneshot_3d("event:/sfx/player/bodyslam_land");
            sprite_index = get_charactersprite("spr_rockethitwall");
            state = states.freefall;
            vsp = 10;
        }
        
        other.image_index = 0;
        
        if (other.sprite_index != other.activatespr)
            other.sprite_index = other.activatespr;
        
        other.image_speed = 0.35;
    }
}
