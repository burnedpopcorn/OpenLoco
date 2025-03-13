if (circlein == 1)
{
    radious = Approach(radious, 0, 0.25);
    
    if (radious == 0 && alarmuse == 0)
    {
        alarm[0] = 100;
        alarmuse = 1;
    }
}

if (circleout == 1)
{
    if (playerendedit == 0)
    {
        radious = lerp(radious, 2, 0.07);
    }
    else
    {
        if (!notagain)
        {
            fmod_studio_event_oneshot("event:/sfx/transitions/circleout");
            notagain = 1;
        }
        
        radious = lerp(radious, 18, 0.07);
    }
    
    if (radious >= 17.5)
        instance_destroy();
}

if (surface_exists(surf))
{
    surface_set_target(surf);
    draw_set_color(c_black);
    draw_set_alpha(1);
    draw_rectangle(0, 0, room_width, room_height, false);
    draw_set_blend_mode(bm_subtract);
    draw_set_color(c_white);
    draw_set_alpha(1);
    
    if (circlein == 0)
        draw_sprite_ext(spr_damianfacehole, -1, obj_player1.x - camera_get_view_x(view_camera[0]), obj_player1.y - camera_get_view_y(view_camera[0]), other.radious, other.radious, 0, c_white, 1);
    else
        draw_sprite_ext(spr_damianfacehole, -1, camera_get_view_width(view_camera[0]) / 2, camera_get_view_height(view_camera[0]) / 2, other.radious, other.radious, 0, c_white, 1);
    
    draw_set_blend_mode(bm_normal);
    draw_set_alpha(1);
    surface_reset_target();
}
else
{
    surf = surface_create(room_width, room_height);
    surface_set_target(surf);
    draw_clear_alpha(c_black, 0);
    surface_reset_target();
}
