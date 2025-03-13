if (visible)
{
    var dir = point_direction(x, y, obj_player1.x, obj_player1.y);
    var yoffest = Wave(-4, 4, 2, 15);
    x = lerp(x, obj_player1.x - (50 * obj_player1.xscale), 0.2);
    y = lerp(y, (obj_player1.y - 50) + yoffest, 0.2);
    
    if (x != obj_player1.x)
        image_xscale = -sign(x - obj_player1.x);
}
