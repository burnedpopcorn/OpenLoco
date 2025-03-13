if (needofsave == 1)
{
    repeat (8)
    {
        with (create_debris(x + random_range(0, 64), y + random_range(0, 64), spr_towerblockdebris, 1))
        {
            hsp = random_range(-5, 5);
            vsp = random_range(-10, 10);
            image_speed = 0.35;
        }
    }
    
    repeat (3)
    {
        with (instance_create(x + random_range(0, 64), y + random_range(0, obj_bulletdisappear), obj_parryeffect))
        {
            sprite_index = spr_deadjohnsmoke;
            image_speed = 0.35;
        }
    }
    
    fmod_studio_event_oneshot_3d("event:/sfx/level_structure/destroy");
    ini_open_from_string(obj_savesystem.ini_str);
    
    if (ini_read_real("Custene", "plantwall", 0) == 0)
    {
        global.custeneplantwall = 1;
        ini_write_real("Custene", "plantwall", 1);
    }
    
    obj_savesystem.ini_str = ini_close();
    gamesave_async_save();
}
