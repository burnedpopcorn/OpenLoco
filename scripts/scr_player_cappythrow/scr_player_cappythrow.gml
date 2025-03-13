function scr_player_cappythrow()
{
    static throwframe = 3;
    
    hsp = movespeed * xscale;
    
    if (abs(movespeed) > 5)
        movespeed -= 0.15;
    
    if (image_index >= throwframe && !instance_exists(obj_cappy))
    {
        with (instance_create(x, y, obj_cappy))
        {
            player_id = other.id;
            
            if (other.key_down || other.key_up)
            {
                vertical = true;
                vsp = other.key_up ? -20 : 20;
            }
            else
            {
                vertical = false;
                hsp = (20 + abs(other.hsp)) * other.xscale;
            }
        }
    }
    
    if (animation_end())
    {
        image_index = 0;
        image_speed = 0.35;
        
        if (movespeed >= 12 && key_attack)
        {
            state = states.mach3;
            sprite_index = get_charactersprite("spr_mach4");
        }
        else if (movespeed < 12 && movespeed >= 5 && key_attack)
        {
            state = states.mach2;
            sprite_index = get_charactersprite("spr_mach");
        }
        else
        {
            state = states.normal;
            sprite_index = get_charactersprite("spr_idle");
        }
    }
}
