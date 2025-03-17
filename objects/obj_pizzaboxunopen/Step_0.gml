if ((place_meeting(x, y, obj_player) || (instance_exists(obj_cappy) && place_meeting(x, y, obj_cappy))) && sprite_index == spr_pizzaboxunopen)
{
    with (obj_player1)
    {
        if (irandom(100) <= 50)
            fmod_studio_event_instance_start(happyvoice);
    }
    
    var plushie = false;
    
    if (content == obj_pizzakinshroom || content == obj_pizzakincheese || content == obj_pizzakintomato || content == obj_pizzakinsausage || content == obj_pizzakinpineapple)
        plushie = true;
    
    if (content == obj_noisebomb)
    {
        with (obj_player)
        {
            state = states.backbreaker;
            sprite_index = get_charactersprite("spr_bossintro");
            image_index = 0;
        }
        
        instance_create(x, y, obj_taunteffect);
        instance_create(x, y + 600, obj_itspizzatime);
        global.panic = 1;
        global.wave = 0;
        global.maxwave = ((global.minutes * 60) + global.seconds) * 60;
        
        if (global.panicbg)
            scr_panicbg_init();
    }
    
    if (content == obj_pizzakinshroom)
    {
        with (instance_create(x, y, obj_smallnumber))
            number = "1000";
        
        if (place_meeting(x, y, obj_player1))
            global.collect += 1000;
        else
            global.collectN += 1000;
        
        instance_create(x, y, obj_taunteffect);
        
        with (instance_create(x, y - 25, content))
            sprite_index = spr_toppinshroom_intro;
        
        tv_trigger_expression("spr_tvplushie1", 60, 1000);
        global.combotime = 60;
        
        if (global.toppintotal < 5)
            obj_tv.message = "NECESITAS " + string(5 - global.toppintotal) + " MAS PELUCHES!";
        
        if (global.toppintotal == 5)
            obj_tv.message = "TIENES TODOS LOS PELUCHES!";
        
        obj_tv.showtext = 1;
        obj_tv.alarm[0] = 150;
        global.toppintotal += 1;
        global.shroomfollow = 1;
    }
    
    if (content == obj_pizzakincheese)
    {
        with (instance_create(x, y, obj_smallnumber))
            number = "1000";
        
        if (place_meeting(x, y, obj_player1))
            global.collect += 1000;
        else
            global.collectN += 1000;
        
        with (instance_create(x, y - 25, content))
            sprite_index = spr_toppincheese_intro;
        
        instance_create(x, y, obj_taunteffect);
        tv_trigger_expression("spr_tvplushie2", 60, 1000);
        global.combotime = 60;
        
        if (global.toppintotal < 5)
            obj_tv.message = "NECESITAS " + string(5 - global.toppintotal) + " MAS PELUCHES!";
        
        if (global.toppintotal == 5)
            obj_tv.message = "TIENES TODOS LOS PELUCHES!";
        
        obj_tv.showtext = 1;
        obj_tv.alarm[0] = 150;
        global.toppintotal += 1;
        global.cheesefollow = 1;
    }
    
    if (content == obj_pizzakintomato)
    {
        with (instance_create(x, y, obj_smallnumber))
            number = "1000";
        
        if (place_meeting(x, y, obj_player1))
            global.collect += 1000;
        else
            global.collectN += 1000;
        
        with (instance_create(x, y - 25, content))
            sprite_index = spr_toppintomato_intro;
        
        instance_create(x, y, obj_taunteffect);
        tv_trigger_expression("spr_tvplushie3", 60, 1000);
        global.combotime = 60;
        
        if (global.toppintotal < 5)
            obj_tv.message = "NECESITAS " + string(5 - global.toppintotal) + " MAS PELUCHES!";
        
        if (global.toppintotal == 5)
            obj_tv.message = "TIENES TODOS LOS PELUCHES!";
        
        obj_tv.showtext = 1;
        obj_tv.alarm[0] = 150;
        global.toppintotal += 1;
        global.tomatofollow = 1;
    }
    
    if (content == obj_pizzakinsausage)
    {
        with (instance_create(x, y, obj_smallnumber))
            number = "1000";
        
        if (place_meeting(x, y, obj_player1))
            global.collect += 1000;
        else
            global.collectN += 1000;
        
        global.combotime = 60;
        
        with (instance_create(x, y - 25, content))
            sprite_index = spr_toppinsausage_intro;
        
        instance_create(x, y, obj_taunteffect);
        tv_trigger_expression("spr_tvplushie4", 60, 1000);
        obj_tv.showtext = 1;
        obj_tv.alarm[0] = 150;
        global.toppintotal += 1;
        global.sausagefollow = 1;
    }
    
    if (content == obj_pizzakinpineapple)
    {
        with (instance_create(x, y, obj_smallnumber))
            number = "1000";
        
        if (place_meeting(x, y, obj_player1))
            global.collect += 1000;
        else
            global.collectN += 1000;
        
        with (instance_create(x, y - 25, content))
            sprite_index = spr_toppinpineapple_intro;
        
        instance_create(x, y, obj_taunteffect);
        tv_trigger_expression("spr_tvplushie5", 60, 1000);
        global.combotime = 60;
        ds_list_add(global.saveroom, id);
        obj_tv.showtext = 1;
        obj_tv.alarm[0] = 150;
        global.toppintotal++;
        global.pineapplefollow = 1;
    }
    
    if (plushie)
    {
        if (global.toppintotal == 6)
            txt = langstr_get("plushie_text3");
        else if (global.toppintotal == 5)
            txt = langstr_get("plushie_text2");
        else
            txt = langstr_get("plushie_text1");
        
        var txt = embed_value_string(txt, [6 - global.toppintotal]);
        create_transfotext(txt, texteffect.crazyshake);
        fmod_studio_event_oneshot_3d("event:/sfx/level_structure/collects/plushie");
    }
    
    instance_destroy();
}

if (sprite_index == spr_pizzaboxopen && floor(image_index) == 16)
    instance_destroy();
