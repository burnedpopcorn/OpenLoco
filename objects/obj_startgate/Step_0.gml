drawing = place_meeting(x, y, obj_player);
bg_scroll += 2;

if (place_meeting(x, y, obj_doorA))
    targetdoorhub = "A";

if (place_meeting(x, y, obj_doorB))
    targetdoorhub = "B";

if (place_meeting(x, y, obj_doorC))
    targetdoorhub = "C";

if (place_meeting(x, y, obj_doorD))
    targetdoorhub = "D";

if (place_meeting(x, y, obj_doorE))
    targetdoorhub = "E";

if (sprite_get_number(sprite_index) > 3)
    alphagate = distance_to_object(obj_player1) / 150;
else
    alphagate = 1;

ini_open_from_string(obj_savesystem.ini_str);

if (drawing && ini_read_real("Highscore", level, 0) != 0 && !instance_exists(obj_exitbubble))
{
    score_scale = lerp(score_scale, 1, 0.1);
    score_y = lerp(score_y, y - 150, 0.1);
    
    if (alarm[0] == -1 && !rank_appear)
        alarm[0] = 30;
}
else
{
    score_scale = lerp(score_scale, 0.5, 0.1);
    score_y = lerp(score_y, y, 0.1);
}

ini_close();

if (rank_appear)
{
    rank_scale = Approach(rank_scale, 1, 0.0667);
    rank_shakepower = Approach(rank_shakepower, 0, 0.05);
}
