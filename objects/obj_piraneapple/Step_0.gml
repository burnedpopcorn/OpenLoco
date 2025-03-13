hsp = movespeed;

if (flash == 1 && alarm[2] <= 0)
    alarm[2] = 0.15 * room_speed;

if (state != states.grabbed)
    depth = 0;

if (state != states.grabbed)
    thrown = 0;

if ((obj_player.x > (x - 400) && obj_player.x < (x + 400)) && (y + 200) > obj_player.y)
    attack = 1;

if (attack == 1)
{
    image_speed = abs(movespeed) / 10;
    sprite_index = spr_piraneappleattack;
    vsp = Approach(vsp, (y < obj_player.y) ? 4 : -4, 0.4);
    movespeed = Approach(movespeed, 8 * image_xscale, 0.1);
}

if (obj_player.x != x)
    image_xscale = (obj_player.x > x) ? 1 : -1;

if (place_meeting(x + floor(hsp), y, obj_null))
{
    x = floor(x);
    
    while (!place_meeting(x + sign(hsp), y, obj_null))
        x += sign(hsp);
    
    hsp = 0;
}

x += hsp;

if (place_meeting(x, y + floor(vsp), obj_null))
{
    y = floor(y);
    
    while (!place_meeting(x, y + sign(vsp), obj_null))
        y += sign(vsp);
    
    vsp = 0;
}

y += floor(vsp);
