if (hurted == 0 && (cutscene == 0 && ((state != states.unknown27 && sprite_index != spr_bombpep_end) && (state != states.Sjump && state != states.Sjumpprep))))
{
    if (state == states.unknown24 || state == states.unknown25)
    {
        with (instance_create(x, y, obj_knightdebris))
            image_index = 0;
        
        with (instance_create(x, y, obj_knightdebris))
            image_index = 1;
        
        with (instance_create(x, y, obj_knightdebris))
            image_index = 2;
        
        with (instance_create(x, y, obj_knightdebris))
            image_index = 3;
        
        with (instance_create(x, y, obj_knightdebris))
            image_index = 4;
        
        with (instance_create(x, y, obj_knightdebris))
            image_index = 5;
        
        if (x != other.x)
            obj_player.hsp = sign(x - other.x) * 5;
    }
    
    image_index = 0;
    hurted = 1;
    vsp = -4;
    sprite_index = spr_bombpepend;
    state = states.unknown27;
    bombpeptimer = 0;
}
