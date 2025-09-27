if (title_instance == noone)
    exit;

title_x = Approach(title_x, 0, 30);
fade_alpha -= 0.1;

if (!fmod_studio_event_instance_is_valid(title_instance) && !instance_exists(obj_fadecircle) && !instance_exists(obj_load))
{
    with (instance_create(0, 0, obj_load))
    {
        var _groups = ["baddie_group", "levelstructure_group"];
        array_push(_groups, other.texgroups);
        texgroups = _groups;
        
        transition_obj_cc = function()
        {
            trace("Do  you even run");
            resettimer = true;
            targetRoom = obj_player1.roomafter;
        };
    }
}
