function scr_player_tackle()
{
    combo = 0;
    mach2 = 0;
    hsp = -xscale * movespeed;
    start_running = 1;
    jumpAnim = 1;
    dashAnim = 1;
    landAnim = 0;
    moveAnim = 1;
    stopAnim = 1;
    crouchslideAnim = 1;
    crouchAnim = 1;
    
    if (sprite_index != get_charactersprite("spr_kungfu1") && sprite_index != get_charactersprite("spr_kungfu2") && sprite_index != get_charactersprite("spr_kungfu3"))
    {
        if (grounded && vsp > 0.5)
            state = states.normal;
    }
    else
    {
        movespeed = Approach(movespeed, 0, 0.1);
        
        if (floor(image_index) == (image_number - 1) && grounded && vsp > 0)
            state = states.normal;
    }
    
    image_speed = (floor(image_index) != (image_number - 1)) ? 0.35 : 0;
}
