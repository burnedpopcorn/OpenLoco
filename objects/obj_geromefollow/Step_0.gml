if (room == rank_room || room == timesuproom)
    visible = false;

if (obj_player1.spotlight == 1)
    playerid = obj_player1;
else
    playerid = obj_player2;

image_speed = 0.35;
depth = -6;

if (global.panic)
{
    spr_idle = spr_gerome_keyidle_panic;
    spr_move = spr_gerome_keymove_panic;
}
else
{
    spr_idle = spr_gerome_keyidle;
    spr_move = spr_gerome_keymove;
}
