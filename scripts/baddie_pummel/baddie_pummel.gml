function baddie_pummel()
{
    if (input_attack_buffer == 25 && sprite_index != get_charactersprite("spr_suplexmash1"))
    {
        input_attack_buffer = 15;
        
        if (sprite_index == get_charactersprite("spr_suplexmash5"))
            sprite_index = get_charactersprite("spr_suplexmash1");
        
        if (sprite_index == get_charactersprite("spr_suplexmash3"))
            sprite_index = get_charactersprite("spr_suplexmash5");
        
        var set_throw = sprite_index == get_charactersprite("spr_suplexmash1");
        fmod_studio_event_oneshot_3d("event:/sfx/player/misc/kill");
        image_index = 0;
        trace("Lungeattack2");
        
        with (obj_baddie)
        {
            var bID = id;
            var p = other.id;
            
            if (lunged)
            {
                lungeHP--;
                flash = 1;
                
                with (instance_create(bID.x, bID.y, obj_parryeffect))
                    sprite_index = spr_kungfueffect;
                
                if (bID.elite)
                    bID.elitehit--;
                
                state = states.superslam;
                image_xscale = -obj_player1.xscale;
                
                if (set_throw)
                {
                    thrown = 1;
                    linethrown = 1;
                    lunge_throw = 1;
                    lunged = 0;
                    hsp = image_xscale * -25;
                    hithsp = image_xscale * -25;
                    vsp = 0;
                    state = states.capefall;
                    obj_player1.vsp = -6;
                }
                
                if (!bID.important)
                    global.combotime += 10;
                
                with (obj_player1)
                {
                    lunge_hits++;
                    var lag = 5;
                    
                    if (set_throw)
                        lag = 15;
                    
                    var redo_lunge = 0;
                    
                    if (bID.state == states.lungeattack)
                        redo_lunge = 1;
                    
                    if (redo_lunge)
                        bID.state = states.superslam;
                }
                
                if (set_throw)
                    hithsp = image_xscale * -25;
                
                hitX = obj_player1.x + (obj_player1.xscale * 30);
                hitY = obj_player1.y - 25;
            }
        }
    }
}
