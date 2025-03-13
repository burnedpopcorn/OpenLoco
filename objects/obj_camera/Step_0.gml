if (instance_exists(obj_specialdoor))
    player = obj_playerspecialstage;
else if (obj_player1.spotlight == 1)
    player = obj_player1;
else
    player = obj_player2;

if (marxseconds >= 10)
{
    marxaddtarget = 2;
    marxalphatarget = 0.2;
}
else
{
    marxaddtarget += 0.02;
    marxalphatarget += 0.001;
}

marxangle += marxadd;
marxadd = lerp(marxadd, marxaddtarget, 0.025);
marxdist = lerp(marxdist, 150, 0.05);

if (keepsecondalarm != 0 && !instance_exists(obj_ghostcollectibles) && global.panic == 1)
{
    alarm[1] = keepsecondalarm;
    keepsecondalarm = 0;
}

if (collect_shake > 0)
    collect_shake *= 0.5;

if (global.coop == 1)
{
    p2pdistance = point_distance(obj_player1.x, obj_player1.y, obj_player2.x, obj_player2.y);
    
    if (obj_player1.x >= obj_player2.x)
        p2pdistancex = -p2pdistance / 2;
    else
        p2pdistancex = p2pdistance / 2;
}

if (floor(image_index) == 10)
    shoving = 0;

var roomname = room_get_name(room);

if (room == rank_room || room == NoRoom || room == rm_intro || room == rm_titlecard || string_letters(roomname) == "Tutori" || string_letters(roomname) == "Tutorii" || room == hub_start || room == hub_afterstart || room == hub_cafe || room == hub_hall || room == hub_afterhall || room == hub_magmamine || room == hub_boss1 || room == hub_lobby || room == hub_hallway || room == hub_locotown || room == hub_forestmaze || room == rm_introcustene || room == rm_titleselect || room == Realtitlescreen || room == Disclamer || room == Titlescreen || room == Scootertransition || room == credits || room == timesuproom || room == boss_room1 || room == characterselect)
    visible = false;
else
    visible = true;

if (global.combo > 0)
{
    alarm[4] = 2;
    global.savedcombo = global.combo;
}

if (shoving == 1 && (image_index >= 3 && bang == 0))
{
    with (instance_create(x, y, obj_fallingHUDface))
    {
        if (obj_player1.spotlight == 0 && obj_player1.character == "P")
        {
            sprite = spr_railh;
            hsp = random_range(-1, -5);
        }
        else
        {
            sprite = spr_pizzakincheese;
            hsp = random_range(1, 5);
        }
    }
    
    bang = 1;
}

if (shoving == 0)
    bang = 0;

if (room == timesuproom)
    timestop = 1;

if (global.seconds <= 0 && (global.minutes <= 0 && ded == 0))
{
    alarm[1] = -1;
    alarm[2] = 3;
    ded = 1;
}

if (global.seconds < 0)
{
    global.seconds = 59;
    global.minutes -= 1;
}

if (global.seconds > 59)
{
    global.minutes += 1;
    global.seconds -= 59;
}

if (!instance_exists(obj_ghostcollectibles))
{
    if ((global.panic == 1 && global.minutes < 1) || player.sprite_index == get_charactersprite("spr_timesup", player))
    {
        shake_mag = 2;
        shake_mag_acc = 3 / room_speed;
    }
    else if (global.panic == 1 && basement == 0)
    {
        shake_mag = 2;
        shake_mag_acc = 3 / room_speed;
    }
}

if (instance_exists(obj_ghostcollectibles) && alarm[1] > 0 && keepsecondalarm != alarm[1])
{
    keepsecondalarm = alarm[1];
    alarm[1] = -1;
}

if (shake_mag > 0)
{
    shake_mag -= shake_mag_acc;
    
    if (shake_mag < 0)
        shake_mag = 0;
}

if (gatecamera == 1)
{
    if (!instance_exists(gateid))
        gatecamera = 0;
}

