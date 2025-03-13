draw_set_font(global.smallerfont);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_text(x + shakeboth(1), y + shakeboth(1), "WOW! The game just crashed on your whole face!\n\n\nIsnt that great?");
draw_text(x + shakeboth(1), 476 + shakeboth(1), "Close the game btw you got an error.");
draw_sprite_ext(spr_patrickcrash, -1, room_width / 2, room_height / 2, 1, 1, angle, c_white, 1);
draw_set_halign(fa_center);
draw_text((room_width / 2) + shakeboth(1), (room_height / 2) + 50 + shakeboth(1), "Epic fail!");
