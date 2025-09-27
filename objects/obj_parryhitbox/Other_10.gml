var myplayer = obj_player1.id;

if (player_id == 2)
    myplayer = obj_player2.id;

with (myplayer)
{
    if (state != states.parrying)
    {
        fmod_studio_event_oneshot_3d("event:/sfx/player/taunt/parry");
        fmod_studio_event_instance_stop(tauntsnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
        fmod_studio_event_instance_stop(supertauntsnd, FMOD_STUDIO_STOP_MODE.IMMEDIATE);
    }
    
    state = states.parrying;
    sprite_index = choose(get_charactersprite("spr_parry1"), get_charactersprite("spr_parry2"), get_charactersprite("spr_parry3"));
    image_index = 0;
    image_speed = 0.35;
    taunttimer = 20;
    movespeed = 8;
    parry_inst = noone;
    parry_count = parry_max;
    
    with (instance_create(x, y, obj_parryeffect))
        image_xscale = other.xscale;
    
    with (instance_create(x, y, obj_taunteffect))
    {
        player = other.id;
        image_speed = other.styledtaunting ? 0.65 : 0.35;
    }
    
    flash = 1;
}

alarm[0] = die_time;
collisioned = 1;
