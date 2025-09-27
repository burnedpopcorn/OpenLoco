if (!bbox_in_camera(view_camera[0], 32))
    exit;

if (!hasLayer || !surface_exists(tile_surface))
    draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, 0, c_white, alpha);

if (hasLayer && surface_exists(tile_surface) && array_length(tiles) > 0)
{
    surface_set_target(tile_surface);
    
    for (var k = 0; k < array_length(tilemap_sprite); k++)
    {
        if (tilemap_sprite[k] != noone)
        {
            for (var i = 0; i < array_length(tiles[k]); i++)
            {
                var b = tiles[k][i];
                draw_tile(tilemap_sprite[k], b.data, 0, b.x - x, b.y - y);
                gpu_set_blendmode(bm_subtract);
                draw_circle_color(obj_player1.x - x, obj_player1.y - y, circle_radius, c_black, c_black, false);
                gpu_set_blendmode(bm_normal);
            }
        }
    }
    
    surface_reset_target();
    draw_surface(tile_surface, x, y);
}
