if (scr_3dcheck() || global.hidehud)
    exit;

if (obj_player1.spotlight == 1)
    pal_swap_set(get_charactersprite("spr_palette", obj_player1), obj_player1.paletteselect, 0);
else
    pal_swap_set(get_charactersprite("spr_palette", obj_player2), obj_player2.paletteselect, 0);

if (obj_player.backupweapon == 1)
    draw_sprite_ext(spr_shotgunbackup, -1, 50, 100, 1, 1, 1, c_white, alpha);

if (obj_player.state != states.gameover)
{
    if (obj_player.x < 250 && obj_player.y < 169)
        hud_posY = Approach(hud_posY, -300, 15);
    else
        hud_posY = Approach(hud_posY, 0, 15);
    
    _y = lerp(_y, (global.laps >= 5) ? (obj_screen.actualHeight - 168) : obj_screen.actualHeight, 0.1);
    draw_sprite_ext(spr_dsiheat, -1, 0, _y, 1, 1, 0, c_white, alpha);
    var sw = sprite_get_width(spr_heatmeterds_fill);
    var sh = sprite_get_height(spr_heatmeterds_fill);
    var b = global.stylemultiplier;
    draw_sprite_part(spr_heatmeterds_fill, 0, 0, 0, sw * b, sh, 105, _y + 99);
    var _xoffset = Wave(-2, 2, 4, 2);
    var _yoffset = Wave(-3, 3, 6, 2);
    var _score = global.collect;
    var oghud_xx = 117 + _xoffset;
    var oghud_yy = 127 + hud_posY + _yoffset;
    var hud_xx = oghud_xx + irandom_range(-collect_shake, collect_shake);
    var hud_yy = oghud_yy + irandom_range(-collect_shake, collect_shake);
    var rx = oghud_xx + 110;
    var ry = oghud_yy - 22;
    var rank_ix = 0;
    
    if (_score >= global.srank)
    {
        if (global.lap && global.secretfound >= 3 && global.treasure && !global.combodrop)
            rank_ix = 5;
        else
            rank_ix = 4;
    }
    else if (_score >= global.arank)
    {
        rank_ix = 3;
    }
    else if (_score >= global.brank)
    {
        rank_ix = 2;
    }
    else if (_score >= global.crank)
    {
        rank_ix = 1;
    }
    
    if (previousrank != rank_ix)
    {
        previousrank = rank_ix;
        rank_scale = 3;
    }
    
    rank_scale = Approach(rank_scale, 1, 0.2);
    var spr_w = sprite_get_width(spr_ranks_hudfill);
    var spr_h = sprite_get_height(spr_ranks_hudfill);
    var spr_xo = sprite_get_xoffset(spr_ranks_hudfill);
    var spr_yo = sprite_get_yoffset(spr_ranks_hudfill);
    var perc = 0;
    var _treasure = global.treasure * 25;
    var _secret = global.secretfound * 6.66666666667;
    var _lapped = global.lap * 25;
    var _combodropped = !global.combodrop * 25;
    
    switch (rank_ix)
    {
        case 4:
            if (!global.combodrop)
                perc = (_treasure + _secret + _lapped + _combodropped) / 100;
            
            break;
        
        case 3:
            perc = (_score - global.arank) / (global.srank - global.arank);
            break;
        
        case 2:
            perc = (_score - global.brank) / (global.arank - global.brank);
            break;
        
        case 1:
            perc = (_score - global.crank) / (global.brank - global.crank);
            break;
        
        default:
            perc = _score / global.crank;
    }
    
    var t = spr_h * perc;
    var top = spr_h - t;
    draw_sprite_ext(spr_scorehud, pizzascore_index, oghud_xx, oghud_yy, 1, 1, 0, c_white, alpha);
    draw_sprite_ext(spr_ranks_hud, rank_ix, rx, ry, rank_scale, rank_scale, 0, c_white, alpha);
    
    if (rank_ix != 5)
    {
        draw_sprite_part_ext(spr_ranks_hudfill, rank_ix, 0, top, spr_w, spr_h - top, rx - spr_xo, (ry - spr_yo) + top, rank_scale, rank_scale, c_white, alpha);
    }
    else
    {
        var displayed_ls = global.laps - 1;
        displayed_ls = clamp(displayed_ls, 1, 4);
        var _l_limit = 5;
        
        for (var i = 0; i < displayed_ls; i++)
            draw_sprite_ext(spr_ranks_hudfill, rank_ix, (rx + ((sprite_get_width(spr_ranks_hudfill) / 4) * i)) - ((sprite_get_width(spr_ranks_hudfill) / 4 / 2) * (displayed_ls - 1)), ry, rank_scale, rank_scale, 0, c_white, alpha);
        
        if (global.laps > _l_limit)
        {
            extra_lalpha = 1;
            extra_lshake = approach(extra_lshake, 0, 0.1);
            extra_lshake = clamp(extra_lshake, 0, 5);
            var _xshake = irandom_range(-extra_lshake, extra_lshake);
            var _yshake = irandom_range(-extra_lshake, extra_lshake);
            draw_set_font(global.bigfont);
            draw_set_alpha(extra_lalpha);
            draw_text_scribble(rx + (sprite_get_width(spr_ranks_hudfill) / 1.75) + _xshake, ry + _yshake, "[fa_middle][fa_center]X" + string(global.laps - 5));
            draw_set_alpha(1);
        }
        else
        {
            extra_lalpha = 0;
        }
    }
    
    draw_set_valign(fa_top);
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_font(global.scorefont);
    var text_y = 0;
    
    switch (floor(pizzascore_index))
    {
        case 1:
        case 2:
        case 3:
            text_y = 1;
            break;
        
        case 5:
        case 10:
            text_y = -1;
            break;
        
        case 6:
        case 9:
            text_y = -2;
            break;
        
        case 7:
            text_y = -3;
            break;
        
        case 8:
            text_y = -5;
            break;
    }
    
    var cs = 0;
    
    with (obj_comboend)
        cs += comboscore;
    
    for (var j = 0; j < ds_list_size(global.collect_list); j++)
    {
        var _col = global.collect_list[| j];
        cs += _col.val;
    }
    
    var sc = _score - global.comboscore - cs;
    var str = string(sc);
    var num = string_length(str);
    var w = string_width(str);
    var xx = hud_xx - (w / 2);
    
    if (lastcollect != sc)
    {
        color_array = array_create(num, 0);
        
        for (var i = 0; i < array_length(color_array); i++)
            color_array[i] = irandom(3);
        
        lastcollect = sc;
    }
    
    shader_set(global.Pal_Shader);
    draw_set_alpha(alpha);
    draw_set_color(c_white);
    
    for (var i = 0; i < num; i++)
    {
        var yy = (((i + 1) % 2) == 0) ? -5 : 0;
        var c = color_array[i];
        pal_swap_set(spr_font_palette, c, 0);
        draw_text(xx, (hud_yy - 88) + text_y + yy, string_char_at(str, i + 1));
        xx += (w / num);
    }
    
    draw_set_alpha(1);
    shader_reset();
    draw_set_font(global.bigfont);
    draw_set_halign(fa_center);
    draw_set_color(c_white);
    
    if (marxstunned)
    {
        draw_sprite_ext(spr_marx_head, marx_index, 480 + random_range(-3, 3), 96 + random_range(-3, 3), 1, 1, 0, c_white, marxalphatarget);
        
        if (marxseconds < 10)
            draw_text(480 + random_range(-1, 1), 96, string_hash_to_newline("0:0" + string(marxseconds)));
        else if (marxseconds >= 10)
            draw_text(480 + random_range(-1, 1), 96, string_hash_to_newline("0:" + string(marxseconds)));
    }
}

draw_set_blend_mode(bm_normal);
