switch (state)
{
    case 0:
        x += lengthdir_x(spd, xdir);
        y += lengthdir_y(spd, ydir);
        break;
    
    case 1:
        y = lerp(y, obj_player1.y, 0.1);
        
        if (y >= (obj_player1.y - 3))
        {
            fmod_studio_event_oneshot_3d("event:/sfx/misc/pop");
            obj_camera.lock = true;
            
            with (obj_player1)
            {
                sprite_index = get_charactersprite("spr_slipbanan1");
                vsp = -16;
                visible = true;
                image_index = 0;
                state = states.slipbanana;
            }
            
            state = 2;
            sprite_index = spr_bubble_pop;
            image_index = 0;
        }
        
        break;
}

if (fmod_studio_event_instance_get_pitch(global.music.event_instance) == 0 && !pitchedDown)
{
    alarm[1] = 30;
    pitchedDown = 1;
}

if (!fmod_studio_event_instance_is_playing(sfx_inst) && playingmusic && !playedmusic)
{
    alarm[2] = 30;
    playedmusic = true;
}

with (obj_player1)
{
    if (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_bubblestart"))
        sprite_index = get_charactersprite("spr_bubble");
}

if (floor(image_index) == (image_number - 1))
{
    if (sprite_index == spr_bubble_pop)
        instance_destroy();
    
    if (sprite_index == spr_bubble_intro)
        sprite_index = spr_bubble_idle;
}
