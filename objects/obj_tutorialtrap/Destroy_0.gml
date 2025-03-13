for (var xx = 0; xx < (sprite_width / sprite_get_width(sprite_index)); xx++)
{
    for (var yy = 0; yy < (sprite_height / sprite_get_height(sprite_index)); yy++)
    {
        repeat (4)
        {
            create_debris(x + (xx * 32) + 16, y + (yy * 32) + 16, spr_debris, 0);
            scr_destroy_tiles(32, "Tiles_1");
            scr_destroy_tiles(32, "Tiles_2");
            scr_destroy_tiles(32, "Tiles_3");
            scr_destroy_tiles(32, "Tiles_4");
            scr_destroy_tiles(32, "Tiles_Foreground1");
            scr_destroy_tiles(32, "Tiles_Foreground2");
        }
    }
}
