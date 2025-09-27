event_inherited();
spr_idle = Door;

step_func = function()
{
    var zombeh = instance_nearest(x, y, obj_zombie);
    
    if (zombeh != noone)
    {
        var distancia = point_distance(x, y, zombeh.x, zombeh.y);
        
        if (distancia < 75)
        {
            instance_create(x, y, obj_explosioneffect);
            fmod_studio_event_oneshot_3d("event:/sfx/misc/explosion", x, y);
            
            with (zombeh)
                instance_destroy();
            
            global.combotime = 60;
            instance_destroy();
        }
    }
};
