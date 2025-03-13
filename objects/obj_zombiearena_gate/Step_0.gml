if (sprite_index == spr_arenagate_open || sprite_index == spr_arenagate_opened)
{
    image_speed = 0.35;
    
    if (sprite_index == spr_arenagate_open && animation_end())
        sprite_index = spr_arenagate_opened;
    
    mask_index = spr_null;
}
else
{
    if (animation_end() && sprite_index == spr_arenagate_close)
        image_index = image_number - 1;
    
    mask_index = spr_arenagate_close;
}
