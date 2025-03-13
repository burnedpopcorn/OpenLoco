if (place_meeting(x, y - 1, obj_player1) && obj_player1.state != states.gameover)
{
    obj_player1.state = 6;
    obj_player1.image_index = 0;
    obj_player1.vsp = -20;
    obj_player1.movespeed = obj_player1.hsp;
    obj_player1.sprite_index = get_charactersprite("spr_fireass", obj_player1);
}

if (place_meeting(x, y - 1, obj_player2) && obj_player2.state != states.gameover)
{
    obj_player2.state = 6;
    obj_player2.image_index = 0;
    obj_player2.vsp = -25;
    obj_player2.sprite_index = get_charactersprite("spr_fireass", obj_player2);
}
