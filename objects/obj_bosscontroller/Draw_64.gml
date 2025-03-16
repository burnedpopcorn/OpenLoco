draw_set_alpha(intro_scene.back_alpha);

if (intro_scene.back_shown)
{
    draw_sprite_tiled(spr_versusflame, 0, time, time / 10);
}
else
{
    draw_set_color(c_white);
    draw_rectangle(0, 0, obj_screen.actualWidth, obj_screen.actualHeight, false);
}

var p1_sp_width = sprite_get_height(intro_scene.p1.sprite);
var p2_sp_width = sprite_get_width(intro_scene.p2.sprite);
var p1_x = intro_scene.p1.xoff;
var p2_x = (obj_screen.actualWidth - p2_sp_width) + intro_scene.p2.xoff;
draw_set_alpha(intro_scene.portraits_alpha);

if (intro_scene.portrait_back)
{
    var draw_vsboxhalf = function(argument0, argument1)
    {
        var _surf = (argument1 > 0) ? surfs.right : surfs.left;
        surface_set_target(_surf);
        draw_clear_alpha(c_black, 0);
        draw_set_alpha(1);
        draw_sprite_tiled_ext(spr_versusflamedark, 0, argument1, time, 1, 1, c_white, 1);
        gpu_set_blendmode(bm_subtract);
        draw_sprite_ext(spr_vsboxhalf, 1, 0, 0, 1, 1, 0, c_white, 1);
        gpu_set_blendmode(bm_normal);
        surface_reset_target();
        draw_set_alpha(intro_scene.portraits_alpha);
        draw_surface(_surf, argument0, 0);
    };
    
    draw_vsboxhalf(p1_x, 1);
    draw_vsboxhalf(p2_x, -1);
}

var p1_sp_height = sprite_get_height(intro_scene.p1.sprite);
var p2_sp_height = sprite_get_height(intro_scene.p2.sprite);
var p1_y = obj_screen.actualHeight - p1_sp_height;
var p2_y = obj_screen.actualHeight - p2_sp_height;
var shake_power = 2;

if (intro_scene.p1.shown)
{
    p1_x += random_range(-shake_power, shake_power);
    p1_y += random_range(-shake_power, shake_power);
}

if (intro_scene.p2.shown)
{
    p2_x += random_range(-shake_power, shake_power);
    p2_y += random_range(-shake_power, shake_power);
}

draw_sprite(intro_scene.p1.shown ? intro_scene.p1.sprite : intro_scene.p1.shadow, 0, p1_x, p1_y);
draw_sprite(intro_scene.p2.shown ? intro_scene.p2.sprite : intro_scene.p2.shadow, 0, p2_x, p2_y);
draw_set_alpha(intro_scene.title_alpha);
draw_sprite(intro_scene.vstitle, 0, 0, 0);
draw_set_alpha(intro_scene.white_alpha);
draw_set_color(c_white);
draw_rectangle(0, 0, obj_screen.actualWidth, obj_screen.actualHeight, false);
intro_scene.white_alpha = lerp(intro_scene.white_alpha, 0, 0.3);

if (state == boss_states.fighting)
{
    draw_set_alpha(phase_transit_time / 10);
    draw_set_color(c_red);
    draw_rectangle(0, 0, obj_screen.actualWidth, obj_screen.actualHeight, false);
    draw_set_alpha(1);
    var shake_m = phase_transit_time / 4;
    var shakex = random_range(-shake_m, shake_m);
    var shakey = random_range(-shake_m, shake_m);
    draw_sprite(spr_punchcustene, phase_transit_time++ / 4, shakex, phase_transit_yoff + shakey);
    phase_transit_yoff = lerp(phase_transit_yoff, 0, 0.2);
    
    with (obj_camera)
        shake_mag = other.phase_transit_time / 2;
    
    if (phase_transit_yoff < 0.2 && phase_transit_time > 48)
    {
        phase_transit_yoff = 0;
        phase_transit_time = 0;
        hp.boss = 6;
        state = boss_states.enterfight;
        phase++;
        
        with (obj_camera)
            shake_mag = 0;
        
        instance_create(x, y, obj_bossdefeatflash);
        instance_create(x, y, obj_boss_phasetxt).text = "PHASE " + string(phase);
    }
}

if (state >= boss_states.enterfight)
{
    var draw_hp_serie = function(argument0, argument1, argument2, argument3, argument4)
    {
        draw_set_alpha(1);
        var start_x = argument1.x;
        var shk = get_shake(argument3);
        
        while (argument2 > 0)
        {
            argument1.x = start_x;
            
            repeat (3)
            {
                if (dead_hat_spawn != undefined && argument2 == dead_hat_spawn.hat && dead_hat_spawn.subject == argument4)
                {
                    dead_hat_spawn = undefined;
                    
                    with (instance_create(argument1.x, argument1.y, obj_sausageman_dead))
                        sprite_index = argument0;
                }
                
                draw_sprite(argument0, time * 0.5, argument1.x + shk.x, argument1.y + shk.y);
                argument1.x += 65;
                argument2--;
                
                if (argument2 <= 0)
                    break;
            }
            
            argument1.y += 69;
        }
    };
    
    draw_hp_serie(spr_bossfight_playerhp, 
    {
        x: 50,
        y: 50
    }, hp.player, hp.player_shakemag, "player");
    draw_hp_serie(boss_hp_sprite, 
    {
        x: obj_screen.actualWidth - 222 - 50,
        y: 50
    }, hp.boss, hp.boss_shakemag, "boss");
}
