function scr_player_Sjumpprep()
{
    combo = 0;
    mach2 = 0;
    move = key_left + key_right;
    
    if (sprite_index == get_charactersprite("spr_superjumpprep"))
    {
        if (!place_meeting(x, y + 1, obj_railh) && !place_meeting(x, y + 1, obj_railh2))
            hsp = xscale * movespeed;
        else if (place_meeting(x, y + 1, obj_railh))
            hsp = (xscale * movespeed) - 5;
        else if (place_meeting(x, y + 1, obj_railh2))
            hsp = (xscale * movespeed) + 5;
        
        if (movespeed >= 0)
            movespeed -= 0.8;
    }
    
    if (sprite_index == get_charactersprite("spr_superjumppreplight") || (sprite_index == get_charactersprite("spr_superjumpright") || sprite_index == get_charactersprite("spr_superjumpleft")))
    {
        if (!place_meeting(x, y + 1, obj_railh) && !place_meeting(x, y + 1, obj_railh2))
            hsp = move * 2;
        else if (place_meeting(x, y + 1, obj_railh))
            hsp = (move * 2) - 5;
        else if (place_meeting(x, y + 1, obj_railh2))
            hsp = (move * 2) + 5;
    }
    
    if (sprite_index != get_charactersprite("spr_superjumpprep"))
    {
        if (sign(hsp) == 0)
            sprite_index = get_charactersprite("spr_superjumppreplight");
        
        if (sign(hsp) == 1)
        {
            if (xscale == 1)
                sprite_index = get_charactersprite("spr_superjumpright");
            
            if (xscale == -1)
                sprite_index = get_charactersprite("spr_superjumpleft");
        }
        
        if (sign(hsp) == -1)
        {
            if (xscale == 1)
                sprite_index = get_charactersprite("spr_superjumpleft");
            
            if (xscale == -1)
                sprite_index = get_charactersprite("spr_superjumpright");
        }
    }
    
    start_running = 1;
    alarm[4] = 14;
    jumpAnim = 1;
    dashAnim = 1;
    landAnim = 0;
    machslideAnim = 1;
    moveAnim = 1;
    stopAnim = 1;
    crouchslideAnim = 1;
    crouchAnim = 1;
    
    if (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_superjumpprep"))
        sprite_index = get_charactersprite("spr_superjumppreplight");
    
    if ((!key_up && ((character == "S" || (sprite_index == get_charactersprite("spr_superjumppreplight") || (sprite_index == get_charactersprite("spr_superjumpleft") || sprite_index == get_charactersprite("spr_superjumpright")))) && (!scr_solid(x, y - 16) && !scr_solid(x, y - 32)))) && grounded)
    {
        instance_create(x, y, obj_explosioneffect);
        sprite_index = get_charactersprite("spr_superjump");
        state = states.Sjump;
        vsp = -17;
    }
    
    image_speed = 0.35;
}
