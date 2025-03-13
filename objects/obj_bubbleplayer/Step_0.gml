switch (sprite_index)
{
    case spr_bubbleplayer_start:
        if (floor(image_index) == (image_number - 1))
            sprite_index = spr_bubbleplayer;
        
        image_speed = 0.35;
        break;
    
    case spr_bubbleplayer:
        if (floor(image_index) == (image_number - 1) && sprite_index == spr_bubbleplayer)
            create_particle(x + shakeboth(32), y + 55, 15, 0);
        
        break;
}
