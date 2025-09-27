if (other.state == states.zombie || other.state == states.zombiejump || other.state == states.zombieattack || other.state == states.lawnmower || other.state == states.geno_normal || other.state == states.genobeam || other.state == states.geno_jump || other.state == states.geno_shoot)
{
    sprite_index = spr_sunflowerhappy;
    alarm[0] = 120;
    
    if (!is_hub())
    {
        if (ds_list_find_index(global.saveroom, id) == -1)
        {
            global.collect += 500;
            global.combotime = 60;
            
            repeat (50)
            {
                var spr_pair = choose([spr_sausagecollect, noone], [spr_shroomcollect, spr_coincolorpalette], [spr_cheesecollect, spr_fishcolorpalette], [spr_tomatocollect, spr_sposcolorpalette], [spr_pineapplecollect, spr_starcolorpalette]);
                create_collect_color(x + random_range(-64, 64), y + random_range(-64, 64), spr_pair[0], spr_pair[1], random_range(0, 3), 10);
            }
        }
        
        ds_list_add(global.saveroom, id);
    }
    
    with (other)
    {
        instance_create(x, y, obj_genericpoofeffect);
        
        if (!grounded && !key_attack)
        {
            sprite_index = get_charactersprite("spr_fall");
            image_index = 0;
            state = states.jump;
        }
        else if (grounded && !key_attack)
        {
            sprite_index = get_charactersprite("spr_idle");
            sprite_index = 0;
            state = states.normal;
        }
        else if (key_attack)
        {
            if (abs(movespeed) >= 12 && !genomode)
            {
                sprite_index = get_charactersprite("spr_mach4");
                image_index = 0;
                state = states.mach3;
            }
            else if (abs(movespeed) < 12 || genomode)
            {
                sprite_index = get_charactersprite("spr_mach");
                image_index = 0;
                state = states.mach2;
            }
        }
    }
}
