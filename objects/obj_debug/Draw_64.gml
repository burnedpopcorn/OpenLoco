if (showdetails == true && !instance_exists(obj_textbox))
{
    draw_set_font(global.smallerfont);
    draw_set_halign(fa_left);
    draw_set_color(c_white);
    var roomname = room_get_name(room);
    var spritename = sprite_get_name(obj_player1.sprite_index);
    var yy = 300;
	
    draw_text_color(15, yy, "HSP: " + string(obj_player1.hsp), c_white, c_white, c_gray, c_gray, 1);
    yy += 24;
    draw_text_color(15, yy, "VSP: " + string(obj_player1.vsp), c_white, c_white, c_gray, c_gray, 1);
    yy += 24;
    draw_text_color(15, yy, "Room: " + string(roomname), c_white, c_white, c_gray, c_gray, 1);
    yy += 24;
    draw_text_color(15, yy, "Character: " + get_charactername(obj_player1), c_white, c_white, c_gray, c_gray, 1);
    yy += 24;
    draw_text_color(15, yy, "Sprite: " + string(spritename), c_white, c_white, c_gray, c_gray, 1);
    yy += 24;
    draw_text_color(15, yy, "X: " + string(obj_player1.x), c_white, c_white, c_gray, c_gray, 1);
    yy += 24;
    draw_text_color(15, yy, "Y: " + string(obj_player1.y), c_white, c_white, c_gray, c_gray, 1);
    yy += 24;
    draw_text_color(15, yy, "FPS: " + string(fps_real), c_white, c_white, c_gray, c_gray, 1);
    yy += 24;
    draw_text_color(15, yy, "Music Timeline Position: " + string(fmod_studio_event_instance_get_timeline_position(global.music.event_instance)), c_white, c_white, c_gray, c_gray, 1);
    yy += 24;
    draw_text_color(15, yy, "TV Expression Que " + string(ds_list_size(obj_tv.expression_que)), c_white, c_white, c_gray, c_gray, 1);
}
