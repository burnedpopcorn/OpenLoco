if (ds_list_find_index(global.saveroom, id) == -1 && global.snickchallenge == 0)
{
    activate_escape();
    fmod_studio_event_oneshot("event:/sfx/level_structure/pillarkill");
    obj_camera.alarm[1] = 60;
    instance_create(x, y, obj_bangeffect);
    
    repeat (3)
        instance_create(x, y, obj_slapstar);
    
    repeat (3)
        instance_create(x, y, obj_baddiegibs);
    
    with (obj_camera)
    {
        zoom = 1;
        spdzooming = 0.035;
        shake_mag = 3;
        shake_mag_acc = 3 / room_speed;
    }
    
    if (state == pillar.hit)
    {
        with (instance_create(obj_player1.x + (obj_player1.xscale * 15), obj_player1.y, obj_genericpoofeffect))
        {
            sprite_index = spr_bombexplosion;
            image_index = 0;
            image_speed = 0.35;
        }
    }
    
    var i = 0;
    
    for (i = 0; i < 5; i++)
    {
        with (instance_create(x - 64, y + 112, obj_sausageman_dead))
        {
            sprite_index = spr_patrickpillardebris;
            image_index = i;
            vsp = random_range(-2, -4);
            hsp = sign(x - obj_player.x) * random_range(4, 8);
        }
    }
    
    ds_list_add(global.saveroom, id);
}
