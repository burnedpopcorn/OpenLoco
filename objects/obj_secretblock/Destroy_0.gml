if (ds_list_find_index(global.saveroom, id) == -1)
{
    repeat (2)
    {
        with (create_debris(x + random_range(0, sprite_width), y + random_range(0, sprite_height), particlespr))
        {
            hsp = random_range(-5, 5);
            vsp = random_range(-10, 10);
            image_speed = 0.35;
        }
    }
    
    with (instance_create(x + random_range(0, sprite_width), y + random_range(0, sprite_height), obj_parryeffect))
    {
        sprite_index = spr_deadjohnsmoke;
        image_speed = 0.35;
    }
    
    fmod_studio_event_instance_start(breaksound);
    ds_list_add(global.saveroom, id);
}

for (var i = 0; i < array_length(target_tiles); i++)
    scr_destroy_tiles(32, target_tiles[i]);

scr_cutoff();
scr_destroy_nearby_tiles();
