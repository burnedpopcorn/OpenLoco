function scr_player_faceplant()
{
    hsp = xscale * movespeed;
    move = key_right + key_left;
    image_speed = 0.5;
    
    if (key_slap2)
        input_buffer_slap = 0;
    
    if (scr_solid(x + xscale, y) && !place_meeting(x + sign(hsp), y, obj_destructibles))
    {
        var _hitwall = ledge_bump((vsp >= 0) ? 32 : 22);
        
        if (_hitwall)
        {
            sprite_index = get_charactersprite("spr_mach3hitwall");
            fmod_studio_event_oneshot_3d("event:/sfx/player/bodyslam_land");
            fmod_studio_event_oneshot_3d("event:/sfx/player/misc/bump");
            
            with (obj_camera)
            {
                shake_mag = 20;
                shake_mag_acc = 40 / room_speed;
            }
            
            hsp = 0;
            image_speed = 0.35;
            
            with (obj_baddie)
            {
                if (point_in_rectangle(x, y, __view_get(0, 0), __view_get(1, 0), __view_get(0, 0) + __view_get(2, 0), __view_get(1, 0) + __view_get(3, 0)))
                {
                    stun = 1;
                    alarm[0] = 200;
                    ministun = 0;
                    vsp = -5;
                    hsp = 0;
                }
            }
            
            flash = 0;
            state = states.bump;
            hsp = 4.5 * -xscale;
            vsp = -6;
            mach2 = 0;
            image_index = 0;
            instance_create(x + 10, y + 10, obj_bumpeffect);
        }
    }
    
    if (floor(image_index) == (image_number - 1) && !genomode)
    {
        image_speed = 0.35;
        state = states.mach3;
        sprite_index = get_charactersprite("spr_mach4");
        grav = 0.5;
    }
    else if (floor(image_index) == (image_number - 1) && genomode)
    {
        image_speed = 0.35;
        state = states.mach2;
        sprite_index = get_charactersprite("spr_mach");
        grav = 0.5;
    }
}
