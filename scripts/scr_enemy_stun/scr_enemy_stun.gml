function scr_enemy_stun()
{
    if (object_index == obj_ninja)
        attack = 1;
    
    switch (global.stylethreshold)
    {
        case 0:
            stunned -= 0.5;
            break;
        
        case 1:
            stunned -= 0.65;
            break;
        
        case 2:
            stunned -= 0.8;
            break;
        
        case 3:
            stunned -= 1;
    }
    
    if (thrown == 0)
        sprite_index = stunfallspr;
    else
        sprite_index = spr_dead;
    
    image_speed = 0.35;
    var t = thrown;
    
    if (!thrown)
        grav = 0.5;
    
    if (((grounded || (grounded && !place_meeting(x, y, obj_platform))) && vsp > 0) && thrown == 0)
    {
        if (grounded)
            hsp = Approach(hsp, 0, 0.3);
    }
    
    if (place_meeting(x, y + 1, obj_railh))
        hsp = -5;
    else if (place_meeting(x, y + 1, obj_railh2))
        hsp = 5;
    
    if (linethrown)
    {
        if (thrown)
        {
            if (abs(hithsp) > abs(hitvsp))
                hitvsp = 0;
            
            hsp = hithsp;
            vsp = hitvsp;
            
            if (hithsp != 0)
                scr_destroy_destructibles(hithsp, 0);
            
            if (hitvsp != 0)
                scr_destroy_destructibles(0, hitvsp);
            
            if (hithsp != 0 && hitvsp != 0)
                scr_destroy_destructibles(hithsp, hitvsp);
        }
    }
    
    if ((grounded || (grounded && !place_meeting(x, y, obj_platform))) && vsp > 0 && !place_meeting(x + hsp, y, obj_destructibles))
    {
        if (thrown == 1)
        {
            vsp = -5;
            
            if ((!elite || elitehit <= 0) && destroyable)
                instance_destroy();
            
            thrown = 0;
        }
    }
    
    if (hitvsp < 0 && scr_solid(x, y - 1) && !place_meeting(x, y - 1, obj_destructibles))
    {
        if (thrown == 1)
        {
            if ((!elite || elitehit <= 0) && destroyable)
                instance_destroy();
            
            thrown = 0;
        }
    }
    
    if (hithsp != 0 && scr_solid(x + hithsp, y) && (!place_meeting(x + hithsp, y, obj_destructibles) && !place_meeting(x + hsp, y, obj_enemyblock)))
    {
        if (thrown == 1)
        {
            if ((!elite || elitehit <= 0) && destroyable)
                instance_destroy();
            
            thrown = 0;
        }
    }
    
    if (t != thrown && t && elite)
    {
        elitehit--;
        
        if (elitehit < 0)
            elitehit = 0;
        
        if (elitehit > 0)
        {
            event_perform(ev_destroy, 0);
            var b = ds_list_find_index(global.baddieroom, id);
            
            if (b != -1)
                ds_list_delete(global.baddieroom, b);
            
            image_xscale *= -1;
            hsp = 5 * -image_xscale;
            flash = 0;
        }
        else if (destroyable)
            instance_destroy();
    }
    
    if (grounded && elite)
        stunned -= 5;
    
    if (stunned <= 0 && grounded)
    {
        if (object_index == obj_marxbaddie)
        {
            if (!instance_exists(obj_marx))
            {
                with (instance_create(x, y, obj_marx))
                {
                    image_alpha = 1;
                    wingsx = x - 3000;
                    wingsy = y + 3000;
                    hexagonx = x - 3000;
                    hexagony = y - 3000;
                    shoex = x + 3000;
                    shoey = y + 3000;
                    tiex = x + 3000;
                    tiey = y - 3000;
                }
            }
            
            marxunpunched = 1;
            instance_destroy();
        }
        else
        {
            vsp = 0;
            image_index = 0;
            sprite_index = walkspr;
            state = states.actor;
            stunned = 0;
        }
    }
    
    if (stuntouchbuffer > 0)
        stuntouchbuffer--;
    
    if (abs(hsp) > 4 && grounded)
    {
        if (!instance_exists(dashcloudid))
        {
            with (instance_create(x, y, obj_dashcloud))
            {
                image_xscale = sign(other.hsp);
                other.dashcloudid = id;
            }
        }
    }
}
