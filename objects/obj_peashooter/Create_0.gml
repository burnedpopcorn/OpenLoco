event_inherited();
substate = states.normal;
spr_idle = spr_peashooter_idle;
projectile_speed = 12;

step_func = function()
{
    grabbable = substate != states.shotgun;
    var nearest = instance_nearest(x, y, obj_zombie);
    
    if (instance_exists(nearest))
        zombie_id = collision_rectangle(x, y - (sprite_height / 2), x + (longRangeDistance * image_xscale), y + (sprite_height / 2), nearest, 0, 0);
    else
        zombie_id = noone;
    
    switch (substate)
    {
        case states.normal:
            sprite_index = spr_peashooter_idle;
            
            if (attack_cooldown > 0)
            {
                attack_cooldown--;
            }
            else if (instance_exists(zombie_id))
            {
                image_index = 0;
                sprite_index = spr_peashooter_shoot;
                substate = states.shotgun;
            }
            
            break;
        
        case states.shotgun:
            if (sprite_index == spr_peashooter_shoot)
            {
                if (floor(image_index) <= 4 && !instance_exists(zombie_id))
                    image_speed = -0.35;
                
                if (image_speed == -0.35 && instance_exists(zombie_id))
                    image_speed = 0.35;
                
                if (animation_end(floor(image_index), 5) && attack_cooldown == 0 && image_speed == 0.35)
                {
                    attack_cooldown = 60;
                    xscale_mult = 1.25;
                    
                    with (instance_create(x, y - 20, obj_peashooterbullet))
                    {
                        image_xscale = sign(other.image_xscale);
                        hsp = other.projectile_speed;
                    }
                }
                
                if (animation_end() || (floor(image_index) == 0 && image_speed == -0.35))
                {
                    if (image_speed == -0.35)
                        image_speed = 0.35;
                    
                    image_index = 0;
                    sprite_index = spr_peashooter_idle;
                    substate = states.normal;
                }
            }
            
            break;
    }
};
