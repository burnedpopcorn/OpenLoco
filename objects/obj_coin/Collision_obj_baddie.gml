with (other)
{
    var radius = 240;
    
    with (obj_baddie)
    {
        if (id == other.id)
            exit;
        
        var dist = point_distance(x, y, other.x, other.y);
        
        if (dist <= radius)
        {
            other.x = x;
            other.y = y;
            instance_destroy();
        }
    }
}
