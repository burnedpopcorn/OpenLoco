function scr_player_finishingblow()
{
    hsp = movespeed;
    move = key_right + key_left;
    
    if (floor(image_index) < 4 && sprite_index != get_charactersprite("spr_swingdingend"))
        movespeed = Approach(movespeed, 0, 1);
    else
        movespeed = Approach(movespeed, -xscale * 4, 0.5);
    
    if (floor(image_index) == (image_number - 1))
    {
        movespeed = 0;
        state = states.normal;
    }
    
    if (floor(image_index) == 0 && !instance_exists(obj_swordhitbox))
    {
        fmod_studio_event_oneshot_3d("event:/sfx/player/punch");
        fmod_studio_event_oneshot_3d("event:/sfx/player/misc/kill");
        
        with (par_plant)
        {
            if (grabber == other.id)
            {
                hsp = (other.sprite_index != get_charactersprite("spr_uppercutfinishingblow")) ? (9 * other.xscale) : 0;
                vsp = (other.sprite_index == get_charactersprite("spr_uppercutfinishingblow")) ? -11 : 0;
                grabber = noone;
            }
        }
        
        with (instance_create(x, y, obj_swordhitbox))
            playerid = other.object_index;
    }
    
    image_speed = 0.4;
    landAnim = 0;
    
    if (!instance_exists(obj_dashcloud2) && grounded && movespeed > 3)
    {
        with (instance_create(x, y, obj_dashcloud2))
            image_xscale = other.xscale;
    }
    
    image_speed = 0.35;
    landAnim = 0;
}
