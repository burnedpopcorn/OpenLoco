instance_destroy();

if (!instance_exists(obj_marxbaddie))
{
    with (instance_create(obj_marx.x, obj_marx.y, obj_marxbaddie))
    {
        image_xscale = -obj_marx.image_xscale;
        hsp = xscale * 5;
        vsp = -5;
        state = states.capefall;
        
        if (stunned < 100)
            stunned = 100;
    }
    
    var _bodypart_array = [spr_marx_leftshoeNEW, spr_marx_rightshoeNEW, spr_marx_bowtie, spr_marx_leftwingNEW, spr_marx_rightwingNEW, spr_marx_hexagonleftNEW, spr_marx_hexagonrightNEW];
    var _xposition_array = [obj_marx.leftshoex, obj_marx.rightshoex, obj_marx.tiex, obj_marx.leftwingsx, obj_marx.rightwingsx, obj_marx.lefthexagonx, obj_marx.righthexagonx];
    var _yposition_array = [obj_marx.leftshoey, obj_marx.rightshoey, obj_marx.tiey, obj_marx.leftwingsy, obj_marx.rightwingsy, obj_marx.lefthexagony, obj_marx.righthexagony];
    
    for (var i = 0; i < array_length(_bodypart_array); i++)
    {
        with (instance_create(_xposition_array[i], _yposition_array[i], obj_sausageman_dead))
            sprite_index = _bodypart_array[i];
    }
}

if (instance_exists(obj_marx))
{
    with (obj_marx)
    {
        fmod_studio_event_instance_kill(laser_sound_instance);
        fmod_studio_event_oneshot_3d("event:/sfx/enemy/marx/death");
        instance_destroy();
    }
}

obj_camera.zoom = 1;
obj_camera.spdzooming = 0.035;
