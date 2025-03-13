function scr_specialplayer_punch()
{
    hsp = xscale * movespeed;
    movespeed = Approach(movespeed, 10, 0.4);
    
    if (!grounded)
        vsp = 0;
    
    if (floor(image_index) == (image_number - 1))
        state = states.normal;
    
    if ((!grounded && ((place_meeting_collision(x + sign(hsp), y) || place_meeting_solid(x + sign(hsp), y)) && (!place_meeting(x + hsp, y, obj_destructibles) && !place_meeting_slope(x + sign(hsp), y)))) || (grounded && ((place_meeting_collision(x + hsp, y - 64) || place_meeting_solid(x + hsp, y - 64)) && (!place_meeting(x + hsp, y, obj_destructibles) && (!place_meeting(x + hsp, y, obj_metalblock) && place_meeting_slope(x, y + 1))))))
    {
        fmod_studio_event_oneshot_3d("event:/sfx/player/misc/bump");
        state = states.normal;
        sprite_index = get_charactersprite("spr_fall");
        xscale *= -1;
        vsp = -5;
        jumpstop = 1;
        movespeed = 6;
    }
    
    if (grounded && (!scr_slope() && ((place_meeting_collision(x + sign(hsp), y) || place_meeting_solid(x + sign(hsp), y)) && (!place_meeting(x + hsp, y, obj_destructibles) && !place_meeting_slope(x + sign(hsp), y) && !place_meeting_slope(x + sign(hsp), y)))))
        xscale *= -1;
}
