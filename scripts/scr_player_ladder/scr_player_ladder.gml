function scr_player_ladder()
{
    jumpAnim = 1;
    dashAnim = 1;
    landAnim = 0;
    moveAnim = 1;
    stopAnim = 1;
    crouchslideAnim = 1;
    crouchAnim = 0;
    machhitAnim = 0;
    turning = 0;
    jumpstop = 0;
    movespeed = 0;
    hsp = 0;
    
    if (key_up)
    {
        sprite_index = get_charactersprite("spr_laddermove");
        vsp = -6;
        image_speed = 0.35;
        
        if (steppybuffer > 0)
            steppybuffer--;
        else
        {
            create_particle(x, y + 43, 1, 0);
            steppybuffer = 12;
            fmod_studio_event_oneshot_3d("event:/sfx/player/step");
        }
    }
    else if (key_down)
    {
        sprite_index = get_charactersprite("spr_ladderdown");
        vsp = 10;
        image_speed = -0.35;
    }
    else
    {
        sprite_index = get_charactersprite("spr_ladder");
        vsp = 0;
    }
    
    mach2 = 0;
    jumpAnim = 1;
    dashAnim = 1;
    landAnim = 0;
    moveAnim = 1;
    stopAnim = 1;
    crouchslideAnim = 1;
    crouchAnim = 1;
    machhitAnim = 0;
    
    if (!place_meeting(x, y, obj_ladder))
    {
        landAnim = 0;
        jumpAnim = 0;
        state = states.normal;
        image_index = 0;
        vsp = 0;
    }
    
    if (key_jump && !key_down)
    {
        sprite_index = get_charactersprite("spr_jump");
        ladderbuffer = 20;
        jumpAnim = 1;
        state = states.jump;
        vsp = -9;
        image_index = 0;
    }
    else if (key_jump && key_down)
    {
        sprite_index = get_charactersprite("spr_fall");
        ladderbuffer = 20;
        vsp = 10;
        state = states.jump;
        image_index = 0;
    }
    
    if (key_down && (grounded && !place_meeting(x, y, obj_platform)))
    {
        state = states.normal;
        image_index = 0;
    }
    
    x = lerp(x, ladderx, 0.15);
}
