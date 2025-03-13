if (ds_list_find_index(global.baddieroom, id) == -1)
{
    ds_list_add(global.baddieroom, id);
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_slapstar);
    instance_create(x, y, obj_baddiegibs);
    instance_create(x, y, obj_baddiegibs);
    instance_create(x, y, obj_baddiegibs);
    instance_create(x, y + 30, obj_bangeffect);
    
    if (obj_player.state == states.handstandjump && (obj_player.sprite_index != get_charactersprite("spr_suplexmash1") && (obj_player.sprite_index != get_charactersprite("spr_suplexmash2") && (obj_player.sprite_index != get_charactersprite("spr_suplexmash3") && obj_player.sprite_index != get_charactersprite("spr_suplexmash4")))))
    {
        obj_player.sprite_index = get_charactersprite("spr_suplexmash" + string(irandom_range(1, 5)));
        image_index = 0;
    }
    
    if (stomped == 0 && shot == 0)
    {
        with (obj_camera)
        {
            shake_mag = 5;
            shake_mag_acc = 20 / room_speed;
        }
        
        with (instance_create(x, y, obj_sausageman_dead))
            sprite_index = spr_piraneapple_dead;
    }
    
    if (stomped == 1 && shot == 0)
    {
        with (instance_create(x, y, obj_sausageman_dead))
            sprite_index = spr_piraneapple_dead;
        
        with (obj_camera)
        {
            shake_mag = 5;
            shake_mag_acc = 20 / room_speed;
        }
        
        hsp = 0;
        vsp = 0;
    }
    
    if (shot == 1 && stomped == 0)
    {
        with (instance_create(x, y, obj_sausageman_dead))
            sprite_index = spr_piraneapple_dead;
        
        with (obj_camera)
        {
            shake_mag = 20;
            shake_mag_acc = 40 / room_speed;
        }
        
        hsp *= 3;
        vsp *= 3;
    }
    
    global.combo += 1;
    global.combotime = 60;
    fmod_studio_event_oneshot_3d("event:/sfx/player/punch");
}
