if (ds_list_find_index(global.baddieroom, id) == -1 && important == 0)
{
    fmod_studio_event_oneshot_3d("event:/sfx/player/misc/kill");
    scr_sleep(50);
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_baddiegibs);
    instance_create(x, y, obj_baddiegibs);
    instance_create(x, y, obj_baddiegibs);
    
    with (obj_camera)
    {
        shake_mag = 3;
        shake_mag_acc = 3 / room_speed;
    }
    
    with (instance_create(x, y, obj_sausageman_dead))
        sprite_index = other.spr_dead;
    
    image_index = mii_index;
}
else if (ds_list_find_index(global.baddieroom, id) == -1 && important == 1)
{
    scr_sleep(50);
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_baddiegibs);
    instance_create(x, y, obj_baddiegibs);
    instance_create(x, y, obj_baddiegibs);
    
    with (obj_camera)
    {
        shake_mag = 3;
        shake_mag_acc = 3 / room_speed;
    }
    
    with (instance_create(x, y, obj_sausageman_dead))
        sprite_index = other.spr_dead;
    
    image_index = mii_index;
}
