if (ds_list_find_index(global.saveroom, id) == -1)
{
    fmod_studio_event_oneshot_3d("event:/sfx/level_structure/destroy");
    
    with (instance_create(x + sprite_xoffset, y, obj_sausageman_dead))
    {
        image_blend = other.image_blend;
        sprite_index = other.spr_dead;
    }
    
    var x1 = (x - sprite_xoffset) + (sprite_width / 2);
    var y1 = (y - sprite_yoffset) + (sprite_height / 2);
    
    repeat (3)
    {
        with (create_debris(x1, y1, spr_slapstar))
        {
            hsp = random_range(-5, 5);
            vsp = random_range(-10, 10);
        }
    }
    
    instance_create(x1, y1, obj_bangeffect);
    global.combotime = 60;
    global.heattime = 60;
    global.combo += 1;
    
    with (obj_player1)
        supercharge += 1;
    
    var combototal = 10 + floor(global.combo * 0.5);
    global.collect += combototal;
    global.comboscore += combototal;
    ds_list_add(global.saveroom, id);
}
