function scr_enemy_rage()
{
    switch (object_index)
    {
        case obj_waddledee:
            if (floor(image_index) > 10)
            {
                hsp = image_xscale * 8;
                
                with (instance_create(x, y, obj_baddieragehitbox))
                {
                    ID = other.id;
                    image_xscale = other.image_xscale;
                }
            }
            else
                hsp = 0;
            
            if (floor(image_index) == (image_number - 1))
            {
                state = states.actor;
                sprite_index = walkspr;
            }
            
            break;
        
        case obj_shyguy:
            hsp = 0;
            
            if (floor(image_index) == (image_number - 1))
            {
                with (instance_create(x, y, obj_shyguy_lance))
                    image_xscale = other.image_xscale;
                
                state = states.actor;
                sprite_index = walkspr;
            }
            
            break;
    }
}