if (room != rm_2point5test)
{
    alpha = Approach(alpha, alphaend, 0.07);
    var vw = camera_get_view_width(view_camera[0]);
    var vh = camera_get_view_height(view_camera[0]);
    var va = camera_get_view_angle(view_camera[0]);
    targetzoom = min(2.5, targetzoom);
    targetangle = min(2.5, targetangle);
    var nw = lerp(vw, targetzoom * original_cam_width, zoomspd);
    var nh = lerp(vh, targetzoom * original_cam_height, zoomspd);
    var na = lerp(va, targetangle, anglespd);
    preangle = na;
    prezoomx = nw;
    prezoomy = nh;
    camera_set_view_size(view_camera[0], nw, nh);
    camera_set_view_angle(view_camera[0], na);
    
    if (instance_exists(player) && (player.state != states.timesup && player.state != states.gameover))
    {
        if (player != obj_playerspecialstage || (player == obj_playerspecialstage && player.state != 6))
        {
            var target = player;
            var cam_width = camera_get_view_width(view_camera[0]);
            var cam_height = camera_get_view_height(view_camera[0]);
            
            if (player == obj_ballspecialstage)
                camera_set_view_angle(view_camera[0], -player.anglevertx);
            
            if (target != obj_playerspecialstage)
            {
                if (player.state == states.mach2 || player.state == states.mach3 || player.state == states.tumble || player.state == states.lawnmower)
                {
                    var _targetcharge = player.xscale * ((player.movespeed / 4) * 50);
                    var _tspeed = 0.3;
                    chargecamera = Approach(chargecamera, _targetcharge, _tspeed);
                }
                else if (abs(player.hsp) >= 16 && player.state != states.climbwall && player.state != states.Sjump)
                {
                    var _targetcharge = player.xscale * ((abs(player.movespeed) / 4) * 50);
                    var _tspeed = 2;
                    
                    if ((_targetcharge > 0 && chargecamera < 0) || (_targetcharge < 0 && chargecamera > 0))
                        _tspeed = 8;
                    
                    chargecamera = Approach(chargecamera, _targetcharge, _tspeed);
                }
                else if (player.state == states.machslide)
                {
                    chargecamera = Approach(chargecamera, 0, 10);
                }
                else
                {
                    chargecamera = Approach(chargecamera, 0, 6);
                }
            }
            
            var cam_x = camera_get_view_x(view_camera[0]);
            var cam_y = camera_get_view_y(view_camera[0]);
            
            if (global.smoothcam)
            {
                if (gatecamera == 1 && instance_exists(gateid))
                {
                    cam_x += ((((target.x + gateid.x) / 2) - (cam_width / 2) - cam_x) * 0.3);
                    cam_y += ((gateid.y - (cam_height / 2) - 50 - cam_y) * 0.3);
                }
                else
                {
                    cam_x += ((((target.x - (cam_width / 2)) + chargecamera) - cam_x) * 0.3);
                    cam_y += ((target.y - (cam_height / 2) - 50 - cam_y) * 0.3);
                }
            }
            else if (gatecamera == 1 && instance_exists(gateid))
            {
                cam_x = ((target.x + gateid.x) / 2) - (cam_width / 2);
                cam_y = gateid.y - (cam_height / 2) - 50;
            }
            else
            {
                cam_x = (target.x - (cam_width / 2)) + chargecamera;
                cam_y = target.y - (cam_height / 2) - 50;
            }
            
            if (obj_screen.scaleMode == 1)
            {
            }
            
            cam_x = clamp(cam_x, 0, room_width - cam_width);
            cam_y = clamp(cam_y, 0, room_height - cam_height);
            camera_zoom(zoom, spdzooming);
            camera_angle(angle, spdangle);
            
            if (shake_mag != 0)
            {
                cam_x += irandom_range(-shake_mag, shake_mag);
                cam_y += irandom_range(-shake_mag, shake_mag);
            }
            
            if (!lock)
                camera_set_view_pos(view_camera[0], floor(cam_x), floor(cam_y + irandom_range(-shake_mag, shake_mag)));
        }
    }
}

if (gettingfilltimer && global.panic)
{
    global.fill = ((global.minutes * 60) + global.seconds) * 60;
    
    if (global.fill >= obj_tv.chunkmax)
        obj_tv.chunkmax = global.fill;
    
    if (global.fill >= global.maxwave)
        global.maxwave = global.fill;
}

if (marxstunned)
{
    marx_index += 0.35;
    
    if (marx_index > (marx_number - 1))
        marx_index = 0 + frac(marx_index);
}
