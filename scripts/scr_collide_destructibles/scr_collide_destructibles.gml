function scr_collide_destructibles()
{
    with (obj_player1)
    {
        var _lawntaunt = tauntstoredstate == states.lawnmower && state == states.backbreaker;
        
        if (_lawntaunt || state == states.lawnmower || state == states.zombieattack)
        {
            if (place_meeting(x + hsp, y, obj_ratblock))
            {
                with (instance_place(x + hsp, y, obj_ratblock))
                {
                    if (object_index == obj_ratblock)
                        instance_destroy();
                }
            }
        }
        
        if (state == states.tumble)
        {
            if (place_meeting(x + hsp, y, obj_rattumbleblock1x1))
            {
                with (instance_place(x + hsp, y, obj_rattumbleblock1x1))
                    instance_destroy();
            }
        }
        
        if (state == states.zombieattack)
        {
            if (place_meeting(x + hsp, y, obj_plantwallHUB))
            {
                with (instance_place(x + hsp, y, obj_plantwallHUB))
                    instance_destroy();
            }
        }
        
        if (state == states.crouchslide || (state == states.mach3 || (state == states.cape || state == states.crouchslide || (state == states.climbwall && sprite_index == get_charactersprite("spr_climbwalldash")) || (state == states.zombieattack || (state == states.machroll || (state == states.knightpepslopes || (state == states.tumble || state == 9)))))))
        {
            if (place_meeting(x + hsp, y, obj_destructibles))
            {
                with (instance_place(x + hsp, y, obj_destructibles))
                    instance_destroy();
                
                if (state == states.mach2)
                    machpunchAnim = 1;
            }
            
            if (place_meeting(x + hsp, y, obj_hungrypillar))
            {
                with (instance_place(x + hsp, y, obj_hungrypillar))
                {
                    hitLag = 10000;
                    hitX = x;
                    hitY = y;
                    state = 1;
                    fmod_studio_event_oneshot_3d("event:/sfx/player/punch");
                    obj_camera.zoom = 0.5;
                    obj_camera.spdzooming = 0.035;
                }
                
                if (state == states.mach2)
                    machpunchAnim = 1;
                
                tauntstoredstate = state;
                tauntstoredsprite = sprite_index;
                tauntstoredmovespeed = movespeed;
                tauntstoredvsp = vsp;
                state = states.chainsaw;
                hitLag = 10000;
                hitX = x;
                hitY = y;
            }
        }
        
        if (state == states.lawnmower)
        {
            with (obj_destroyablebigskateboard)
            {
                if (place_meeting(x - obj_player1.hsp, y, obj_player1))
                {
                    with (obj_player1)
                        instance_destroy(other);
                }
            }
        }
        
        if (state == states.handstandjump || state == states.faceplant || state == states.kungfu || state == states.lawnmower || state == states.mach2 || state == states.slidekick || (state == states.punch && sprite_index == get_charactersprite("spr_Sjumpcancel")) || (instance_exists(obj_cappy) && place_meeting(x, y, obj_cappy)))
        {
            with (obj_destructibles)
            {
                if (place_meeting(x - obj_player1.hsp, y, obj_player1) || (instance_exists(obj_cappy) && place_meeting(x, y, obj_cappy)))
                {
                    with (obj_player1)
                        instance_destroy(other);
                }
            }
            
            with (obj_hungrypillar)
            {
                if (place_meeting(x - obj_player1.hsp, y, obj_player1))
                {
                    hitLag = 10000;
                    hitX = x;
                    hitY = y;
                    state = 1;
                    fmod_studio_event_oneshot_3d("event:/sfx/player/punch");
                    obj_camera.zoom = 0.5;
                    obj_camera.spdzooming = 0.035;
                    
                    with (obj_player1)
                    {
                        tauntstoredstate = state;
                        tauntstoredsprite = sprite_index;
                        tauntstoredmovespeed = movespeed;
                        tauntstoredvsp = vsp;
                        state = states.chainsaw;
                        hitLag = 10000;
                        hitX = x;
                        hitY = y;
                    }
                }
            }
        }
        
        if (state == states.hurt && thrown == 1)
        {
            if (place_meeting(x - hsp, y, obj_destructibles))
            {
                with (instance_place(x - hsp, y, obj_destructibles))
                    instance_destroy();
            }
        }
        
        if ((state == states.knightpep || (state == states.superslam || state == 9)) && vsp > 0)
        {
            if (place_meeting(x, y + 1, obj_destructibles))
            {
                with (instance_place(x, y + 1, obj_destructibles))
                    instance_destroy();
            }
        }
        
        if (place_meeting(x, y + 1, obj_destructibleplatform))
        {
            with (instance_place(x, y + 1, obj_destructibleplatform))
            {
                falling = 1;
                
                if (falling == 1)
                    image_speed = 0.35;
            }
        }
        
        if (vsp <= 0.5 && (state == states.jump || (state == states.climbwall || ((state == states.punch && (sprite_index == get_charactersprite("spr_breakdanceuppercut") || sprite_index == get_charactersprite("spr_breakdanceuppercutend"))) || (state == 6 || (state == states.Sjump || (state == states.mach2 || (state == states.mach3 || state == states.cape))))))))
        {
            var vy = -1;
            
            if (state == states.punch && (sprite_index == get_charactersprite("spr_breakdanceuppercut") || sprite_index == get_charactersprite("spr_breakdanceuppercutend")))
                vy = vsp;
            
            if (place_meeting(x, y + vy, obj_destructibles))
            {
                with (instance_place(x, y + vy, obj_destructibles))
                {
                    instance_destroy();
                    
                    with (other.id)
                    {
                        if (state != states.Sjump && state != states.climbwall && state != states.punch)
                            vsp = 0;
                    }
                }
            }
        }
        
        if (vsp >= 0 && (state == states.freefall || state == states.freefallland))
        {
            if (place_meeting(x, y + vsp + 2, obj_destructibles))
            {
                with (instance_place(x, y + vsp + 2, obj_destructibles))
                    instance_destroy();
            }
        }
        
        if (state == states.freefall || state == states.freefallland)
        {
            if (place_meeting(x, y + 1, obj_metalblock) && freefallsmash >= 10)
            {
                with (instance_place(x, y + 1, obj_metalblock))
                    instance_destroy();
            }
        }
        
        if (state == states.Sjump && sprite_index == get_charactersprite("spr_presentbox"))
        {
            if (place_meeting(x, y - 1, obj_metalblock))
            {
                with (instance_place(x, y - 1, obj_metalblock))
                    instance_destroy();
            }
        }
    }
    
    with (obj_player2)
    {
        if (state == states.hurt && thrown == 1)
        {
            if (place_meeting(x - hsp, y, obj_destructibles))
            {
                with (instance_place(x - hsp, y, obj_destructibles))
                    instance_destroy();
            }
        }
        
        if (state == states.mach2 || (state == states.mach3 || (state == states.cape || (state == states.machroll || (state == states.knightpepslopes || (state == states.tumble || state == 9))))))
        {
            if (place_meeting(x + hsp, y, obj_destructibles))
            {
                with (instance_place(x + hsp, y, obj_destructibles))
                    instance_destroy();
                
                if (state == states.mach2)
                    machpunchAnim = 1;
            }
        }
        
        if ((state == states.knightpep || (state == states.superslam || state == 9)) && vsp > 0)
        {
            if (place_meeting(x, y + 1, obj_destructibles))
            {
                with (instance_place(x, y + 1, obj_destructibles))
                    instance_destroy();
            }
        }
        
        if (place_meeting(x, y + 1, obj_destructibleplatform))
        {
            with (instance_place(x, y + 1, obj_destructibleplatform))
            {
                falling = 1;
                
                if (falling == 1)
                    image_speed = 0.35;
            }
        }
        
        if (vsp <= 0.5 && (state == states.jump || (state == states.climbwall || (state == 6 || (state == states.Sjump || (state == states.mach2 || (state == states.mach3 || state == states.cape)))))))
        {
            if (place_meeting(x, y - 1, obj_destructibles))
            {
                with (instance_place(x, y - 1, obj_destructibles))
                {
                    instance_destroy();
                    
                    with (other.id)
                    {
                        if (state != states.Sjump && state != states.climbwall)
                            vsp = 0;
                    }
                }
            }
        }
        
        if (vsp >= 0 && (state == states.freefall || state == states.freefallland))
        {
            if (place_meeting(x, y + vsp + 2, obj_destructibles))
            {
                with (instance_place(x, y + vsp + 2, obj_destructibles))
                {
                    with (obj_player2)
                    {
                        if (place_meeting(x, y + vsp + 2, obj_bigdestructibles))
                        {
                            if (shotgunAnim == 0)
                                sprite_index = spr_bodyslamland;
                            else
                                sprite_index = spr_shotgunjump2;
                            
                            state = states.freefallland;
                            image_index = 0;
                        }
                    }
                    
                    instance_destroy();
                }
            }
        }
        
        if (state == states.freefall || state == states.freefallland)
        {
            if (place_meeting(x, y + 1, obj_metalblock) && freefallsmash > 10)
            {
                with (instance_place(x, y + 1, obj_metalblock))
                    instance_destroy();
            }
        }
        
        if (state == states.handstandjump)
        {
            with (obj_destructibles)
            {
                if (place_meeting(x - obj_player2.hsp, y, obj_player2))
                {
                    with (obj_player2)
                    {
                        if (place_meeting(x + hsp, y, obj_bigdestructibles))
                        {
                            if (shotgunAnim == 0)
                            {
                                sprite_index = choose(spr_suplexmash1, spr_suplexmash2, spr_suplexmash3, spr_suplexmash4, spr_punch);
                                image_index = 0;
                                state = states.tackle;
                                movespeed = 3;
                                vsp = -3;
                                instance_destroy(other.id);
                            }
                            else
                            {
                                state = states.shotgun;
                                image_index = 0;
                                sprite_index = spr_shotgunshoot;
                                
                                if (character == "P")
                                {
                                    instance_create(x + (image_xscale * 20), y + 20, obj_shotgunbullet);
                                    
                                    with (instance_create(x + (image_xscale * 20), y + 20, obj_shotgunbullet))
                                        spdh = 4;
                                    
                                    with (instance_create(x + (image_xscale * 20), y + 20, obj_shotgunbullet))
                                        spdh = -4;
                                }
                                
                                instance_destroy(other.id);
                            }
                        }
                        else if (other.object_index != obj_bigdestructibles)
                        {
                            instance_destroy(other.id);
                        }
                    }
                }
            }
        }
    }
}
