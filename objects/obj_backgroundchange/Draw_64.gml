if (!ending)
{
    draw_set_alpha(0.75);
    draw_rectangle_color(0, 0, 960, 540, c_red, c_red, c_red, c_red, false);
    
    for (var i = 0; i < sprite_get_number(spr_punchrocks); i++)
        draw_sprite_tiled(spr_punchrocks, i, 0, rock_y - irandom_range(0, sprite_get_number(spr_punchrocks)));
    
    draw_set_alpha(1);
    draw_sprite(spr_punchcustene, -1, 0, yoffest);
}
