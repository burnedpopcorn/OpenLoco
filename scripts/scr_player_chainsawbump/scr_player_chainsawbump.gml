function scr_player_chainsawbump()
{
    movespeed = 0;
    mach2 = 0;
    start_running = 1;
    alarm[4] = 14;
    
    if (grounded && vsp > 0)
        hsp = 0;
    
    if (floor(image_index) == 6)
        state = states.normal;
    
    sprite_index = get_charactersprite("spr_chainsawbump");
    image_speed = 0.35;
}
