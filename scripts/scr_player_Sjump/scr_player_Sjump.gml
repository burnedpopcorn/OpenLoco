function scr_player_Sjump()
{
    hsp = 0;
    mach2 = 0;
    jumpAnim = 1;
    dashAnim = 1;
    landAnim = 0;
    moveAnim = 1;
    stopAnim = 1;
    crouchslideAnim = 1;
    crouchAnim = 0;
    machhitAnim = 0;
    move = key_left + key_right;
    
    if (sprite_index == get_charactersprite("spr_superjump") || sprite_index == get_charactersprite("spr_presentbox"))
        vsp = sjumpvsp;
    
    sjumpvsp -= 0.1;
    
    if (sprite_index == get_charactersprite("spr_supersidejump"))
    {
        if (a < 25)
            a++;
        
        hsp = xscale * a;
        vsp = 0;
    }
    
    if ((sprite_index == get_charactersprite("spr_superjump") || sprite_index == get_charactersprite("spr_presentbox")) && !instance_exists(crazyruneffectid))
    {
        with (instance_create(x, y - 4, obj_crazyrunothereffect))
        {
            playerid = other.object_index;
            image_angle = 90;
            other.crazyruneffectid = id;
        }
    }
    
    if ((place_meeting_solid(x, y - 1) || place_meeting_platform(x, y - 1)) && !place_meeting(x, y - 1, obj_destructibles) && !place_meeting_slope(x - sign(hsp), y) && !place_meeting_slope(x + sign(hsp), y))
    {
        var _cancollide = true;
        
        if (place_meeting_platform(x, y - 1))
        {
            with (instance_place(x, y - 1, obj_platform))
            {
                if (image_yscale != -1)
                {
                    with (other)
                        _cancollide = false;
                }
            }
        }
        
        if (_cancollide == true)
        {
            a = 0;
            
            if (sprite_index == get_charactersprite("spr_supersidejump"))
                sprite_index = get_charactersprite("spr_supersidejumpland");
            
            if (sprite_index == get_charactersprite("spr_superjump"))
                sprite_index = get_charactersprite("spr_superjumpland");
            
            if (sprite_index == get_charactersprite("spr_presentbox"))
                sprite_index = get_charactersprite("spr_superjumpland");
            
            with (obj_camera)
            {
                shake_mag = 10;
                shake_mag_acc = 30 / room_speed;
            }
            
            with (obj_baddie)
            {
                if (point_in_rectangle(x, y, __view_get(0, 0), __view_get(1, 0), __view_get(0, 0) + __view_get(2, 0), __view_get(1, 0) + __view_get(3, 0)))
                {
                    image_index = 0;
                    
                    if (grounded)
                        vsp = -7;
                }
            }
            
            fmod_studio_event_oneshot_3d("event:/sfx/player/bodyslam_land");
            image_index = 0;
            state = states.Sjumpland;
            machhitAnim = 0;
        }
    }
    else if (((key_slap2 || input_buffer_slap > 0) || key_attack2) && sprite_index != get_charactersprite("spr_presentbox") && sprite_index != get_charactersprite("spr_Sjumpcancelstart"))
    {
        input_buffer_slap = 0;
        
        if (move != 0)
            xscale = move;
        
        image_index = 0;
        fmod_studio_event_oneshot_3d("event:/sfx/player/sjumpcancel");
        sprite_index = get_charactersprite("spr_Sjumpcancelstart");
    }
    
    if (sprite_index == get_charactersprite("spr_Sjumpcancelstart"))
    {
        vsp = 0;
        
        if (move != 0)
            xscale = move;
        
        if (floor(image_index) == (image_number - 1))
        {
            with (instance_create(x, y, obj_crazyrunothereffect))
                image_xscale = other.xscale;
            
            fmod_studio_event_instance_start(grabsnd);
            state = states.mach3;
            vsp = -5;
            movespeed = 12;
            image_index = 0;
            sprite_index = get_charactersprite("spr_Sjumpcancel");
            jumpstop = 1;
            flash = 1;
            
            with (instance_create(x, y, obj_crazyruneffect))
                image_xscale = other.xscale;
        }
    }
    
    image_speed = 0.5;
    scr_collision();
}
