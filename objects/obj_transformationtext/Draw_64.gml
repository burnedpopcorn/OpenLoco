t++;
draw_set_font(global.creditsfont);
draw_set_halign(fa_center);
var textmid = string_width(message) / 2;
var tx = (obj_screen.actualWidth / 2) - textmid;
var ty = obj_screen.actualHeight - 64;

for (var i = 0; i < string_length(message); i++)
{
    var stringy = string_copy(message, i + 1, 1);
    var so = t + i;
    var shiftY = 0;
    var shiftX = 0;
    var isKey = false;
    var isEffect = false;
    var keystr = "";
    
    switch (string_copy(message, i + 1, 3))
    {
        case "[J]":
            keystr = text_get_key(global.key_jump);
            break;
        
        case "[G]":
            keystr = text_get_key(global.key_slap);
            break;
        
        case "[T]":
            keystr = text_get_key(global.key_taunt);
            break;
        
        case "[S]":
            keystr = text_get_key(global.key_shoot);
            break;
        
        case "[M]":
            keystr = text_get_key(global.key_attack);
            break;
        
        case "[D]":
            keystr = text_get_key(global.key_down);
            break;
        
        case "[U]":
            keystr = text_get_key(global.key_up);
            break;
        
        case "[L]":
            keystr = text_get_key(global.key_left);
            break;
        
        case "[R]":
            keystr = text_get_key(global.key_right);
            break;
    }
    
    if (keystr != "")
    {
        i += 2;
        isKey = true;
    }
    
    switch (effect)
    {
        case texteffect.smoothupdown:
            shiftY += (sin((so * pi * freq) / room_speed) * amplitude);
            break;
        
        case texteffect.crazyshake:
            shiftY += irandom_range(-1, 1);
            shiftX += irandom_range(-1, 1);
            break;
        
        case texteffect.randupdown:
            shiftY += floor(wave(-1, 1, 0.2, 0) * ((((i + 1) % 2) == 0) ? -1 : 1));
            break;
    }
    
    var col = make_color_hsv(t + i, 255, 255);
    var col2 = make_color_hsv(t + i + 75, 255, 255);
    
    if (isKey)
    {
        draw_sprite(keystr[0], keystr[1], (tx + shiftX) - (sprite_get_width(spr_tutorialkey) / 2), ty + shiftY);
        draw_set_color(c_black);
        draw_set_font(global.tutorialfont);
        draw_set_halign(fa_left);
        draw_set_valign(fa_top);
        draw_text(tx + shiftX, ty + shiftY, keystr[2]);
        tx += sprite_get_width(spr_tutorialkey);
        draw_set_font(global.creditsfont);
        draw_set_color(c_white);
    }
    else
    {
        draw_text_transformed_color(tx + shiftX, (obj_screen.actualHeight - 64) + shiftY, stringy, 1, 1, 0, col, col, col2, col2, alpha);
        tx += string_width(stringy);
    }
}
