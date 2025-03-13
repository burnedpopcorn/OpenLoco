function scr_player_genobeam()
{
    if (sprite_index == get_charactersprite("spr_pistol") && !instance_exists(obj_genobeam))
    {
        geno_beamcharge_time--;
        move = key_left + key_right;
        hsp = movespeed;
        movespeed = 3 * move;
        
        if (key_slap)
        {
            flash = 1;
            geno_beamstrength += 0.01;
        }
        
        geno_beamstrength = clamp(geno_beamstrength, 0, 10);
        
        if (geno_beamcharge_time < 0)
        {
            hsp = 0;
            
            with (instance_create(x + (xscale * 30), y, obj_genobeam))
            {
                approach_xscale = 10 + other.geno_beamstrength;
                trace("Approach xscale is" + string(approach_xscale));
                image_xscale = 1 * obj_player.xscale;
            }
        }
    }
}
