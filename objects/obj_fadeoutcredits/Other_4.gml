if (room == Titlescreen && obj_player1.state == 8)
{
    obj_player1.sprite_index = spr_player_machfreefall;
    obj_player1.state = states.backbreaker;
    obj_player1.movespeed = 6;
    obj_player1.vsp = 5;
    obj_player1.xscale = 1;
    obj_player1.player_x = 50;
    obj_player1.player_y = 50;
}
