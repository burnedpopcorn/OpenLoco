time++;

switch (state)
{
    case boss_states.intro1:
        intro_scene.p1.xoff = lerp(intro_scene.p1.xoff, 0, 0.03);
        intro_scene.p2.xoff = lerp(intro_scene.p2.xoff, 0, 0.03);
        intro_scene.back_alpha = lerp(intro_scene.back_alpha, 1, 0.03);
        intro_scene.portraits_alpha = lerp(intro_scene.portraits_alpha, 1, 0.03);
        
        if ((1 - intro_scene.portraits_alpha) < 0.04)
        {
            state = boss_states.intro2;
            intro_scene.white_alpha = 1;
            intro_scene.back_shown = true;
        }
        
        break;
    
    case boss_states.intro2:
        intro_scene.p1.shown = true;
        intro_scene.p2.shown = true;
        intro_scene.p1.xoff += 0.3;
        intro_scene.p2.xoff -= 0.3;
        intro_scene.portrait_back = true;
        intro_scene.title_alpha = lerp(intro_scene.title_alpha, 1, 0.1);
        
        if (intro_scene.reveal_time-- <= 0)
            state = boss_states.intro3;
        
        break;
    
    case boss_states.intro3:
        intro_scene.p1.xoff = lerp(intro_scene.p1.xoff, 500, 0.04);
        intro_scene.p2.xoff = lerp(intro_scene.p2.xoff, -500, 0.04);
        intro_scene.title_alpha = lerp(intro_scene.title_alpha, 0, 0.04);
        intro_scene.back_alpha = lerp(intro_scene.back_alpha, 0, 0.04);
        intro_scene.portraits_alpha = lerp(intro_scene.portraits_alpha, 0, 0.04);
        intro_scene.portrait_back = false;
        
        if ((1 - intro_scene.back_alpha) > 0.97)
        {
            intro_scene.back_alpha = 0;
            intro_scene.portraits_alpha = 0;
            intro_scene.title_alpha = 0;
            state = boss_states.ingameintro;
            intro_scene.reveal_time = 90;
        }
        
        break;
    
    case boss_states.ingameintro:
        spotlight_radius = lerp(spotlight_radius, 100, 0.2);
        
        if (spotlight_radius >= 98 && intro_scene.reveal_time-- <= 0)
        {
            spotlight_radius = 100;
            
            with (obj_player)
            {
                sprite_index = get_charactersprite("spr_bossintro");
                state = states.bossintro;
            }
            
            state = boss_states.enterfight;
        }
        
        break;
    
    case boss_states.enterfight:
        spotlight_radius += spotlight_radius_spd;
        spotlight_radius_spd += 3;
        
        if (hp.boss <= 0)
        {
            if (phase < 2)
                state = boss_states.fighting;//do nothing
            else
            {
                with (obj_player)
                {
                    state = states.actor;
                    sprite_index = spr_move;
                    image_speed = 0.35;
                }
                
                state = boss_states.ending;
            }
        }
        
        if (instance_exists(par_boss))
        {
            if (par_boss.state == states.hit && !registered_hit)
            {
                hp.boss--;
                registered_hit = true;
                trace("boss is hit");
                hp.boss_shakemag = 6;
                dead_hat_spawn = 
                {
                    subject: "boss",
                    hat: hp.boss + 1
                };
            }
            
            if (par_boss.state != states.hit && registered_hit)
                registered_hit = false;
        }
        
        break;
    
    case boss_states.ending:
        with (obj_player)
        {
            movespeed = 6;
            hsp = xscale * movespeed;
            
            if ((x % 30) == 0)
                fmod_studio_event_oneshot("event:/sfx/player/step");
            
            xscale = sign((obj_screen.actualWidth / 2) - x);
            
            if (abs((obj_screen.actualWidth / 2) - x) < sprite_width)
            {
                with (obj_bosscontroller)
                {
                    state = boss_states.endingcutscene;
                    instance_destroy(par_boss);
                    fmod_studio_event_oneshot_3d("event:/sfx/level_structure/collects/plushie");
                    
                    with (obj_player)
                    {
                        state = states.victory;
                        sprite_index = get_charactersprite("spr_victory");
                    }
                }
            }
        }
        
        break;
    
    case boss_states.endingcutscene:
        if (obj_player.image_speed == 0)
        {
            if (!instance_exists(obj_boss_playerhat_follow) && hp.player > 0)
            {
                instance_create(-50, -50, obj_boss_playerhat_follow);
                hp.player--;
            }
            
            if (hp.player <= 0)
                state = boss_states.ended;
        }
        
        break;
}

hp.boss_shakemag = Approach(hp.boss_shakemag, 0, 0.3);
hp.player_shakemag = Approach(hp.player_shakemag, 0, 0.3);
