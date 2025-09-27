function bcb_update(_baddie)
{
    if (!instance_exists(_baddie) || obj_player1.cutscene || obj_player1.state == states.firemouth)
        exit;
    
    if (place_meeting(x, y, obj_player1))
    {
        var p = instance_place(x, y, obj_player);
        
        if (_baddie.state != states.grabbed && instance_exists(_baddie))
        {
            with (p)
            {
                if (instakillmove == 1 && _baddie.invtime == 0)
                    instakill();
                
                if (y < _baddie.y && attacking == 0 && !_baddie.linethrown && !_baddie.thrown && sprite_index != get_charactersprite("spr_mach2jump") && (state == states.jump || state == states.grab) && vsp > 0 && _baddie.vsp >= 0 && sprite_index != get_charactersprite("spr_stompprep"))
                {
                    fmod_studio_event_oneshot_3d("event:/sfx/enemy/stomped");
                    
                    with (_baddie)
                    {
                        xscale = 1.4;
                        yscale = 0.6;
                        
                        if (other.x != x)
                            image_xscale = -sign(x - other.x);
                        
                        hsp = xscale * 5;
                        vsp = -5;
                        state = states.capefall;
                        
                        if (stunned < 100)
                            stunned = 100;
                        
                        image_index = 0;
                    }
                    
                    instance_create(x, y + 50, obj_stompeffect);
                    stompAnim = 1;
                    vsp = key_jump2 ? -14 : -9;
                    
                    if (state != states.grab)
                    {
                        fmod_studio_event_oneshot_3d("event:/sfx/enemy/stomped");
                        image_index = 0;
                        sprite_index = get_charactersprite("spr_stompprep");
                    }
                }
                
                if (_baddie.stuntouchbuffer <= 0 && _baddie.state != states.throwing && _baddie.vsp > 0 && (state == states.mach2 || state == states.tumble))
                {
                    _baddie.stuntouchbuffer = 15;
                    var lag = 0;
                    
                    with (_baddie)
                    {
                        instance_create(x, y, obj_bangeffect);
                        state = states.hit;
                        image_xscale = -other.xscale;
                        hithsp = other.xscale * 12;
                        hitvsp = (other.y - 180 - y) / 60;
                        hitLag = lag;
                        hitX = x;
                        hitY = y;
                        flash = 1;
                    }
                    
                    tauntstoredstate = state;
                    tauntstoredsprite = sprite_index;
                    tauntstoredmovespeed = movespeed;
                    tauntstoredvsp = vsp;
                    state = states.chainsaw;
                    hitLag = lag;
                    hitX = x;
                    hitY = y;
                    
                    repeat (2)
                    {
                        with (create_debris(x, y, spr_slapstar))
                            vsp = irandom_range(-6, -11);
                    }
                }
                
                if (state == states.handstandjump && sprite_index == get_charactersprite("spr_shoulderbashstart") && _baddie.state != states.hit)
                {
                    _baddie.stuntouchbuffer = 15;
                    var lag = 10;
                    var spd = [0, 0];
                    
                    with (_baddie)
                    {
                        instance_create(x, y, obj_parryeffect);
                        state = states.hit;
                        image_xscale = -other.xscale;
                        hitLag = lag;
                        thrown = 1;
                        hitX = x;
                        hitY = y;
                        shoulderbashed = 1;
                    }
                    
                    if (move == xscale)
                    {
                        if (key_up)
                        {
                            image_index = 1;
                            spd = [0, -25];
                            _baddie.linethrown = 1;
                        }
                        else
                        {
                            image_index = 2;
                            spd = [-25 * _baddie.image_xscale, 0];
                            _baddie.linethrown = 1;
                        }
                    }
                    else if (key_up)
                    {
                        image_index = 1;
                        spd = [0, -25];
                        _baddie.linethrown = 1;
                    }
                    else if (-key_down)
                    {
                        image_index = 0;
                        spd = [0, 25];
                        _baddie.linethrown = 1;
                    }
                    
                    with (_baddie)
                    {
                        hithsp = spd[0];
                        hitvsp = spd[1];
                    }
                    
                    obj_camera.zoomspd = 0.2;
                    obj_camera.targetzoom = 0.8;
                    sprite_index = get_charactersprite("spr_shoulderbashhit");
                    tauntstoredstate = state;
                    tauntstoredsprite = sprite_index;
                    tauntstoredmovespeed = movespeed;
                    tauntstoredvsp = vsp;
                    state = states.chainsaw;
                    hitLag = lag;
                    hitX = x;
                    hitY = y;
                    
                    repeat (2)
                    {
                        with (create_debris(x, y, spr_slapstar))
                            vsp = irandom_range(-6, -11);
                    }
                }
                
                if (state == states.handstandjump && global.laps < 6)
                {
                    image_index = 0;
                    
                    if (!key_up)
                    {
                        if (movespeed <= 10)
                            sprite_index = get_charactersprite("spr_haulingstart");
                        else
                            sprite_index = get_charactersprite("spr_swingding");
                        
                        if (!grounded)
                            vsp = -6;
                        
                        swingdingendcooldown = 0;
                        state = states.grab;
                        baddiegrabbedID = _baddie;
                        _baddie.state = states.grabbed;
                        _baddie.grabbedby = 1;
                        
                        with (_baddie)
                        {
                            if (object_index == obj_waluigiboss)
                                scr_boss_grabbed();
                        }
                    }
                    else
                    {
                        baddiegrabbedID = _baddie;
                        _baddie.state = states.grabbed;
                        _baddie.grabbedby = 1;
                        sprite_index = get_charactersprite("spr_piledriver");
                        vsp = -14;
                        state = states.superslam;
                        image_speed = 0.35;
                        image_index = 0;
                    }
                }
                else if ((state == states.handstandjump || state == states.lungeattack) && _baddie.lunged == 0 && _baddie.state != states.superslam && global.laps >= 6)
                {
                    fmod_studio_event_oneshot_3d("event:/sfx/player/misc/kill");
                    _baddie.state = states.superslam;
                    _baddie.image_xscale = -xscale;
                    _baddie.lungeHP--;
                    _baddie.lunged = 1;
                    trace("Lungeattack1");
                    state = states.lungeattack;
                    
                    if (sprite_index != get_charactersprite("spr_suplexmash1") && sprite_index != get_charactersprite("spr_suplexmash5"))
                        sprite_index = get_charactersprite("spr_suplexmash3");
                    
                    image_index = 0;
                    lunge_hits++;
                    bcb_doHitstun(10, _baddie);
                }
            }
        }
    }
}

function create_baddiecollisionbox()
{
    if (boundbox == 0)
    {
        with (instance_create(x, y, obj_baddiecollisionbox))
        {
            sprite_index = other.sprite_index;
            mask_index = other.sprite_index;
            baddieID = other.id;
            other.boundbox = 1;
        }
    }
}
