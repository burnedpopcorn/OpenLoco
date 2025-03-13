ini_open_from_string(obj_savesystem.ini_str);

if (level != "tutorial" && ini_read_real("Highscore", level, 0) != 0)
{
    draw_sprite_ext(spr_scoregate, 0, x + 5, score_y, score_scale, score_scale, image_angle, c_white, image_alpha);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_font(global.collectfontds);
    draw_text_transformed(x, score_y - 20, highscore, score_scale, score_scale, 0);
}

if (!surface_exists(bgsurfcase) && sprite_get_number(sprite_index) > 3)
{
    bgsurfcase = surface_create(sprite_width, sprite_height);
}
else if (surface_exists(bgsurfcase) && sprite_get_number(sprite_index) > 3)
{
    surface_set_target(bgsurfcase);
    
    for (var i = 3; i < sprite_get_number(sprite_index); i++)
        draw_sprite_tiled(sprite_index, i, bg_scroll / (sprite_get_number(sprite_index) - (i - 3)), sprite_height);
    
    gpu_set_blendmode(bm_subtract);
    draw_sprite(sprite_index, 1, 0 + sprite_xoffset, 0 + sprite_yoffset);
    gpu_set_blendmode(bm_normal);
    surface_reset_target();
    draw_surface(bgsurfcase, x - sprite_xoffset, y - sprite_yoffset);
}

draw_set_alpha(alphagate);
draw_sprite(sprite_index, 2, x, y);
draw_set_alpha(1);
draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if (level != "tutorial" && ini_read_real("Highscore", level, 0) != 0)
{
    var lranks = laps - 1;
    draw_sprite_ext(spr_ranks_hud, rank_index, x + irandom_range(-rank_shakepower, rank_shakepower), (y + irandom_range(-rank_shakepower, rank_shakepower)) - 85, rank_scale, rank_scale, 0, c_white, rank_appear);
    
    if (rank == "l" || rank == "p")
    {
        for (var i = 0; i < lranks; i++)
            draw_sprite_ext(spr_ranks_hudfill, 5, (x + irandom_range(-rank_shakepower, rank_shakepower) + ((sprite_get_width(spr_ranks_hudfill) / 4) * i)) - ((sprite_get_width(spr_ranks_hudfill) / 4 / 2) * (lranks - 1)), (y + irandom_range(-rank_shakepower, rank_shakepower)) - 85, rank_scale, rank_scale, 0, c_white, rank_appear);
    }
}

ini_close();
