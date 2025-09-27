var _target = obj_marx;

if (instance_exists(obj_marxlaser))
    _target = obj_marxlaser;

fmod_studio_event_instance_set_parameter_by_name(laser_sound_instance, "state", instance_exists(obj_marxlaser));
fmod_studio_event_instance_move(laser_sound_instance, _target.x, _target.y);
fmod_studio_event_instance_move(laughsound, x, y);
highest_y = -170;
var _instY = collision_line(obj_player1.x, obj_player1.y, obj_player1.x, obj_player1.y - 170, obj_solid, false, true);

if (_instY != noone)
    highest_y = -abs(obj_player1.y - (_instY.y + _instY.sprite_height)) - 32;

if (image_alpha == 1)
{
    if (sprite_index == spr_marx_head_spit_left || sprite_index == spr_marx_head_spit_right)
    {
        var leftorright = 0;
        
        if (sprite_index == spr_marx_head_spit_left)
            leftorright = "left";
        
        if (sprite_index == spr_marx_head_spit_right)
            leftorright = "right";
        
        if (floor(image_index) >= 5 && usingonce == 0)
        {
            if (powerlimit < 5)
            {
                usingonce = 1;
                
                with (instance_create(x, y, obj_ballmarx))
                {
                    movespeed = 5;
                    
                    if (leftorright == "left")
                        image_xscale = -1;
                    
                    if (leftorright == "right")
                        image_xscale = 1;
                }
                
                powerlimit += 1;
            }
            else if (powerlimit >= 5)
            {
                usingonce = 1;
                
                with (instance_create(x, y, obj_ballmarx))
                {
                    movespeed = 5;
                    
                    if (leftorright == "left")
                        image_xscale = -1;
                    
                    if (leftorright == "right")
                        image_xscale = 1;
                }
                
                powerlimit = 0;
                powerselect = 1;
                usepower = 0;
            }
        }
        
        if (floor(image_index) == (image_number - 1))
        {
            sprite_index = spr_marx_head;
            usingonce = 0;
            
            if (powerselect == 0)
                alarm[2] = random_range(50, 125);
        }
    }
    
    if (!startanim)
    {
        sprite_index = spr_marx_head;
        startanim = 1;
    }
    
    if (!blackhole && !laser)
    {
        if (!usepower && !instakillmove)
        {
            switch (powerselect)
            {
                case 0:
                    alarm[2] = random_range(100, 300);
                    break;
                
                case 1:
                    alarm[3] = random_range(100, 300);
                    break;
                
                case 2:
                    alarm[4] = random_range(100, 300);
                    break;
            }
            
            usepower = 1;
        }
        else if (instakillmove)
        {
            if (!usepower)
            {
                alarm[6] = random_range(200, 300);
                usepower = 1;
            }
        }
        
        var dir = point_direction(x, y, obj_player1.x, obj_player1.y);
        var yoffest;
        
        if (!arrows)
            yoffest = Wave(-12, 12, 2, 15);
        else
            yoffest = Wave(-25, 25, 0.8, 15);
        
        var xmove = Wave(-250, 250, 7, 15);
        x = lerp(x, obj_player1.x - xmove, 0.2) + wave(waveamnt, -waveamnt, wavetime * 2, 0);
        y = lerp(y, obj_player1.y + highest_y + yoffest, 0.2) + wave(waveamnt, -waveamnt, wavetime, 0);
        
        if (x != obj_player1.x)
            image_xscale = -sign(x - obj_player1.x);
    }
    else if (blackhole)
    {
        x = lerp(x, obj_player1.x, 0.2) + wave(waveamnt, -waveamnt, wavetime * 2, 0);
        y = lerp(y, obj_player1.y, 0.2) + wave(waveamnt, -waveamnt, wavetime, 0);
    }
    else if (laser)
    {
        x = lerp(x, obj_player1.x + 200, 0.2);
        y = lerp(y, obj_player1.y, 0.2);
        
        if (amountlaser < 320 && obj_player1.state != states.comingoutdoor && obj_player1.state != states.door)
        {
            sprite_index = spr_marx_head_lazer_charge;
            amountlaser += 1;
        }
        
        if (amountlaser >= 320)
        {
            amountlaser = 320;
            
            if (!instance_exists(obj_marxlaser))
            {
                sprite_index = spr_marx_head_lazer;
                instance_create(x, y - 50, obj_marxlaser);
            }
            
            ballpower = 0;
        }
    }
}
else
{
    x = lerp(x, obj_player1.x, 0.2) + wave(waveamnt, -waveamnt, wavetime * 2, 0);
    y = lerp(y, obj_player1.y, 0.2) + wave(waveamnt, -waveamnt, wavetime, 0);
    image_alpha += 0.01;
}

if (arrows && !usingarrows)
{
    alarm[5] = 10;
    usingarrows = 1;
}

if (ballpower)
{
    ballscale = Wave(ballmax, -ballmax, 0.8, 15);
    ballmax = Wave(ballmax, 20, 2, 15);
}

laserbar = (amountlaser / amountlasermax) * 100;
var addbottom = 0;

if (sprite_index == spr_marx_head_lazer_charge)
    addbottom = 10;

if (sprite_index == spr_marx_head_lazer)
    addbottom = 80;

leftshoex = lerp(leftshoex, x - 50, 0.35);
leftshoey = lerp(leftshoey, y + 65 + addbottom, 0.35);
rightshoex = lerp(rightshoex, x + 50, 0.35);
rightshoey = lerp(rightshoey, y + 65 + addbottom, 0.35);
tiex = lerp(tiex, x, 0.35);
tiey = lerp(tiey, (y - 5) + addbottom, 0.35);
addbottom = 0;

if (sprite_index == spr_marx_head_lazer_charge)
    addbottom = 20;

if (sprite_index == spr_marx_head_lazer)
    addbottom = 50;

leftwingsx = lerp(leftwingsx, x - 100, 0.25);
leftwingsy = lerp(leftwingsy, y - 70 - addbottom, 0.25);
rightwingsx = lerp(rightwingsx, x + 100, 0.25);
rightwingsy = lerp(rightwingsy, y - 70 - addbottom, 0.25);
lefthexagonx = lerp(lefthexagonx, x - 125, 0.25);
lefthexagony = lerp(lefthexagony, y - 60 - addbottom, 0.25);
righthexagonx = lerp(righthexagonx, x + 125, 0.25);
righthexagony = lerp(righthexagony, y - 60 - addbottom, 0.25);
