function scr_player_lungeattack()
{
    if (sprite_index != get_charactersprite("spr_suplexmash1"))
        vsp = 0;
    
    move = key_left + key_right;
    hsp = xscale * movespeed;
    
    if (floor(image_index) == (image_number - 1))
        image_speed = 0;
    else
        image_speed = 0.35;
    
    if (sprite_index == get_charactersprite("spr_suplexmash1"))
    {
        movespeed = Approach(movespeed, move * 8 * xscale, 0.5);
        
        if (grounded)
            state = states.mach2;
    }
    else if (input_attack_buffer <= 0)
        state = states.mach2;
    
    if (key_slap && input_attack_buffer < 25)
        input_attack_buffer = 40;
    
    if (key_slap2)
        input_attack_buffer = 25;
    
    baddie_pummel();
    
    if (input_attack_buffer <= 0 && sprite_index != get_charactersprite("spr_suplexmash1"))
        state = states.normal;
}
