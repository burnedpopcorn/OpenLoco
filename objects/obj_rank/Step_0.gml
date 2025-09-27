scr_getinput();
bgX++;
bgY++;

if (floor(image_index) == (image_number - 1))
    image_speed = 0;

if (image_index == 7 && !changebg)
{
    var rank_map = ds_map_create();
    rank_map[? "l"] = 6;
    rank_map[? "s"] = 5;
    rank_map[? "a"] = 4;
    rank_map[? "b"] = 3;
    rank_map[? "c"] = 2;
    rank_map[? "d"] = 1;
    
    with (obj_endlevelfade)
    {
        bgPalette = rank_map[? global.rank];
        flash = 1;
    }
    
    changebg = true;
}

if (move && sprite_index != spr_rankL)
    x = lerp(x, 704, 0.1);

if (instance_exists(obj_endlevelfade) && !fmod_studio_event_instance_is_valid(obj_endlevelfade.music_instance))
{
    if (music == noone)
    {
        music = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/music/level_structure/rankresult"));
        fmod_studio_event_instance_set_parameter_by_name(music, "state", global.rank == "l", true);
        fmod_studio_event_instance_start(music);
    }
    
    var BGalphaTarget = 1;
    var BGalphaAccel = 0.1;
    var targetScale = 0.2;
    var scaleAccel = 0.1;
    var darkAlphaTarget = 0.75;
    var darkAlphaAccel = 0.1;
    var curtainJumpspdDiv = 2;
    var tableyTarget = 484;
    var statspointsAccel = 0.05;
    var statspointsShaketimeMax = 10;
    var curtainGrav = 1;
    var addLrankWaitMax = 10;
    var tableyAccel = 0.1;
    var shakeCooldown = 15;
    var lapShaketimeMax = 15;
    var toppinUnlockWaitMax = 20;
    var eggxTarget = 768;
    var eggxAccel = 0.1;
    var eggShaketimeMax = 10;
    var eggWaitMax = 10;
    var treasureShaketimeMax = 15;
    var curtainAccel = 0.2;
    
    switch (cutscene_state)
    {
        case 0:
            move = 1;
            
            if (curtain_vsp < 20)
                curtain_vsp += curtainGrav;
            
            curtain_ypos += curtain_vsp;
            curtain_ypos = clamp(curtain_ypos, -960, 0);
            var curtainGrounded = curtain_ypos >= 0;
            
            if (curtainGrounded)
            {
                curtain_vsp = 0;
                
                if (curtain_jumpspd > 0 && curtain_jumpspd < 1)
                    curtain_jumpspd = frac(curtain_jumpspd);
                
                if (curtain_jumpspd > 1)
                {
                    curtain_jumpspd /= curtainJumpspdDiv;
                    curtain_vsp = -curtain_jumpspd;
                    fmod_studio_event_oneshot("event:/sfx/player/punch");
                    trace("grounded");
                }
                else
                    cutscene_state++;
            }
            
            break;
        
        case 1:
            dark_alpha = Approach(dark_alpha, darkAlphaTarget, darkAlphaAccel);
            
            if (dark_alpha == darkAlphaTarget)
            {
                if (alarm[1] == -1)
                    alarm[1] = 50;
            }
            
            break;
        
        case 2:
            cutscene_state++;
            break;
        
        case 3:
            light_scale = approach(light_scale, targetScale, scaleAccel);
            
            if (light_scale == targetScale)
            {
                if (alarm[1] == -1)
                    alarm[1] = 50;
            }
            
            break;
        
        case 4:
            stats_monitor_ypos = lerp(stats_monitor_ypos, 0, 0.1);
            
            if (stats_monitor_ypos == 0)
                cutscene_state++;
            
            break;
        
        case 5:
            var oldPoints = stats_points;
            stats_points = lerp(stats_points, total_points, statspointsAccel);
            
            if (floor(stats_points) != floor(oldPoints))
                fmod_studio_event_oneshot("event:/sfx/level_structure/collects/normal");
            
            if (stats_points == total_points || key_jump || stats_points > (total_points - 1))
            {
                stats_points = total_points;
                stats_points_shake_time = statspointsShaketimeMax;
                fmod_studio_event_oneshot("event:/sfx/player/punch");
                cutscene_state++;
            }
            
            break;
        
        case 6:
            if (stats_points_shake_time > 0)
                stats_points_shake_time--;
            else
                cutscene_state++;
            
            break;
        
        case 7:
            if (time_mins < total_mins)
                time_mins++;
            
            if (time_secs < total_secs)
                time_secs++;
            
            time_mms = total_mms;
            
            if (time_mins == total_mins && time_secs == total_secs && time_mms == total_mms)
            {
                fmod_studio_event_oneshot("event:/sfx/player/punch");
                stats_time_shake_time = 20;
                cutscene_state++;
            }
            
            break;
        
        case 8:
            if (stats_time_shake_time > 0)
                stats_time_shake_time--;
            else
                cutscene_state++;
            
            break;
        
        case 9:
            var countLs = false;
            
            if (lap && laps > 1 && rank == "l")
                countLs = true;
            
            if (rank_visible == false)
            {
                var rank_map = ds_map_create();
                rank_map[? "l"] = 5;
                rank_map[? "s"] = 4;
                rank_map[? "a"] = 3;
                rank_map[? "b"] = 2;
                rank_map[? "c"] = 1;
                rank_map[? "d"] = 0;
                var rankValue = rank_map[? rank];
                
                if (countLs)
                {
                    showLs = true;
                    add_Lranks_wait = 10;
                }
                else
                    alarm[1] = 50;
                
                if (rankValue >= 4)
                    fmod_studio_event_oneshot("event:/sfx/rank/result");
                else if (rankValue == 0)
                    fmod_studio_event_oneshot("event:/sfx/rank/result_bad");
                
                rank_scale = 2;
                rank_visible = true;
            }
            
            if (showLs)
            {
                if (add_Lranks_wait > 0)
                    add_Lranks_wait--;
                else if ((array_length(Lrank_array) + extraLs) < (laps - 1))
                {
                    if (array_length(Lrank_array) == 5)
                        extraLs++;
                    else
                    {
                        array_push(Lrank_array, 
                        {
                            scale: 2,
                            impact: 0,
                            shake: 0
                        });
                    }
                    
                    add_Lranks_wait = addLrankWaitMax;
                }
                else
                {
                    alarm[1] = 50;
                    showLs = false;
                }
            }
            
            rank_scale = Approach(rank_scale, 1, 0.2);
            break;
        
        case 10:
            if (!lap)
                cutscene_state++;
            else
            {
                lap_monitor_ypos = lerp(lap_monitor_ypos, 0, 0.1);
                
                if (lap_monitor_ypos == 0)
                    cutscene_state++;
            }
            
            break;
        
        case 11:
            if (!lap)
                cutscene_state++;
            
            if (laps < total_laps)
            {
                fmod_studio_event_oneshot("event:/sfx/player/step");
                laps++;
            }
            else
            {
                fmod_studio_event_oneshot("event:/sfx/player/punch");
                laps_monitor_shake_time = lapShaketimeMax;
                cutscene_state++;
            }
            
            break;
        
        case 12:
            if (!lap)
                cutscene_state++;
            
            if (laps_monitor_shake_time > 0)
                laps_monitor_shake_time--;
            else if (alarm[1] == -1)
                alarm[1] = 50;
            
            break;
        
        case 13:
            show_treasure = true;
            fmod_studio_event_oneshot(gottreasure ? "event:/sfx/rank/plush" : "event:/sfx/player/slip/bump");
            treasure_scale = 2;
            cutscene_state++;
            break;
        
        case 14:
            treasure_scale = Approach(treasure_scale, 1, 0.2);
            
            if (treasure_scale == 1)
            {
                treasure_shake_time = treasureShaketimeMax;
                cutscene_state++;
            }
            
            break;
        
        case 15:
            if (treasure_shake_time > 0)
                treasure_shake_time--;
            else if (alarm[1] == -1)
                alarm[1] = 50;
            
            break;
        
        case 16:
            table_y = lerp(table_y, tableyTarget, tableyAccel);
            
            if (table_y == tableyTarget)
            {
                if (alarm[1] == -1)
                    alarm[1] = 50;
            }
            
            break;
        
        case 17:
            toppin_unlock_wait = 20;
            cutscene_state++;
            break;
        
        case 18:
            if (toppin_unlock_wait > 0)
                toppin_unlock_wait--;
            else if (toppin_num <= (array_length(toppin_arr) - 1))
            {
                var t = toppin_arr[toppin_num];
                
                if (t.collected)
                    t.sprite_index = t.unlockedspr;
                else
                    t.shake = 15;
                
                fmod_studio_event_oneshot(t.collected ? "event:/sfx/rank/plush" : "event:/sfx/player/slip/bump");
                toppin_unlock_wait = 20;
                toppin_num++;
            }
            else
                cutscene_state++;
            
            break;
        
        case 19:
            eggs_x = lerp(eggs_x, eggxTarget, eggxAccel);
            
            if (eggs_x == eggxTarget)
                cutscene_state++;
            
            break;
        
        case 20:
            if (egg_wait > 0)
                egg_wait--;
            else if (egg_num <= (array_length(egg_arr) - 1))
            {
                if ((egg_num + 1) <= global.secretfound)
                    egg_arr[egg_num].done = true;
                else
                    egg_arr[egg_num].shake = eggShaketimeMax;
                
                egg_num++;
                egg_wait = eggWaitMax;
            }
            else
                cutscene_state++;
            
            break;
        
        case 21:
            if (key_jump2)
            {
                cutscene_state++;
                levelvolume = 0;
            }
            
            break;
        
        case 22:
            curtain_xpos_mult = lerp(curtain_xpos_mult, 1, curtainAccel);
            
            if (curtain_xpos_mult == 1)
            {
                if (!instance_exists(obj_fadecircle))
                {
                    instance_create(x, y, obj_fadecircle);
                    cutscene_state++;
                }
            }
            
            break;
    }
}

if (room != rank_room)
    instance_destroy();
