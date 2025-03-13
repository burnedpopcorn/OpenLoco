var _VideoData = video_draw();
var _VideoStatus = _VideoData[0];

if (_VideoStatus == 0)
    draw_surface(_VideoData[1], 200, 50);

draw_set_font(global.creditsfont);
draw_set_halign(fa_center);
draw_set_alpha(alpha);
draw_text(480 + random_range(1, -1), 480, "Press X to Skip.");
draw_set_alpha(1);
