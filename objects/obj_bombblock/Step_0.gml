if (obj_player1.state == states.unknown27 && (obj_player1.sprite_index != get_charactersprite("spr_bombpepend", obj_player1) && (place_meeting(x + 1, y, obj_player1) || (place_meeting(x - 1, y, obj_player1) || (place_meeting(x, y - 1, obj_player1) || place_meeting(x, y + 1, obj_player1))))))
{
    with (obj_player1)
    {
        instance_create(x, y, obj_bombexplosion);
        hurted = 1;
        vsp = -4;
        image_index = 0;
        sprite_index = get_charactersprite("spr_bombpepend");
        state = states.unknown27;
        bombpeptimer = 0;
    }
}

if (obj_player2.state == states.unknown27 && (obj_player2.sprite_index != get_charactersprite("spr_bombpepend", obj_player2) && (place_meeting(x + 1, y, obj_player2) || (place_meeting(x - 1, y, obj_player2) || (place_meeting(x, y - 1, obj_player2) || place_meeting(x, y + 1, obj_player2))))))
{
    with (obj_player2)
    {
        instance_create(x, y, obj_bombexplosion);
        hurted = 1;
        vsp = -4;
        image_index = 0;
        sprite_index = get_charactersprite("spr_bombpepend");
        state = states.unknown27;
        bombpeptimer = 0;
    }
}
