if (active)
{
    with (obj_player)
    {
        state = states.portal;
        hsp = 0;
        vsp = 0;
        visible = false;
    }
}

if (animation_end())
{
    if (obj_player.state == states.portal)
    {
        with (obj_player1)
        {
            hsp = storedhsp * xscale;
            movespeed = storedhsp * xscale;
            visible = true;
            image_index = 0;
            
            if ((abs(storedhsp) >= 8 && abs(storedhsp) < 12) || (genomode && key_attack))
            {
                state = states.mach2;
                sprite_index = get_charactersprite("spr_secondjump1");
            }
            else if (abs(storedhsp) >= 12 && key_attack && !genomode)
            {
                state = states.mach3;
                sprite_index = get_charactersprite("spr_mach4");
                
                if (abs(storedhsp) >= 16)
                    sprite_index = get_charactersprite("spr_crazyrun");
            }
            else
            {
                state = states.jump;
                sprite_index = get_charactersprite("spr_fall");
                hsp = 0;
                movespeed = 0;
            }
        }
    }
    
    active = 0;
    instance_destroy();
}
