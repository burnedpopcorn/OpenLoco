if (jumpscare)
    draw_sprite_ext(spr_PTGGGGGGGG, 0, 480 + random_range(-3, 3), 270 + random_range(-3, 3), xscale, yscale, 0, c_white, 1);

var creditsfont = __scribble_font_add_sprite_ext(spr_creditsfont, "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz.:!0123456789?'\"ÁÉÍÓÚáéíóú_-[]▼()&#风雨廊桥전태양*яиБжидГзвбнль", 1, 2);
draw_set_color(c_black);
draw_set_alpha(fade);
draw_rectangle(0, 0, 960, 540, false);
draw_set_color(c_white);
draw_set_alpha(1);

if (ending)
{
    var _VideoData = video_draw();
    var _VideoStatus = _VideoData[0];
    
    if (_VideoStatus == 0)
        draw_surface(_VideoData[1], 185, 20);
    
    draw_set_font(creditsfont);
    draw_set_halign(fa_center);
    draw_text(480 + random_range(1, -1), 480, "Feliz dia del pendejo mensos!!!!!!");
}
