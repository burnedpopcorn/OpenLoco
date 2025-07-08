with (obj_player)
{
    if ((state == states.knightpep || (state == states.knightpepattack || state == states.knightpepslopes)) && cutscene == 0)
    {
        with (instance_create(x, y, obj_knightdebris))
            image_index = 0;
        
        with (instance_create(x, y, obj_knightdebris))
            image_index = 1;
        
        with (instance_create(x, y, obj_knightdebris))
            image_index = 2;
        
        with (instance_create(x, y, obj_knightdebris))
            image_index = 3;
        
        with (instance_create(x, y, obj_knightdebris))
            image_index = 4;
        
        with (instance_create(x, y, obj_knightdebris))
            image_index = 5;
        
        if (x != other.x)
            obj_player.hsp = sign(x - other.x) * 5;
        else
            obj_player.hsp = 5;
        
        vsp = -3;
        image_index = 0;
        obj_player.image_index = 0;
        obj_player.flash = 1;
        state = states.bump;
    }
    else if (state == states.bombpep && hurted == 0)
    {
        instance_create(x, y, obj_bombexplosion);
    }
    else if (state == 15)
    {
        with (instance_create(x, y, obj_boxxeddebris))
            image_index = 0;
        
        with (instance_create(x, y, obj_boxxeddebris))
            image_index = 1;
        
        with (instance_create(x, y, obj_boxxeddebris))
            image_index = 2;
        
        with (instance_create(x, y, obj_boxxeddebris))
            image_index = 3;
        
        with (instance_create(x, y, obj_boxxeddebris))
            image_index = 4;
        
        if (x != other.x)
            obj_player.hsp = sign(x - other.x) * 5;
        else
            obj_player.hsp = 5;
        
        vsp = -3;
        image_index = 0;
        obj_player.image_index = 0;
        obj_player.flash = 1;
        state = states.bump;
    }
    else if (state == states.zombie || state == states.zombiejump || state == states.zombieattack)
    {
        obj_player.grav = 0.5;
        instance_create(x, y, obj_slimedebris);
        instance_create(x, y, obj_slimedebris);
        instance_create(x, y, obj_slimedebris);
        instance_create(x, y, obj_slimedebris);
        instance_create(x, y, obj_slimedebris);
        instance_create(x, y, obj_slimedebris);
        instance_create(x, y, obj_slimedebris);
        instance_create(x, y, obj_slimedebris);
        
        if (x != other.x)
            obj_player.hsp = sign(x - other.x) * 5;
        else
            obj_player.hsp = 5;
        
        vsp = -3;
        image_index = 0;
        obj_player.image_index = 0;
        obj_player.flash = 1;
        state = states.bump;
    }
    else if (state != states.hurt && (hurted == 0 && (cutscene == 0 && state != states.bump)))
    {
        global.hurtcounter += 1;
        alarm[8] = 60;
        alarm[7] = 120;
        hurted = 1;
        
        if (xscale == other.image_xscale)
            sprite_index = spr_hurtjump;
        else
            sprite_index = spr_hurt;
        
        movespeed = 8;
        vsp = -14;
        
        if (global.collect > 100)
            global.collect -= 100;
        else
            global.collect = 0;
        
        if (global.collect != 0)
        {
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
            instance_create(x, y, obj_pizzaloss);
        }
        
        instance_create(x, y, obj_spikehurteffect);
        state = states.hurt;
        image_index = 0;
        flash = 1;
    }
}
