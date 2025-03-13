var col = place_meeting(x, y, obj_player1);

if (col)
    circle_radius = lerp(circle_radius, 125, 0.15);
else
    circle_radius = lerp(circle_radius, 0, 0.15);
