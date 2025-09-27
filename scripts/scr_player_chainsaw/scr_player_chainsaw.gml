function scr_player_chainsaw()
{
    var _st = tauntstoredstate;
    var _spr = tauntstoredsprite;
    hsp = 0;
    vsp = 0;
    x = hitX + random_range(-4, 4);
    y = hitY + random_range(-4, 4);
    hitLag--;
    
    if (key_jump)
        input_buffer_jump = 0;
    
    if (key_slap2)
        input_buffer_slap = 0;
    
    if (global.laps >= 6 && (tauntstoredsprite == get_charactersprite("spr_suplexmash1") || tauntstoredsprite == get_charactersprite("spr_suplexmash3")) && !(floor(image_index) == (image_number - 1)))
        image_speed = 0.2;
    else
        image_speed = 0;
    
    if (_st == states.lungeattack)
    {
        if (key_slap && input_attack_buffer < 25)
            input_attack_buffer = 40;
        
        if (key_slap2)
            input_attack_buffer = 25;
        
        baddie_pummel();
    }
    
    if (key_slap2)
        input_attack_buffer = 8;
    
    if (hitLag <= 0)
    {
        x = hitX;
        y = hitY;
        movespeed = tauntstoredmovespeed;
        sprite_index = tauntstoredsprite;
        state = tauntstoredstate;
        vsp = tauntstoredvsp;
        
        if (tauntstoredstate == states.parrying && parrysound)
        {
            fmod_studio_event_oneshot_3d("event:/sfx/player/taunt/parry");
            parrysound = false;
        }
        
        if (tauntstoredstate == states.handstandjump || sprite_index == get_charactersprite("spr_piledriverland"))
        {
            if (sprite_index == get_charactersprite("spr_shoulderbashhit"))
            {
                obj_camera.zoomspd = 0.3;
                obj_camera.targetzoom = 1;
            }
            
            jumpAnim = 1;
            state = states.jump;
            sprite_index = get_charactersprite("spr_backflip");
            vsp = -11;
            jumpstop = 0;
            image_index = 0;
        }
        else if (tauntstoredstate == states.handstandjump || tauntstoredstate == states.finishingblow)
            state = states.normal;
    }
}
