function triangle_meeting(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7)
{
    var old_x = x;
    var old_y = y;
    x = argument0;
    y = argument1;
    
    if (rectangle_in_triangle(bbox_left, bbox_top, bbox_right, bbox_bottom, argument2, argument3, argument4, argument5, argument6, argument7) > 0)
    {
        x = old_x;
        y = old_y;
        return true;
    }
    
    x = old_x;
    y = old_y;
    return false;
}
