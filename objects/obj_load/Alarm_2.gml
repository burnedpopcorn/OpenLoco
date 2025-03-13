instance_deactivate_all(true);
var activeObjects = [obj_fmod_studio_manager, obj_parrallax, obj_music, obj_gmlive, obj_screen, obj_inputAssigner];
array_foreach(activeObjects, function(argument0, argument1)
{
    instance_activate_object(argument0);
});

for (var i = 0; i < array_length(texgroups); i++)
{
    if (texturegroup_get_status(texgroups[i]) == 1 || texturegroup_get_status(texgroups[i]) == 0)
    {
        if (texturegroup_get_status(texgroups[i]) == 0)
            texturegroup_load(texgroups[i]);
        
        alarm[2] = 3;
        exit;
    }
}

instance_activate_all();
drawscreen = false;

with (instance_create(0, 0, transition_object))
{
    resettimer = true;
    targetRoom = obj_player1.roomafter;
}

instance_destroy();
