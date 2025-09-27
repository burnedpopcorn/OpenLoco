function scr_enemy_grabbed()
{
    var _obj_player = asset_get_index(concat("obj_player", grabbedby));
    image_xscale = -_obj_player.xscale;
    image_xscale = -_obj_player.xscale;
    stunned = 200;
    _obj_player.baddiegrabbedID = id;
    
    if (_obj_player.state == states.grabbing || (_obj_player.state == states.grab || (_obj_player.state == states.throwin || (_obj_player.state == states.slam || _obj_player.state == states.tacklecharge))))
    {
        x = _obj_player.x;
        
        if (_obj_player.sprite_index != get_charactersprite("spr_haulingstart", _obj_player))
            y = _obj_player.y - 40;
        else if (floor(_obj_player.image_index) == 0)
            y = _obj_player.y;
        else if (floor(_obj_player.image_index) == 1)
            y = _obj_player.y - 10;
        else if (floor(_obj_player.image_index) == 2)
            y = _obj_player.y - 20;
        else if (floor(_obj_player.image_index) == 3)
            y = _obj_player.y - 30;
        
        image_xscale = -_obj_player.xscale;
    }
    
    with (_obj_player)
    {
        suplexhavetomash = other.hp - 1;
        move = key_left2 + key_right2;
        
        if (!(state == states.grab || state == states.finishingblow || state == states.grabbing || (state == states.chainsaw && tauntstoredstate == 43) || state == states.throwin || state == states.slam || state == states.tacklecharge || state == states.punch || state == states.superslam || state == states.backkick || state == states.uppunch || state == states.shoulder))
        {
            other.x = x;
            other.y = y;
            other.state = states.capefall;
            other.image_index = 0;
        }
    }
    
    hsp = 0;
    
    if (_obj_player.state == states.punch)
    {
        alarm[3] = 3;
        global.hit += 1;
        
        if (other.object_index == obj_pizzaball)
            global.golfhit += 1;
        
        hp -= 1;
        instance_create(x + (_obj_player.xscale * 30), y, obj_bumpeffect);
        alarm[1] = 5;
        thrown = 1;
        x = _obj_player.x;
        vsp = 0;
        y = _obj_player.y;
        state = states.capefall;
        hsp = -image_xscale * 25;
        grav = 0;
        global.combotime = 60;
        instance_create(x, y, obj_slapstar);
        instance_create(x, y, obj_baddiegibs);
        flash = 1;
        
        with (obj_camera)
        {
            shake_mag = 3;
            shake_mag_acc = 3 / room_speed;
        }
    }
    
    if (_obj_player.state == states.finishingblow)
    {
        if (floor(_obj_player.image_index) < 1 && _obj_player.sprite_index == get_charactersprite("spr_swingdingend", _obj_player))
        {
            x = _obj_player.x + (_obj_player.xscale * 60);
            y = _obj_player.y;
        }
        else if (floor(_obj_player.image_index) < 4)
        {
            x = _obj_player.x + (_obj_player.xscale * 60);
            y = _obj_player.y;
        }
        
        check_grabbed_solid(_obj_player);
    }
    
    if (_obj_player.state == states.finishingblow && (floor(_obj_player.image_index) >= 4 || (floor(_obj_player.image_index) < 1 && _obj_player.sprite_index == get_charactersprite("spr_swingdingend", _obj_player))))
    {
        var lag = 5;
        hitLag = lag;
        hitX = x;
        hitY = y;
        instance_create(x, y, obj_slapstar);
        instance_create(x, y, obj_slapstar);
        instance_create(x, y, obj_slapstar);
        instance_create(x, y, obj_baddiegibs);
        instance_create(x, y, obj_baddiegibs);
        instance_create(x, y, obj_baddiegibs);
        _obj_player.movespeed = 0;
        _obj_player.hitLag = lag;
        _obj_player.hitX = _obj_player.x;
        _obj_player.hitY = _obj_player.y;
        
        with (obj_camera)
        {
            shake_mag = 3;
            shake_mag_acc = 3 / room_speed;
        }
        
        alarm[3] = 3;
        global.hit += 1;
        
        if (other.object_index == obj_pizzaball)
            global.golfhit += 1;
        
        global.combotime = 60;
        alarm[1] = 5;
        thrown = 1;
        state = states.capefall;
        
        with (_obj_player)
        {
            vsp = -6;
            
            if (sprite_index == get_charactersprite("spr_uppercutfinishingblow"))
            {
                other.hithsp = 0;
                other.hitvsp = -25;
                other.linethrown = 1;
            }
            else
            {
                other.hithsp = -other.image_xscale * 25;
                other.hitvsp = -8;
                other.linethrown = 1;
            }
        }
        
        check_grabbed_solid(_obj_player);
        check_grabbed_solid(_obj_player);
    }
    
    if (_obj_player.state == states.backkick)
    {
        alarm[3] = 3;
        global.hit += 1;
        
        if (other.object_index == obj_pizzaball)
            global.golfhit += 1;
        
        hp -= 1;
        instance_create(x + (-_obj_player.xscale * 50), y, obj_bumpeffect);
        alarm[1] = 5;
        thrown = 1;
        x = _obj_player.x;
        y = _obj_player.y;
        state = states.capefall;
        image_xscale *= -1;
        hsp = -image_xscale * 20;
        vsp = -7;
        global.combotime = 60;
        instance_create(x, y, obj_slapstar);
        instance_create(x, y, obj_baddiegibs);
        flash = 1;
        
        with (obj_camera)
        {
            shake_mag = 3;
            shake_mag_acc = 3 / room_speed;
        }
    }
    
    if (_obj_player.state == 50)
    {
        alarm[3] = 3;
        global.hit += 1;
        
        if (other.object_index == obj_pizzaball)
            global.golfhit += 1;
        
        hp -= 1;
        instance_create(x, y + 20, obj_bumpeffect);
        alarm[1] = 5;
        thrown = 1;
        x = _obj_player.x;
        y = _obj_player.y;
        state = states.capefall;
        
        if (_obj_player.sprite_index == get_charactersprite("spr_shoulder"))
            vsp = 15;
        
        if (_obj_player.sprite_index == get_charactersprite("spr_diagonaldownthrow"))
        {
            hsp = -image_xscale * 10;
            vsp = 15;
        }
        
        if (_obj_player.sprite_index == get_charactersprite("spr_diagonalupthrow"))
        {
            hsp = -image_xscale * 10;
            vsp = -15;
        }
        
        global.combotime = 60;
        instance_create(x, y, obj_slapstar);
        instance_create(x, y, obj_baddiegibs);
        flash = 1;
        
        with (obj_camera)
        {
            shake_mag = 3;
            shake_mag_acc = 3 / room_speed;
        }
    }
    
    if (_obj_player.state == states.throwin)
    {
        global.hit += 1;
        
        if (other.object_index == obj_pizzaball)
            global.golfhit += 1;
        
        alarm[1] = 5;
        thrown = 1;
        x = _obj_player.x;
        y = _obj_player.y;
        state = states.capefall;
        hsp = -image_xscale * 8;
        vsp = -6;
        check_grabbed_solid(_obj_player);
        check_grabbed_solid(_obj_player);
    }
    
    if (_obj_player.state == states.uppunch)
    {
        alarm[3] = 3;
        global.hit += 1;
        
        if (other.object_index == obj_pizzaball)
            global.golfhit += 1;
        
        hp -= 1;
        instance_create(x + (-_obj_player.xscale * 15), y - 50, obj_bumpeffect);
        alarm[1] = 5;
        thrown = 1;
        x = _obj_player.x;
        y = _obj_player.y;
        hsp = -image_xscale * 2;
        state = states.capefall;
        vsp = -20;
        global.combotime = 60;
        instance_create(x, y, obj_slapstar);
        instance_create(x, y, obj_baddiegibs);
        flash = 1;
        
        with (obj_camera)
        {
            shake_mag = 3;
            shake_mag_acc = 3 / room_speed;
        }
        
        check_grabbed_solid(_obj_player);
    }
    
    if (_obj_player.state == states.tacklecharge)
    {
        x = _obj_player.x + (_obj_player.xscale * 15);
        y = _obj_player.y;
    }
    
    if (_obj_player.state == states.superslam && _obj_player.sprite_index == get_charactersprite("spr_piledriver", _obj_player))
    {
        if (_obj_player.character == "P")
        {
            yscale = -1;
            
            if (floor(_obj_player.image_index) == 0)
            {
                depth = 0;
                x = _obj_player.x + (_obj_player.xscale * 10);
                y = _obj_player.y;
            }
            
            if (floor(_obj_player.image_index) == 1)
            {
                depth = 0;
                x = _obj_player.x + (_obj_player.xscale * 5);
                y = _obj_player.y;
            }
            
            if (floor(_obj_player.image_index) == 2)
            {
                depth = 0;
                x = _obj_player.x;
                y = _obj_player.y;
            }
            
            if (floor(_obj_player.image_index) == 3)
            {
                depth = 0;
                x = _obj_player.x + (_obj_player.xscale * -5);
                y = _obj_player.y;
            }
            
            if (floor(_obj_player.image_index) == 4)
            {
                depth = 0;
                x = _obj_player.x + (_obj_player.xscale * -10);
                y = _obj_player.y;
            }
            
            if (floor(_obj_player.image_index) == 5)
            {
                depth = -8;
                x = _obj_player.x + (_obj_player.xscale * -5);
                y = _obj_player.y;
            }
            
            if (floor(_obj_player.image_index) == 6)
            {
                depth = -8;
                x = _obj_player.x;
                y = _obj_player.y;
            }
            
            if (floor(_obj_player.image_index) == 7)
            {
                depth = -8;
                x = _obj_player.x + (_obj_player.xscale * 5);
                y = _obj_player.y;
            }
            
            check_grabbed_solid(_obj_player);
        }
        else
        {
            depth = -7;
            x = _obj_player.x;
            y = _obj_player.y - 40;
            check_grabbed_solid(_obj_player);
        }
    }
    
    if (_obj_player.sprite_index == get_charactersprite("spr_piledriverland", _obj_player) && floor(_obj_player.image_index) == (_obj_player.image_number - 1))
    {
        var lag = 5;
        hitLag = lag;
        hitX = x;
        hitY = y;
        _obj_player.hitLag = lag;
        _obj_player.hitX = _obj_player.x;
        _obj_player.hitY = _obj_player.y;
        instance_create(x, y, obj_slapstar);
        instance_create(x, y, obj_baddiegibs);
        flash = 1;
        global.combotime = 60;
        global.hit += 1;
        hp -= 5;
        alarm[1] = 5;
        thrown = 1;
        state = states.capefall;
        hsp = -image_xscale * 10;
        
        with (_obj_player)
        {
            if (state != states.chainsaw)
            {
                tauntstoredmovespeed = movespeed;
                tauntstoredsprite = sprite_index;
                tauntstoredstate = state;
            }
            
            state = states.chainsaw;
            other.hithsp = -other.image_xscale * 8;
            other.hitvsp = -11;
        }
    }
    
    if (_obj_player.state == states.grab && _obj_player.sprite_index == get_charactersprite("spr_swingding", _obj_player))
    {
        if (floor(_obj_player.image_index) == 0)
        {
            depth = -8;
            x = _obj_player.x + (_obj_player.xscale * 25);
            y = _obj_player.y;
        }
        
        if (floor(_obj_player.image_index) == 1)
        {
            depth = -8;
            x = _obj_player.x;
            y = _obj_player.y;
        }
        
        if (floor(_obj_player.image_index) == 2)
        {
            depth = -8;
            x = _obj_player.x + (_obj_player.xscale * -25);
            y = _obj_player.y;
        }
        
        if (floor(_obj_player.image_index) == 3)
        {
            depth = 0;
            x = _obj_player.x + (_obj_player.xscale * -50);
            y = _obj_player.y;
        }
        
        if (floor(_obj_player.image_index) == 4)
        {
            depth = 0;
            x = _obj_player.x + (_obj_player.xscale * -25);
            y = _obj_player.y;
        }
        
        if (floor(_obj_player.image_index) == 5)
        {
            depth = 0;
            x = _obj_player.x;
            y = _obj_player.y;
        }
        
        if (floor(_obj_player.image_index) == 6)
        {
            depth = 0;
            x = _obj_player.x + (_obj_player.xscale * 25);
            y = _obj_player.y;
        }
        
        if (floor(_obj_player.image_index) == 7)
        {
            depth = 0;
            x = _obj_player.x + (_obj_player.xscale * 50);
            y = _obj_player.y;
        }
    }
    
    if (state != states.capefall || _obj_player.state != states.grab)
    {
        check_grabbed_solid(_obj_player);
        
        if (state == states.hit)
        {
            hitX = x;
            hitY = y;
        }
    }
    
    sprite_index = stunfallspr;
    image_speed = 0.35;
}

function check_grabbed_solid(argument0)
{
    if (instakilled)
        exit;
    
    if (!place_meeting(x, y, obj_destructibles) && (place_meeting_collision(x, y) || collision_line(x, y, argument0.x, argument0.y, obj_solid, false, true) != noone))
    {
        var _dist = abs(x - argument0.x);
        x = argument0.x;
        y = argument0.y;
        
        if (!place_meeting_collision(x + argument0.xscale, y))
        {
            var i = 0;
            
            while (!place_meeting_collision(x + argument0.xscale, y))
            {
                x += argument0.xscale;
                i++;
                
                if (i > _dist)
                    break;
                else
                    continue;
            }
            
            if (place_meeting_collision(x, y))
            {
                i = 0;
                
                while (place_meeting_collision(x, y))
                {
                    x -= argument0.xscale;
                    i++;
                    
                    if (i > _dist)
                        break;
                    else
                        continue;
                }
            }
        }
    }
}
