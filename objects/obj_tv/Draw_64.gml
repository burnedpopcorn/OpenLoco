if (global.hidehud)
    exit;

var tv_x = obj_screen.actualWidth - 115;
var tv_y = 80;
var _cx = tv_x + combo_posX;
var _cy = tv_y + 121 + hud_posY + combo_posY;
var _perc = global.combotime / 60;
var _minX = _cx - 56;
var _maxX = _cx + 59;
combofill_x = lerp(combofill_x, _minX + ((_maxX - _minX) * _perc), 0.5);
combofill_y = _cy;
draw_sprite(spr_tv_combobubblefill, combofill_index, combofill_x, combofill_y);
draw_sprite(spr_tv_combobubble, -1, _cx, _cy);
draw_set_font(global.combofont2);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
var _tx = _cx - 69;
var _ty = _cy + 6;
var _str = string(global.combo);
var num = string_length(_str);

for (var i = num; i > 0; i--)
{
    var char = string_char_at(_str, i);
    draw_text(_tx, _ty, char);
    _tx -= 22;
    _ty -= 8;
}

if (!surface_exists(tvbg_surface))
{
    tvbg_surface = surface_create(161, 124);
}
else if (surface_exists(tvbg_surface) && state != TVstates.start)
{
    var _surforigin = [surface_get_width(tvbg_surface) / 2, surface_get_height(tvbg_surface) / 2];
    surface_set_target(tvbg_surface);
    
    if (!sprite_exists(global.hub_bgsprite) || sprite_get_number(global.hub_bgsprite) <= 3)
        global.hub_bgsprite = spr_gatetutorial;
    
    for (var i = 3; i < sprite_get_number(global.hub_bgsprite); i++)
        draw_sprite_tiled(global.hub_bgsprite, i, tvbg_scroll / (sprite_get_number(global.hub_bgsprite) - (i - 3)), -75);
    
    draw_set_alpha(tvbg_secret_alpha);
    
    for (var i = 0; i < sprite_get_number(spr_tv_bgsecret); i++)
        draw_sprite_tiled(spr_tv_bgsecret, i, tvbg_secret_scroll / (sprite_get_number(spr_tv_bgsecret) - i), tvbg_secret_scroll / (sprite_get_number(spr_tv_bgsecret) - i));
    
    draw_set_alpha(1);
    gpu_set_blendmode(bm_subtract);
    draw_sprite(spr_tv_mask, 0, _surforigin[0], _surforigin[1]);
    gpu_set_blendmode(bm_normal);
    surface_reset_target();
    
    if (global.panic)
        shader_set(shd_panicfx);
    
    draw_surface_ext(tvbg_surface, tv_x - _surforigin[0] - 8, ((tv_y + hud_posY) - _surforigin[1]) + 6, image_xscale, image_yscale, image_angle, image_blend, alpha);
    shader_reset();
}

if (usepalette)
    pal_swap_set(spr_tvpalette_damian, obj_player1.paletteselect, 0);

draw_sprite_ext(sprite_index, image_index, tv_x, tv_y + hud_posY, 1, 1, 0, c_white, alpha);
shader_reset();
var _frame = get_charactersprite("spr_tvframe");

if (state == TVstates.whitenoise)
    _frame = get_charactersprite("spr_tvwhitenoise");

if (sprite_index != spr_tvnoclip_damian)
    draw_sprite_ext(_frame, whitenoise_index, tv_x, tv_y + hud_posY, 1, 1, 0, c_white, alpha);

if (bubblespr != noone)
    draw_sprite_ext(bubblespr, bubbleindex, 512, 53, 1, 1, 1, c_white, alpha);

if (!surface_exists(promptsurface))
    promptsurface = surface_create(290, 102);

surface_set_target(promptsurface);
draw_clear_alpha(c_black, 0);
draw_set_font(font1);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_set_font(alpha);

if (bubblespr == spr_tv_bubble)
{
    promptx -= promptspd;
    
    if (bubblespr != spr_tv_bubbleclose && promptx < (350 - string_width(prompt)))
    {
        bubblespr = spr_tv_bubbleclose;
        bubbleindex = 0;
    }
    
    draw_text_color(promptx - 350, 50, prompt, c_black, c_black, c_black, c_black, 1);
}

draw_set_halign(fa_left);
surface_reset_target();
draw_surface(promptsurface, 350, 0);
draw_set_font(global.bigfont);
draw_set_halign(fa_center);
draw_set_color(c_white);
draw_set_font(alpha);

if (global.hurtcounter == global.hurtmilestone && !instance_exists(obj_transformationtext))
{
    with (instance_create(x, y, obj_transformationtext))
        message = "You've hurt Damian " + string(global.hurtmilestone) + " Times..";
    
    global.hurtmilestone += 5;
}

if (global.panic)
{
    var _fill = global.fill;
    var _currentbarpos = chunkmax - _fill;
    _perc = _currentbarpos / chunkmax;
    var _max_x = 299;
    var _max_patrickspeed = 0.35;
    var _max_patrickshake = 3;
    var _barpos = _max_x * _perc;
    var _shakejohn = _max_patrickshake * _perc;
    var patrickspeed = _max_patrickspeed * _perc;
    patricksun_index += patrickspeed;
    draw_sprite(spr_timer_bar, -1, timer_x, timer_y);
    
    if (!surface_exists(bar_surface))
        bar_surface = surface_create(298, 36);
    
    var _barfillpos = floor(_barpos) + 13;
    
    if (_barfillpos > 0)
    {
        surface_resize(bar_surface, _barfillpos, 36);
        surface_set_target(bar_surface);
        draw_clear_alpha(c_black, 0);
        var clip_x = timer_x;
        var clip_y = timer_y;
        draw_sprite(spr_timer_barfillday, 0, 0, 0);
        
        for (var i = 0; i < 3; i++)
            draw_sprite(spr_timer_barfill, 0, barfill_x + (i * 306), 0);
        
        surface_reset_target();
        draw_surface(bar_surface, clip_x, clip_y);
    }
    
    draw_sprite(patricksun_sprite, patricksun_index, timer_x + 13 + _barpos + shakeboth(_shakejohn), timer_y + 20 + shakeboth(_shakejohn));
    draw_sprite(marx_sprite, marx_index, timer_x + 320, timer_y + 10);
    draw_set_font(global.bigfont);
    var shakingy = 0;
    var shakingx = 0;
    
    if (obj_camera.addseconds > 0)
    {
        draw_set_color(c_green);
        text_shakemagnitude = obj_camera.addseconds / 10;
    }
    else if (global.minutes == 0 && global.seconds <= 60)
    {
        text_shakemagnitude += 0.00277778;
        draw_set_color(c_red);
    }
    else
    {
        draw_set_color((global.seconds <= 30 && global.minutes == 0) ? c_red : c_white);
        text_shakemagnitude = 0;
    }
    
    if (global.seconds < 10)
        draw_text(timer_x + 149 + irandom_range(-text_shakemagnitude, text_shakemagnitude), (timer_y - 32) + irandom_range(-text_shakemagnitude, text_shakemagnitude), string_hash_to_newline(string_hash_to_newline(string(global.minutes) + ":0" + string(global.seconds))));
    else if (global.seconds >= 10)
        draw_text(timer_x + 149 + irandom_range(-text_shakemagnitude, text_shakemagnitude), (timer_y - 32) + irandom_range(-text_shakemagnitude, text_shakemagnitude), string_hash_to_newline(string_hash_to_newline(string(global.minutes) + ":" + string(global.seconds))));
}
