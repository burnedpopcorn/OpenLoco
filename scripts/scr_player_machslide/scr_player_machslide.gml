function scr_player_machslide()
{
    if (!place_meeting(x, y + 1, obj_railh) && !place_meeting(x, y + 1, obj_railh2))
        hsp = xscale * movespeed;
    else if (place_meeting(x, y + 1, obj_railh))
        hsp = (xscale * movespeed) - 5;
    else if (place_meeting(x, y + 1, obj_railh2))
        hsp = (xscale * movespeed) + 5;
    
    move = key_right + key_left;
    
    if (movespeed >= 0)
    {
        if (character == "P")
            movespeed -= 0.4;
        else
            movespeed -= 0.3;
    }
    
    if (floor(image_index) == (image_number - 1) && (sprite_index == get_charactersprite("spr_machslideboost") || sprite_index == get_charactersprite("spr_machslideboost3")))
        image_speed = 0;
    else
        image_speed = 0.35;
    
    if (sprite_index == get_charactersprite("spr_machslidestart") && floor(image_index) == (image_number - 1))
        sprite_index = get_charactersprite("spr_machslide");
    
    landAnim = 0;
    
    if (floor(movespeed) <= 0 && (sprite_index == get_charactersprite("spr_machslide") || sprite_index == get_charactersprite("spr_crouchslide")))
    {
        var grabithegrab = false;
        
        with (par_plant)
        {
            if (grabber == other.id)
            {
                grabithegrab = true;
                state = states.grabbed;
            }
        }
        
        trace("grabithegrabo:", grabithegrab);
        state = (grabithegrab == true) ? states.grab : states.normal;
        image_index = 0;
        
        if (sprite_index == get_charactersprite("spr_machslide"))
            machslideAnim = 1;
        
        movespeed = 0;
    }
    
    if (scr_solid(x + xscale, y) && (sprite_index == get_charactersprite("spr_machslide") || sprite_index == get_charactersprite("spr_machslidestart")) && !place_meeting_slope(x - sign(hsp), y) && !place_meeting_slope(x + sign(hsp), y))
    {
        var _bump = ledge_bump((vsp >= 0) ? 32 : 22);
        
        if (_bump)
        {
            fmod_studio_event_oneshot_3d("event:/sfx/player/misc/bump");
            state = states.bump;
            image_index = 0;
            sprite_index = get_charactersprite("spr_wallsplat");
        }
    }
    
    if (sprite_index == get_charactersprite("spr_crouchslide") && (movespeed == 0 && grounded))
    {
        facehurt = 1;
        state = states.normal;
        sprite_index = get_charactersprite("spr_facehurtup");
    }
    
    if (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_machslideboost") && grounded)
    {
        hsp = 0;
        image_index = 0;
        xscale *= -1;
        movespeed = 8;
        state = states.mach2;
    }
    
    if (floor(image_index) == (image_number - 1) && sprite_index == get_charactersprite("spr_machslideboost3") && grounded)
    {
        hsp = 0;
        sprite_index = get_charactersprite("spr_mach4");
        image_index = 0;
        xscale *= -1;
        movespeed = 12;
        state = states.mach3;
    }
    
    if (mach2 == 0)
    {
        if (!instance_exists(dashcloudid) && grounded)
        {
            with (instance_create(x, y, obj_slidecloud))
            {
                image_xscale = other.xscale;
                other.dashcloudid = id;
            }
        }
    }
    else if (mach2 >= 35)
    {
        if (!instance_exists(dashcloudid) && grounded)
        {
            with (instance_create(x, y, obj_dashcloud))
            {
                image_xscale = other.xscale;
                other.dashcloudid = id;
            }
        }
    }
    else if (mach2 >= 100)
    {
        if (!instance_exists(dashcloudid) && grounded)
        {
            with (instance_create(x, y, obj_dashcloud2))
            {
                image_xscale = other.xscale;
                other.dashcloudid = id;
            }
        }
    }
}
