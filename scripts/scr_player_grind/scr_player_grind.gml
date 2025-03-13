function scr_player_grind()
{
    vsp = 0;
    machhitAnim = 0;
    crouchslideAnim = 1;
    hsp = xscale * movespeed;
    
    if (!grinding)
        state = states.mach2;
    
    if (key_jump)
    {
        vsp = -6;
        state = states.mach2;
        grinding = 0;
    }
    
    sprite_index = get_charactersprite("spr_grind");
    image_speed = 0.35;
    
    if (!instance_exists(obj_grindeffect))
        instance_create(x, y, obj_grindeffect);
}
