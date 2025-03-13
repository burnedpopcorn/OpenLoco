with (instance_create(x, y, obj_fadeout))
{
    obj_player1.targetRoom = Scootertransition;
    obj_player1.state = states.normal;
    
    if (global.coop == 1)
        obj_player2.state = states.normal;
}
