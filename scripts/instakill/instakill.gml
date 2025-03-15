function instakill()
{
    other.baddieID.invtime = 25;
    
    if (state == states.mach2 && grounded)
    {
        machpunchAnim = 1;
        image_index = 0;
    }
    
    if (state == states.mach3 && other.baddieID.elite && other.baddieID.elitehit > 0)
    {
        if (sprite_index != get_charactersprite("spr_mach3hit"))
        {
            if (fightball == 0)
                sprite_index = get_charactersprite("spr_mach3hit");
            
            image_index = 0;
        }
        
        with (other.baddieID)
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
            }
        }
    }
    
    if (state != states.hurt)
        other.baddieID.grabbedby = 1;
    else
        other.baddieID.grabbedby = 2;
    
    if (!other.baddieID.elite || other.baddieID.elitehit <= 0)
        other.baddieID.mach3destroy = 1;
    
    if (!grounded && (key_jump2 || input_buffer_jump == 0))
    {
        if (state == states.freefall && fightball == 0)
            sprite_index = get_charactersprite("spr_mach2jump");
        
        suplexmove = 0;
        vsp = -11;
    }
    
    if (state != states.chainsaw)
    {
        tauntstoredmovespeed = movespeed;
        tauntstoredsprite = sprite_index;
        tauntstoredstate = state;
        tauntstoredvsp = vsp;
    }
    
    suplexmove = 1;
    var lag = 5;
    
    with (other.baddieID)
    {
        hitLag = lag;
        hitX = x;
        hitY = y;
        hp--;
        instance_create(x, y, obj_parryeffect);
        alarm[3] = 3;
        state = baddiestates.hit;
        image_xscale = -other.xscale;
    }
    
    hitLag = lag;
    hitX = x;
    hitY = y;
    
    repeat (3)
    {
        instance_create(x, y, obj_slapstar);
        instance_create(x, y, obj_baddiegibs);
    }
    
    fmod_studio_event_oneshot_3d("event:/sfx/player/punch");
    global.hit++;
    
    if (!other.baddieID.important)
    {
        global.combotime = 60;
        global.heattime = 60;
        
        if (global.laps >= 5)
            global.style += 10;
    }
    
    with (obj_camera)
    {
        shake_mag = 3;
        shake_mag_acc = 3 / room_speed;
    }
    
    if (!grounded && (state != states.freefall && state != states.superslam && key_jump2))
    {
        if (state == states.mach2 || (state == states.mach3 && fightball == 0))
            sprite_index = get_charactersprite("spr_mach2jump");
        
        suplexmove = 0;
        vsp = -11;
    }
    
    if (state != states.mach2 && state != states.tumble)
    {
        with (instance_create(other.baddieID.x, other.baddieID.y, obj_parryeffect))
            sprite_index = spr_kungfueffect;
    }
    
    other.baddieID.hithsp = xscale * (movespeed + 2);
    
    if (abs(other.baddieID.hithsp) < 10)
        other.baddieID.hithsp = xscale * 10;
    
    other.baddieID.hitvsp = -5;
    state = states.chainsaw;
}

function bcb_doHitstun(argument0 = 10, argument1)
{
    with (obj_player1)
    {
        hitLag = argument0;
        hitX = x;
        hitY = y;
        
        if (state != states.chainsaw)
        {
            tauntstoredmovespeed = movespeed;
            tauntstoredsprite = sprite_index;
            tauntstoredstate = state;
            tauntstoredvsp = vsp;
        }
    }
    
    argument1.hitLag = argument0;
    argument1.hitX = argument1.x;
    argument1.hitY = argument1.y;
    argument1.invtime = 25;
    argument1.hithsp = -argument1.image_xscale * (abs(hsp) + 2);
    
    if (abs(argument1.hithsp) < 10)
        argument1.hithsp = -argument1.image_xscale;
    
    argument1.hitvsp = -5;
    argument1.state = baddiestates.hit;
    obj_player1.state = states.chainsaw;
}
