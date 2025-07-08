with (obj_player1)
{
    if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && (obj_player1.state == states.mach3 || obj_player1.state == states.knightpepslopes || obj_player1.state == states.cape))
        instance_destroy(other.id);
}

if (place_meeting(x, y + 1, obj_player1) || (place_meeting(x, y - 1, obj_player1) || (place_meeting(x - 1, y, obj_player1) || place_meeting(x + 1, y, obj_player1))))
{
    if ((place_meeting(x, y - 1, obj_player1) && (obj_player1.state == states.freefall && obj_player1.freefallsmash >= 10)) && sprite_index != get_charactersprite("spr_rockethitwall"))
        instance_destroy();
    
    if (place_meeting(x, y + obj_player1.vsp, obj_player1) && (obj_player1.state == states.freefall && sprite_index == get_charactersprite("spr_rockethitwall")))
        instance_destroy();
    
    if (place_meeting(x, y - 1, obj_player1) && (obj_player1.state == states.knightpep || obj_player1.state == 9))
    {
        instance_destroy();
        tile_layer_delete_at(1, x, y);
    }
}

with (obj_player2)
{
    if ((place_meeting(x + hsp, y, other.id) || place_meeting(x + xscale, y, other.id)) && (obj_player2.state == states.mach3 || obj_player2.state == states.knightpepslopes || obj_player2.state == states.cape))
        instance_destroy(other.id);
}

if (place_meeting(x, y + 1, obj_player2) || (place_meeting(x, y - 1, obj_player2) || (place_meeting(x - 1, y, obj_player2) || place_meeting(x + 1, y, obj_player2))))
{
    if (place_meeting(x, y - 1, obj_player2) && (obj_player2.state == states.freefall && obj_player2.freefallsmash >= 10))
        instance_destroy();
    
    if (place_meeting(x, y - 1, obj_player2) && (obj_player2.state == states.knightpep || obj_player2.state == 9))
    {
        instance_destroy();
        tile_layer_delete_at(1, x, y);
    }
}
