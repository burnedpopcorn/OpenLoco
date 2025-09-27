function scr_destroy_destructibles(_x, _y)
{
    var _num = instance_place_list(x + _x, y + _y, obj_destructibles, global.instancelist, 0);
    
    if (_num > 0)
    {
        for (var i = 0; i < ds_list_size(global.instancelist); i++)
            instance_destroy(global.instancelist[| i]);
        
        ds_list_clear(global.instancelist);
    }
}
