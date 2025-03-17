if (obj_player.state == states.unknown24 || (obj_player.state == states.unknown25 || obj_player.state == states.unknown18))
    sprite_index = spr_swordstonetaken;
else
    sprite_index = spr_swordstone;

if (sprite_index == spr_swordstone && !instance_exists(ID))
{
    with (instance_create(x, y - 20, obj_grabmarker))
        other.ID = id;
}
else if (sprite_index == spr_swordstonetaken && instance_exists(ID))
{
    instance_destroy(ID);
}
