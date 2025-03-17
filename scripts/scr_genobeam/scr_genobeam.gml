function scr_genobeam()
{
    breakdance_pressed = 0;
    geno_beamcharges = 0;
    geno_beamcharge_time = 60;
    geno_beamstrength = 0;
    state = states.genobeam;
    
    with (instance_create(0, 0, obj_transformationtext))
    {
        effect = texteffect.crazyshake;
        message = "[G] Hold to charge!";
    }
    
    image_index = 0;
    sprite_index = get_charactersprite("spr_pistol");
    image_speed = 0;
}
