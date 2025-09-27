if ((state == states.jump || (state == states.Sjump || (state == states.mach2 || obj_player.state == states.mach3))) && other.drop == 0)
{
    mach2 = 0;
    state = states.hang;
    image_xscale = 1;
    other.hooked = 1;
    other.vspeed = -5;
    
    if (other.hspeed == 10)
        sprite_index = get_charactersprite("spr_hangslide");
    
    if (other.hspeed == 0)
        sprite_index = get_charactersprite("spr_hang");
}
