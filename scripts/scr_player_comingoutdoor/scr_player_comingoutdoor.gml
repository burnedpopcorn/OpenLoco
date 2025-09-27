function scr_player_comingoutdoor()
{
    mach2 = 0;
    jumpAnim = 1;
    dashAnim = 1;
    landAnim = 0;
    moveAnim = 1;
    stopAnim = 1;
    crouchslideAnim = 1;
    crouchAnim = 1;
    machhitAnim = 0;
    hsp = 0;
    
    if (c < 255)
        c += 5;
    
    image_blend = make_colour_hsv(0, 0, c);
    
    if (floor(image_index) == (image_number - 1))
    {
        movespeed = 0;
        state = states.normal;
        c = 0;
        image_alpha = 1;
        image_blend = make_colour_hsv(0, 0, 255);
        
        if (instance_exists(obj_fadecircle))
        {
            if (!obj_fadecircle.playerendedit)
            {
                with (obj_camera)
                    alphaend = 1;
                
                with (obj_tv)
                    alphaend = 1;
                
                obj_fadecircle.playerendedit = 1;
            }
        }
    }
    
    if (sprite_index != get_charactersprite("spr_timesup"))
    {
        if (steppybuffer > 0)
            steppybuffer--;
        else
        {
            steppybuffer = 16;
            fmod_studio_event_oneshot_3d("event:/sfx/player/step");
        }
    }
    
    image_speed = 0.35;
}
