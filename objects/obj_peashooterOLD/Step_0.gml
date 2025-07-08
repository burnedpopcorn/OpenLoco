scr_collision();

switch (state)
{
    case states.normal:
        if (alarm[0] == -1)
            alarm[0] = shooting_speed;
        
        if (sprite_index == spr_shoot && animation_end())
        {
            image_index = 0;
            sprite_index = spr_idle;
        }
        
        if (sprite_index == spr_shoot && floor(image_index) == 5 && shots_left > 0)
            instance_create(x, y - 20, obj_peashooterbullet).image_xscale = sign(image_xscale);
        
        break;
    
    case states.grabbed:
        x = grabber.x;
        y = (grabber.y - sprite_height) + 10;
        sprite_index = spr_idle;
        image_xscale = grabber.xscale;
        
        if (grabber.state != states.grab && grabber.state != states.superslam)
            state = states.normal;
        
        break;
}
