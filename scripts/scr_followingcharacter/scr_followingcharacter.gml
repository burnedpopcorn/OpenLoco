function following_character_init()
{
    xoffset = 25;
    yoffset = 2;
    LAG_STEPS = 20;
    followqueue = ds_queue_create();
    instakilled = 0;
    dir = obj_player1.xscale;
    space = 0;
    maxspace = 1;
    spaceaccel = 0.2;
    lastplayerposx = obj_player1.x;
    lastplayerposy = obj_player1.y;
    hsp = 0;
    vsp = 0;
    hsp_carry = 0;
    vsp_carry = 0;
    platformid = noone;
    grav = 0.5;
    grounded = 0;
    use_collision = 0;
    interp = 0.05;
    lock = 0;
    depth = -6;
}

function following_character_delete()
{
    var p = ds_list_find_index(global.followerlist, id);
    
    if (p != -1)
    {
        ds_list_delete(global.followerlist, p);
        var _id = id;
        
        with (obj_followcharacter)
        {
            if (id != _id)
            {
                pos = ds_list_find_index(global.followerlist, id);
                followid = (pos > 0) ? global.followerlist[| pos - 1] : noone;
            }
        }
    }
}

function following_character_calculate()
{
    with (obj_followcharacter)
    {
        pos = ds_list_find_index(global.followerlist, id);
        followid = (pos > 0) ? global.followerlist[| pos - 1] : noone;
    }
}

function following_add_to_front()
{
    if (ds_list_find_index(global.followerlist, id) != -1)
        ds_list_delete(global.followerlist, ds_list_find_index(global.followerlist, id));
    
    ds_list_insert(global.followerlist, 0, id);
    pos = ds_list_find_index(global.followerlist, id);
    followid = (pos > 0) ? global.followerlist[| pos - 1] : noone;
    following_character_calculate();
}

function following_has_follower(argument0)
{
    for (var i = 0; i < ds_list_size(global.followerlist); i++)
    {
        var b = global.followerlist[| i];
        
        if (instance_exists(b) && b.object_index == argument0)
            return true;
    }
    
    return false;
}

function following_count(argument0)
{
    var n = 0;
    
    for (i = 0; i < ds_list_size(global.followerlist); i++)
    {
        b = global.followerlist[| i];
        
        if (instance_exists(b) && b.object_index == argument0)
            n++;
    }
    
    return n;
}
