targetDoor = "A";
targetdoorhub = "A";
title_music = "event:/music/world_1/hallway_longway/hall_title";
titlecard_sprite = spr_titlecardhall;
title_sprite = spr_titlehall;
rankindex = 0;
msg = "";
highscore = 0;
secret_count = 0;
alphagate = 1;
toppin = array_create(5, 0);
treasure = false;
depth = 50;
level = "none";
rank = "none";
drawing = 0;
bgsurfcase = noone;
score_scale = 0.5;
score_y = y;
rank_appear = false;
rank_scale = 3;
rank_shakepower = 0;
rank_index = 0;
durationspeed = array_create_ext(3, function(argument0)
{
    return (argument0 + 1) * 2;
});
depthegg = array_create_ext(3, function(argument0)
{
    return argument0 + 1;
});
eggsecret = array_create_ext(3, function(argument0)
{
    return argument0 + 1;
});
durationspeedy = array_create_ext(3, function(argument0)
{
    return (argument0 + 1) * 5;
});
eggsprite = array_create_ext(3, function(argument0)
{
    return (secret_count >= (argument0 + 1)) ? spr_gateegg_opened : spr_gateegg_unopened;
});
toppinsprite = 
{
    idle: [spr_pizzakinshroom, spr_pizzakincheese, spr_pizzakintomato, spr_pizzakinsausage, spr_pizzakinpineapple],
    run: [spr_pizzakinshroom_run, spr_pizzakincheese_run, spr_pizzakintomato_run, spr_pizzakinsausage_run, spr_pizzakinpineapple_run],
    taunt: [spr_toppinshroom_taunt, spr_toppincheese_taunt, spr_toppintomato_taunt, spr_toppinsausage_taunt, spr_toppinpineapple_taunt]
};
donotrepeat = 0;
laps = 0;
bg_scroll = 0;

for (var n = 0; n < array_length(durationspeed); n++)
{
    x_move[n] = 0;
    y_move[n] = 0;
}
