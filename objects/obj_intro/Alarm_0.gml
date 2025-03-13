if (!instance_exists(obj_fadeout))
{
    with (obj_player)
    {
        state = 8;
        targetRoom = rm_titleselect;
    }
    
    instance_create(0, 0, obj_fadeout);
}
