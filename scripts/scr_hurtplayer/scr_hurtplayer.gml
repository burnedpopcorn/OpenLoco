function scr_hurtplayer(_player)
{
    with (_player)
    {
        if ((state == states.knightpep || (state == states.knightpepattack || state == states.knightpepslopes)) && cutscene == 0)
            continue;
        
        if (state == states.bombpep && hurted == 0)
            continue;
        
        if (state == states.portal)
            continue;
        
        if (state == states.backbreaker && sprite_index != get_charactersprite("spr_taunt"))
            continue;
        
        if (state == states.parrying)
            continue;
        
        if (state == states.chainsaw)
            continue;
        
        if (state == states.unknown15)
            continue;
        
        if (state == states.debugstate)
            continue;
        
        if (state == states.door)
            continue;
        
        if (state == states.slipbanana)
            continue;
        
        if (state == states.lungeattack)
            continue;
        
        if (state == states.comingoutdoor)
            continue;
        
        if (state == states.tumble)
            continue;
        
        if (state == states.actor)
            continue;
        
        if (state == states.zombie || state == states.zombiejump || state == states.zombieattack)
            continue;
        
        if (state != states.hurt && (hurted == 0 && cutscene == 0 && timeuntilhpback == 0))
        {
            global.combotime -= 25;
            fmod_studio_event_oneshot_3d("event:/sfx/player/damage");
            
            if (irandom(100) <= 50)
                fmod_studio_event_instance_start(obj_player1.hurtvoice);
            
            alarm[8] = 100;
            alarm[7] = 50;
            hurted = 1;
            
            if (xscale == other.image_xscale)
                sprite_index = get_charactersprite("spr_jumphurt");
            else
                sprite_index = get_charactersprite("spr_hurt");
            
            movespeed = 8;
            vsp = -14;
            timeuntilhpback = 300;
            
            if (instance_exists(obj_player2) && global.coop == 1)
            {
                if (object_index == obj_player2)
                {
                    if (obj_player1.spotlight == 0)
                    {
                        obj_camera.shoving = 1;
                        obj_camera.image_index = 0;
                        obj_player1.spotlight = 1;
                        scr_changetoppings();
                        x = obj_player1.x;
                        y = obj_player1.y;
                        obj_player1.depth = -7;
                        obj_player2.depth = -6;
                    }
                }
                
                if (object_index == obj_player1)
                {
                    if (obj_player1.spotlight == 1)
                    {
                        obj_camera.shoving = 1;
                        obj_camera.image_index = 0;
                        obj_player1.spotlight = 0;
                        scr_changetoppings();
                        x = obj_player2.x;
                        y = obj_player2.y;
                        obj_player1.depth = -6;
                        obj_player2.depth = -7;
                    }
                }
            }
            
            instance_create(x, y, obj_spikehurteffect);
            state = states.hurt;
            image_index = 0;
            flash = 1;
            
            if (shotgunAnim == 0)
            {
                global.hurtcounter += 1;
                
                if (global.collect > 100)
                    global.collect -= 100;
                else
                    global.collect = 0;
                
                if (global.collect != 0)
                {
                    repeat (10)
                        instance_create(x, y, obj_pizzaloss);
                }
            }
            else
            {
                with (instance_create(x, y, obj_sausageman_dead))
                    sprite_index = spr_shotgunback;
                
                if (backupweapon == 1)
                    backupweapon = 0;
                else
                    shotgunAnim = 0;
            }
        }
    }
}
