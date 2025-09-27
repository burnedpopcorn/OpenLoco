function scr_player_freefallland()
{
    mach2 = 0;
    jumpAnim = 1;
    dashAnim = 1;
    landAnim = 0;
    moveAnim = 1;
    stopAnim = 1;
    crouchslideAnim = 1;
    crouchAnim = 0;
    machhitAnim = 0;
    movespeed = 0;
    facehurt = 1;
    start_running = 1;
    alarm[4] = 14;
    vsp = 0;
    hsp = 0;
    
    if (floor(image_index) == (image_number - 1))
    {
        facehurt = 1;
        image_index = 0;
        
        if (character == "T")
        {
            state = states.jump;
            
            if (key_jump2)
            {
                vsp = -14;
                sprite_index = get_charactersprite("spr_groundpoundjump");
                create_particle(x, y, 16, 0);
            }
            else if (!key_down)
            {
                sprite_index = get_charactersprite("spr_machfreefall");
                vsp = -8;
            }
        }
        else
            state = states.normal;
        
        jumpstop = 1;
    }
    
    image_speed = 0.35;
}
