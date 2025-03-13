if (room == rank_room)
{
    shader_set(global.Pal_Shader);
    pal_swap_set(spr_rankbgpal, bgPalette, 0);
    draw_sprite_tiled_ext(bg_rank, 0, bgX, bgY, 1, 1, c_white, 1);
    shader_reset();
}

draw_set_alpha(fadealpha);
draw_set_color(c_white);
draw_rectangle(0, 0, obj_screen.actualWidth, obj_screen.actualHeight, false);
draw_set_alpha(flash);
draw_rectangle(0, 0, obj_screen.actualWidth, obj_screen.actualHeight, false);
draw_set_alpha(1);

if (!instance_exists(obj_rank) && room != Tutori_1 && fadein == 1)
{
    shader_set(global.Pal_Shader);
    
    with (obj_player1)
    {
        pal_swap_set(spr_palette, paletteselect, 0);
        draw_sprite_ext(sprite_index, image_index, x, y + other.yp, xscale, yscale, image_angle, image_blend, image_alpha);
    }
    
    shader_reset();
}
