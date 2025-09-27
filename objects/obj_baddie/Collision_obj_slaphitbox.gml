instance_create(x + (obj_player1.xscale * 40), y, obj_punchdust);

with (obj_player)
{
    if (state == states.handstandjump)
    {
        image_index = 0;
        sprite_index = get_charactersprite("spr_haulingstart");
        
        if (other.heavy == 1)
            heavy = 1;
        else
            heavy = 0;
        
        state = states.grab;
    }
}

if (obj_player.state != states.zombieattack)
{
    state = states.capefall;
    instance_destroy(other.id);
}
else
{
    global.combotime = 60;
    instance_destroy();
}
