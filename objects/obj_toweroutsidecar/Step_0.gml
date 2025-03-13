if (obj_player1.state == 8)
{
    obj_player1.x = x;
    obj_player1.y = y - 50;
}

if (hspeed > 0)
    hspeed -= 0.1;

if (hspeed == 5)
{
    obj_player1.state = states.backbreaker;
    obj_player1.sprite_index = get_charactersprite("spr_machfreefall");
    obj_player1.visible = true;
    obj_player1.vsp = -5;
    obj_player1.movespeed = 5;
    obj_player1.xscale = 1;
    sprite_index = spr_car;
    hspeed = 0;
}

image_speed = hspeed / 10 / 2;
