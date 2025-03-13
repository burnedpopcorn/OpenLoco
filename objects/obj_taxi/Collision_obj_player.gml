if (obj_player1.state != states.taxi && sprite_index == spr_taxiidle)
{
    obj_player1.visible = false;
    obj_player1.sprite_index = get_charactersprite("spr_idle", obj_player1);
    obj_player1.hsp = 0;
    obj_player1.vsp = 0;
    obj_player1.state = states.taxi;
    playerid = obj_player1;
    sprite_index = spr_taximove;
    hsp = 10;
}

if (obj_player2.state != states.taxi && sprite_index == spr_taxiidle)
{
    obj_player2.sprite_index = get_charactersprite("spr_idle", obj_player2);
    playerid = obj_player2;
    sprite_index = spr_taximove;
    hsp = 10;
    obj_player2.visible = false;
    obj_player2.hsp = 0;
    obj_player2.vsp = 0;
    obj_player2.state = states.taxi;
}
