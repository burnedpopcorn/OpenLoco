if (place_meeting(x, y, obj_secretmetalblock) || place_meeting(x, y, obj_secretblock) || place_meeting(x, y, obj_secretbigblock) || place_meeting(x, y, obj_destructibles) || place_meeting(x, y, obj_bigdestructibles) || place_meeting(x, y, obj_metalblock))
    visible = false;
else
    visible = true;

if (place_meeting(x, y, obj_player) || (instance_exists(obj_cappy) && place_meeting(x, y, obj_cappy)))
{
    global.collect += 100;
    create_collect(x, y, sprite_index, 100);
    
    with (instance_create(x, y, obj_smallnumber))
        number = "100";
    
    global.combotime = 60;
    fmod_studio_event_oneshot_3d("event:/sfx/level_structure/collects/big");
    instance_destroy();
    
    if (obj_tv.state != 8)
        tv_trigger_expression("spr_tvcollect", 150, 500);
    
    with (obj_player1)
    {
        if (irandom(100) <= 25)
            fmod_studio_event_instance_start(happyvoice);
    }
}
