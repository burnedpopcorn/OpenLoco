var _destroyed = 0;

if (ds_list_find_index(global.baddieroom, id) != -1)
{
    _destroyed = 1;
    instance_destroy();
}

if (persistent == true)
{
    if (boundbox == 1)
        boundbox = 0;
}

if (escape == 1 && !_destroyed && persistent == false)
{
    var b = 0;
    
    with (obj_escapespawn)
    {
        if (baddieID == other.id && state != spawnbaddies.idle && state != spawnbaddies.checkplayer)
            b = 1;
    }
    
    if (!b)
    {
        instance_deactivate_object(id);
        
        with (instance_create(x, y, obj_escapespawn))
            baddieID = other.id;
    }
}

if ((under || underescape) && !_destroyed && persistent == false)
{
    var b = 0;
    
    with (obj_enemycovered)
    {
        if (baddieID == other.id && dissapear == 1)
            b = 1;
    }
    
    if (!b)
    {
        instance_deactivate_object(id);
        
        with (instance_create(x - 18, y + 18, obj_enemycovered))
        {
            baddieID = other.id;
            
            if (other.underescape == 1)
                escape = 1;
        }
    }
}

if (global.laps >= 3 && global.laps < 5)
{
    elite = 1;
    elitehit = 2;
    maxelitehit = elitehit;
}

if (global.laps >= 5)
{
    elite = 1;
    elitehit = 4;
    maxelitehit = elitehit;
}
