if (vsp > 0)
{
    instance_destroy();
    instance_destroy(obj_pizzaballblock);
    obj_player.state = states.backbreaker;
    obj_player.sprite_index = get_charactersprite("spr_levelcomplete");
    obj_player.image_index = 0;
}
