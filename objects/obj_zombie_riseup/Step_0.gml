var spr = object_get_sprite(obj_array[num]);
var spr_h = sprite_get_height(spr);
var offset = spr_h / 2;
shake = clamp(shake, 0, 2);
zombie_y = clamp(zombie_y, 0, spr_h);

if (sprite_index == spr_riseupdirt_start && animation_end())
    sprite_index = spr_riseupdirt;

if (sprite_index == spr_riseupdirt)
{
    shake = 2;
    
    if (zombie_y < spr_h)
        zombie_y += 1;
    
    if (zombie_y == spr_h)
    {
        var inst = instance_create(x, y, obj_array[num]);
        
        with (obj_zombiearena)
            ds_list_add(zombie_list, inst.id);
        
        if (num_max == 1)
        {
            instance_destroy();
        }
        else if (num < (num_max - 1))
        {
            zombie_y = 0;
            num++;
        }
        else
        {
            instance_destroy();
        }
    }
}
