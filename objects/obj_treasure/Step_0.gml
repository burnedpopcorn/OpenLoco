if (player == 1)
{
    if (sprite_index == sprgot && obj_player1.state != states.gottreasure)
        instance_destroy();
}

if (player == 2)
{
    if (sprite_index == sprgot && obj_player2.state != states.gottreasure)
        instance_destroy();
}

if (sprite_index != sprgot)
    sprite_index = spridle;

if (place_meeting(x, y, obj_player1) && player == 0)
{
    with (obj_player1)
    {
        treasure_x = x;
        treasure_y = y;
        treasure_room = room;
        ds_list_add(global.saveroom, other.id);
        global.treasure = 1;
        global.combotime = 60;
        hsp = 0;
        vsp = 0;
        
        if (other.sprite_index == other.spridle)
            other.alarm[0] = 150;
        
        if (other.sprite_index == other.spridle)
        {
            state = states.gottreasure;
            sprite_index = get_charactersprite("spr_gottreasure" + string(choose(1, 2)));
            fmod_studio_event_oneshot("event:/sfx/level_structure/treasureget");
        }
        
        other.sprite_index = other.sprgot;
        other.x = obj_player1.x;
        other.y = obj_player1.y - 35;
        other.player = 1;
        ini_close();
    }
}

if (place_meeting(x, y, obj_player2) && player == 0)
{
    with (obj_player2)
    {
        treasure_x = x;
        treasure_y = y;
        treasure_room = room;
        
        if (grounded)
        {
            ds_list_add(global.saveroom, other.id);
            global.treasure = 1;
            hsp = 0;
            vsp = 0;
            
            if (other.sprite_index == other.spridle)
                other.alarm[0] = 150;
            
            if (other.sprite_index == other.spridle)
                state = states.gottreasure;
            
            other.sprite_index = other.sprgot;
            other.x = obj_player2.x;
            other.y = obj_player2.y - 35;
            obj_tv.showtext = 1;
            obj_tv.message = "YOU GOT A TOWER SECRET TREASURE!!!";
            obj_tv.alarm[0] = 200;
            other.player = 2;
            ini_close();
        }
    }
}
