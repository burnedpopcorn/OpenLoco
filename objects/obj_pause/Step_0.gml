alphapause = approach(alphapause, pause ? 1 : 0, pause ? 0.04 : 0.1);
alphapausetile = approach(alphapausetile, pause ? 0.25 : 0, 0.05);

if (!pause)
{
    var canPause = 1;
    
    if (instance_exists(obj_textbox) || instance_exists(obj_titlecard) || instance_exists(obj_intro) || instance_exists(obj_exitbubble) || instance_exists(obj_technicaldifficulty) || instance_exists(obj_fadecircle))
        canPause = 0;
    
    if (obj_player1.key_start && canPause && room != rank_room && room != rm_titleselect && room != Scootertransition && room != Realtitlescreen && room != Disclamer && room != timesuproom)
    {
        if (room == rm_antileak)
        {
        }
        else
        {
            instance_create(x, y, obj_pausescreen);
            selected = 0;
            fmod_studio_event_instance_kill(pause_music);
            pause_music = fmod_studio_event_description_create_instance(fmod_studio_system_get_event("event:/music/paused"));
            fmod_studio_event_instance_set_parameter_by_name(pause_music, "state", global.panic);
            fmod_studio_event_instance_start(pause_music);
            
            with (obj_fmod_studio_manager)
            {
                music_set_paused(true);
                fmod_studio_bus_stop_all_events(sfx_bus, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
            }
            
            instance_deactivate_all(true);
            var activeObjects = [obj_fmod_studio_manager, obj_music, obj_pause, obj_mouse, obj_gmlive, obj_screen, obj_parrallax, obj_pausescreen, obj_inputAssigner];
            array_foreach(activeObjects, function(argument0, argument1)
            {
                instance_activate_object(argument0);
            });
            alarm[1] = 400;
            pause = 1;
        }
    }
}

if (!pause)
{
    alarm[1] = -1;
    scaledsi = lerp(scaledsi, 1.5, 0.2);
    scaletext = lerp(scaletext, 0, 0.3);
}

with (obj_player1)
{
    other.paletteselect = paletteselect;
    other.spr_palette = get_charactersprite("spr_palette");
}

if (pause == 1 && cantmove == 0)
{
    scaledsi = lerp(scaledsi, 1, 0.3);
    scaletext = lerp(scaletext, 1, 0.07);
    scr_getinput();
    var m = key_down2 - key_up2;
    
    if (m != 0)
    {
        selected += m;
        selected = clamp(selected, 0, array_length(pause_options_array) - 1);
        fmod_studio_event_oneshot("event:/sfx/player/step");
    }
    
    if (key_jump)
        pause_options_map[? pause_options_array[selected]].func();
}
