if (other.state == states.zombie)
{
    scr_hurtplayer(other);
    
    repeat (10)
        instance_create(x, y, obj_baddiegibs);
    
    instance_destroy();
}
