function scr_player_superslam()
{
    if (sprite_index == get_charactersprite("spr_piledriver"))
    {
        move = key_left + key_right;
        hsp = move * movespeed;
    }
    else
    {
        move = 0;
        hsp = 0;
    }
    
    if (sprite_index == get_charactersprite("spr_piledriver") && vsp >= 0)
        vsp += 0.5;
    
    if (key_special2 && vsp < 0) { }
    
    if (grounded && !place_meeting(x, y + 1, obj_destructibles) && sprite_index == get_charactersprite("spr_piledriver") && vsp > 0)
    {
        fmod_studio_event_oneshot_3d("event:/sfx/player/bodyslam_land");
        sprite_index = get_charactersprite("spr_piledriverland");
        jumpAnim = 1;
        image_index = 0;
        
        with (obj_camera)
        {
            shake_mag = 20;
            shake_mag_acc = 40 / room_speed;
        }
        
        hsp = 0;
        bounce = 0;
        
        with (instance_create(x, y + 35, obj_bangeffect))
            xscale = obj_player.xscale;
        
        freefallstart = 0;
    }
    
    jumpAnim = 1;
    dashAnim = 1;
    landAnim = 0;
    machslideAnim = 1;
    moveAnim = 1;
    stopAnim = 1;
    crouchslideAnim = 1;
    crouchAnim = 1;
    
    if (sprite_index == get_charactersprite("spr_piledriverland") && floor(image_index) == (image_number - 1))
    {
        vsp = -6;
        state = states.jump;
    }
    
    if (move != 0)
    {
        if (movespeed < 6)
            movespeed += 0.5;
        else if (floor(movespeed) == 6)
            movespeed = 6;
    }
    else
        movespeed = 0;
    
    if (movespeed > 6)
        movespeed -= 0.1;
    
    if (character == "N" && move != 0)
        xscale = move;
    
    if (vsp < 0)
        image_speed = 0.35;
    else
        image_speed = 0.5;
}
