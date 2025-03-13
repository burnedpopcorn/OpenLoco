scr_getinput2();
event_inherited();

if (!global.coop)
{
    obj_player1.spotlight = true;
    x = -1000;
    y = 500;
    state = states.titlescreen;
    
    if (instance_exists(obj_coopflag))
        instance_destroy(obj_coopflag);
    
    if (instance_exists(obj_cooppointer))
        instance_destroy(obj_cooppointer);
}
