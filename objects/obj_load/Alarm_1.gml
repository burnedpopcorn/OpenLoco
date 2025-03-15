switch (state)
{
    case 0:
        with (obj_fmod_studio_manager)
        {
            var _banks = [master_bank, master_strings_bank, music_bank, sfx_bank];
            
            for (var i = 0; i < array_length(_banks); i++)
            {
                if (fmod_studio_bank_get_loading_state(_banks[i]) == FMOD_STUDIO_LOADING_STATE.LOADING || fmod_studio_bank_get_loading_state(_banks[i]) == FMOD_STUDIO_LOADING_STATE.UNLOADED)
                {
                    other.alarm[1] = 3;
                    exit;
                }
                
                fmod_studio_bank_load_sample_data(_banks[i]);
                
                if (fmod_studio_bank_get_sample_loading_state(_banks[i]) == FMOD_STUDIO_LOADING_STATE.LOADING || fmod_studio_bank_get_sample_loading_state(_banks[i]) == FMOD_STUDIO_LOADING_STATE.UNLOADED)
                {
                    other.alarm[1] = 3;
                    exit;
                }
            }
        }
        
        with (obj_player1)
            init_playersounds();
        
        state++;
        alarm[1] = 3;
        trace("FMOD Loaded");
        break;
    
    case 1:
        for (var i = 0; i < array_length(data.texgroups); i++)
        {
            if (texturegroup_get_status(data.texgroups[i]) == 1 || texturegroup_get_status(data.texgroups[i]) == 0)
            {
                if (texturegroup_get_status(data.texgroups[i]) == 0)
                    texturegroup_load(data.texgroups[i]);
                
                alarm[1] = 3;
                exit;
            }
        }
        
        trace("Textures Loaded");
        state++;
        alarm[1] = 3;
        break;
    
    case 2:
        var _shaders = [shd_alphafix, shd_pal_swapper, shd_lap3bg, shd_panicfx, shd_panicbg, sh_colmesh_collider, sh_colmesh_debug, sh_colmesh_shadow, sh_colmesh_skybox];
        
        for (var i = 0; i < array_length(_shaders); i++)
        {
            if (!shader_is_compiled(_shaders[i]))
            {
                shader_set(_shaders[i]);
                draw_sprite(Door, 0, obj_screen.actualWidth / 2, obj_screen.actualHeight / 2);
                shader_reset();
                alarm[1] = 3;
                exit;
            }
        }
        
        state++;
        alarm[1] = 3;
        trace("Shaders Loaded");
        break;
    
    case 3:
        trace("Loading finished");
        room_goto(Realtitlescreen);
        break;
}
