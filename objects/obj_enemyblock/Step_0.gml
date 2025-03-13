with (obj_baddie)
{
    if (place_meeting(x + hsp, y, obj_enemyblock) && thrown == 1)
        instance_destroy(instance_place(x + hsp, y, obj_enemyblock));
    
    if (place_meeting(x, y + vsp, obj_enemyblock) && thrown == 1)
        instance_destroy(instance_place(x, y + vsp, obj_enemyblock));
}
