function scr_player_crouchjump()
{
    move = key_left + key_right;
    mask_index = spr_crouchmask;
    hsp = move * movespeed;
    movespeed = 4;
    
    if (!key_jump2 && (jumpstop == 0 && jumpAnim == 1))
    {
        vsp /= 2;
        jumpstop = 1;
    }
    
    if (scr_solid(x, y - 1) && (jumpstop == 0 && jumpAnim == 1))
    {
        vsp = grav;
        jumpstop = 1;
    }
    
    if (grounded && key_down)
    {
        state = states.crouch;
        jumpAnim = 1;
        crouchAnim = 1;
        image_index = 0;
        jumpstop = 0;
        fmod_studio_event_oneshot_3d("event:/sfx/player/step");
    }
    
    if (jumpAnim == 1)
    {
        if (shotgunAnim == 0)
            sprite_index = get_charactersprite("spr_crouchjump");
        else
            sprite_index = get_charactersprite("spr_crouchjump");
        
        if (floor(image_index) == (image_number - 1))
            jumpAnim = 0;
    }
    
    if (jumpAnim == 0)
    {
        if (shotgunAnim == 0)
            sprite_index = get_charactersprite("spr_crouchfall");
        else
            sprite_index = get_charactersprite("spr_crouchfall");
    }
    
    if (grounded && (!key_down && !scr_solid(x, y - 16)))
    {
        movespeed = 0;
        state = states.normal;
        jumpAnim = 1;
        landAnim = 1;
        crouchAnim = 1;
        image_index = 0;
        jumpstop = 0;
        mask_index = spr_player_mask;
        fmod_studio_event_oneshot_3d("event:/sfx/player/step");
    }
    
    if (move != 0)
        xscale = move;
    
    image_speed = 0.35;
}
