function scr_enemy_idle()
{
    if (vsp > 1 && (grounded || (grounded && !place_meeting(x, y, obj_platform))))
    {
        instance_create(x, y, obj_landcloud);
        image_index = 0;
    }
    
    if (vsp >= 0 && (sprite_index == scaredspr && grounded && scaredbuffer <= 0))
    {
        state = states.actor;
        sprite_index = walkspr;
    }
    
    if ((object_index == obj_ancho || object_index == obj_zombiewater) && (sprite_index == scaredspr && floor(image_index) == (image_number - 1)))
        state = states.actor;
    
    if (object_index == obj_shyguy && (sprite_index == spr_forknight_turn && floor(image_index) == (image_number - 1)))
        state = states.actor;
    
    if (object_index == obj_zombie && (sprite_index == spr_forknight_turn && floor(image_index) == (image_number - 1)))
        state = states.actor;
    
    if ((grounded || (grounded && !place_meeting(x, y, obj_platform))) && vsp > 0)
        hsp = 0;
    
    if (!(grounded || (grounded && !place_meeting(x, y, obj_platform))) && hsp < 0)
        hsp += 0.1;
    else if (!(grounded || (grounded && !place_meeting(x, y, obj_platform))) && hsp > 0)
        hsp -= 0.1;
    
    if (scaredbuffer > 0)
        scaredbuffer--;
    
    image_speed = 0.35;
}
