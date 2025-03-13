if (waterbuffer > 0)
    waterbuffer--;

if (obj_player1.state == states.mach3 || (obj_player1.state == states.machslide && obj_player1.sprite_index == get_charactersprite("spr_machslideboost3", obj_player1)))
{
    if (place_meeting(x, y - 1, obj_player1))
    {
        if (waterbuffer <= 0)
        {
            with (instance_create(obj_player1.x, obj_player1.y, obj_superdashcloud))
                sprite_index = spr_watereffect;
            
            waterbuffer = 6;
        }
    }
}
