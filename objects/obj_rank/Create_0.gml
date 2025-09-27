image_speed = 0.5;
alarm[0] = -1;
depth = -800;
levelvolume = 1;
changebg = false;
move = 0;
cutscene_state = 0;
curtain_xpos_mult = 0.55;
curtain_vsp = 0;
curtain_ypos = -sprite_get_height(spr_rankcurtainL);
curtain_jumpspd = 12;
rank = global.rank;
light_scale = 1;
stats_monitor_ypos = -sprite_get_height(spr_rankstatsTV);
show_points = false;
total_points = global.collect;
stats_points = 0;
show_time = false;
total_time_hours = 0;
total_time_minutes = 0;
total_time_seconds = 0;
total_time_miliseconds = 0;
rank_scale = 1;
rank_visible = false;
stats_time = "";
time_mins = 0;
time_secs = 0;
time_mms = 0;
laps = global.laps;
total_mins = global.level_minutes;
total_secs = floor(global.level_seconds);
var mm = frac(total_secs);
mm = string(mm);
mm = string_copy(mm, 3, string_length(mm) - 3);

while (string_length(mm) < 1)
    mm += "0";

while (string_length(mm) > 2)
    mm = string_delete(mm, string_length(mm), 1);

trace(mm);
total_mms = real(mm);
lap_monitor_ypos = -sprite_get_height(spr_ranklapcounter);
show_laps = false;
total_laps = global.laps;
dark_surface = noone;
dark_alpha = 0;
afterrankmusic = noone;
sprite_index = asset_get_index(concat("spr_rank", string_upper(global.rank)));

create_toppin = function(_collected, _sprite, _unlocked_spr, _offset = 0)
{
    return 
    {
        collected: _collected,
        resultUnlocked: false,
        sprite_index: _sprite,
        index: 0,
        unlockedspr: _unlocked_spr,
        offset: _offset,
        lockedspr: _sprite,
        shake: 0
    };
};

toppin_arr = 
[
	create_toppin(global.shroomfollow, spr_ranktoppin_locked, spr_ranktoppin_unlocked1), 
	create_toppin(global.cheesefollow, spr_ranktoppin_locked, spr_ranktoppin_unlocked1), 
	create_toppin(global.tomatofollow, spr_ranktoppin_locked, spr_ranktoppin_unlocked1), 
	create_toppin(global.sausagefollow, spr_ranktoppin_locked, spr_ranktoppin_unlocked1), 
	create_toppin(global.pineapplefollow, spr_ranktoppin_locked, spr_ranktoppin_unlocked1, 4)
];
Lrank_array = [];
add_Lranks_wait = 0;
extraLs = 0;
showLs = false;
laps_monitor_shake_time = 0;
toppin_num = 0;
toppin_unlock_wait = 0;
gottreasure = global.treasure;
treasure_scale = 1;
show_treasure = false;
treasure_shake_time = 0;
stats_points_shake_time = 0;
stats_time_shake_time = 0;
lap = global.laps > 1;
table_x = 352;
table_y = 638;
bgX = 0;
bgY = 0;
bg_alpha = 0;
eggs_x = 992;
eggs_y = 192;
egg_arr = array_create(3, 
{
    done: false,
    shake: 0
});
egg_num = 0;
egg_wait = 0;
light_len = 100;
light_angle = 100;
music = noone;
